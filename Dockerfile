FROM apache/airflow:3.0.4
USER root
RUN apt-get update && apt-get install -y --no-install-recommends gcc && apt-get clean
USER airflow
RUN pip install --no-cache-dir apache-airflow-providers-postgres sqlalchemy dbt-core dbt-postgres