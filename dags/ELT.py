from airflow.decorators import dag, task
from airflow.operators.bash import BashOperator
from airflow.models.variable import Variable
from datetime import datetime

def extract_for_parquet(path_in, path_out):
    import pandas as pd 
    import os 

    file_name = os.path.basename(path_in).replace(".csv", "")
    parquet_path = os.path.join(path_out, f"{file_name}.parquet")

    print(f"reading the file (in chunks of): {path_in}")
    chunk_iterator = pd.read_csv(path_in, chunksize=5000)
    df = pd.concat(chunk_iterator, ignore_index=True)

    print(f"Leitura finalizada. Total de {len(df)} linhas. Salvando em: {parquet_path}")
    df.to_parquet(parquet_path, index=False)
    return parquet_path

def load_files_optimized(parquet_path: str, conn_id: str, table_name: str, chunk_size: int = 10000):
    
    import pyarrow.parquet as pq
    import pandas as pd
    from airflow.providers.postgres.hooks.postgres import PostgresHook
    
    hook = PostgresHook(postgres_conn_id=conn_id, autocommit=True)
    engine = hook.get_sqlalchemy_engine(
    engine_kwargs={'isolation_level': 'AUTOCOMMIT'}
)
    
    parquet_file = pq.ParquetFile(parquet_path)
    print(f"Iniciando carga otimizada do arquivo '{parquet_path}' para a tabela '{table_name}'...")
    
    
    iterator = parquet_file.iter_batches(batch_size=chunk_size)
    
    
    print("Processando primeiro chunk...")
    first_batch = next(iterator)
    first_df = first_batch.to_pandas()
    first_df.to_sql(name=table_name, con=engine, if_exists='replace', index=False, schema='public')
    print(f"Primeiro chunk ({len(first_df)} linhas) carregado.")
    
    
    for batch in iterator:
        df_chunk = batch.to_pandas()
        print(f"Processando próximo chunk ({len(df_chunk)} linhas)...")
        df_chunk.to_sql(name=table_name, con=engine, if_exists='append', index=False)
        
    print(f"Carga da tabela '{table_name}' concluída com sucesso!")

@dag(
    dag_id='ELT_pipeline8722',
    start_date=datetime(2023,1,1),
    schedule='@daily',
    catchup=False,
    tags=['elt', 'dbt','hospital_kitchen_project' ]
)
def elt_pipeline_com_dbt():

    
    @task
    def get_input_files_list():
        import os
        path_input_folder = Variable.get("project_data_folder")
        files_csv = [
            os.path.join(path_input_folder, "children.csv"),
            os.path.join(path_input_folder, "consumption.csv"),
            os.path.join(path_input_folder, "ingredients.csv"),
            os.path.join(path_input_folder, "meals.csv")
        ]
        return files_csv

    
    @task
    def get_output_folder_path():
        return Variable.get("project_parquet_folder")

    @task
    def extraction_task(path_in, path_out):
        return extract_for_parquet(path_in, path_out)

    @task
    def load_task(parquet_file_path):
        import os
        table_name = os.path.basename(parquet_file_path).replace('.parquet', '')
        
        
        load_files_optimized(
            parquet_path=parquet_file_path,
            table_name=table_name,
            conn_id='postgres_default'
        )

    dbt_run = BashOperator(
        task_id='run_dbt_transformations',
        bash_command='cd /opt/airflow/transformations && dbt run'
    )
        
    # --- Orquestração do Fluxo ---
    
    input_files = get_input_files_list()
    output_folder = get_output_folder_path()
    
    paths_parquet = extraction_task.expand(
        path_in=input_files,
        path_out=[output_folder]
    )

    load_results = load_task.expand(parquet_file_path=paths_parquet)

    load_results >> dbt_run

elt_pipeline_com_dbt()