# 🏥Análise Preditiva e Otimização da Cozinha Hospitalar Pediátrica🧑🏾‍🍳

---

## 📄 Visão Geral do Projeto

Este é um projeto de dados de ponta a ponta que simula um ambiente de produção para analisar, prever e visualizar dados de uma cozinha hospitalar pediátrica. O objetivo principal é utilizar a engenharia e a ciência de dados para reduzir o desperdício de alimentos e melhorar a aceitação das refeições por crianças internadas, transformando dados brutos em insights através de uma analise exploratória dos dados disponiveis.

---

## 🎯 Problema de Negócio

Cozinhas hospitalares enfrentam o duplo desafio de fornecer refeições nutritivas que auxiliem na recuperação dos pacientes e, ao mesmo tempo, operar de forma eficiente, minimizando custos e desperdício. Em um ambiente pediátrico, a rejeição de refeições é um fator crítico que impacta tanto o bem-estar da criança quanto o resultado financeiro da operação. Este projeto busca responder a perguntas como:

- Quais são os principais fatores que levam à rejeição de uma refeição?

- É possível prever com antecedência a probabilidade de um prato ser rejeitado?

- Como podemos apresentar esses insights de forma clara para a equipe de gestão e nutrição?

---

## ✨ Stack de Tecnologias Utilizadas

- Orquestração de Pipeline: Apache Airflow

- Transformação de Dados: dbt (Data Build Tool)

- Data Warehouse: PostgreSQL

- Análise e Machine Learning: Python (Pandas, Scikit-learn, XGBoost, LightGBM)

- Ambiente de Desenvolvimento: Jupyter Notebook

- Visualização: Seaborn e Matplotlib

---

## 🏗️ Arquitetura da Solução

O projeto foi estruturado para simular um fluxo de dados moderno, desde a ingestão até a visualização final:

- Ingestão de Dados (Airflow): Um DAG no Apache Airflow é responsável por carregar os dados brutos (simulados em arquivos CSV) para uma área de staging no banco de dados PostgreSQL.

- Modelagem e Transformação (dbt): O dbt é utilizado para transformar os dados brutos em um modelo dimensional limpo e performático (esquema estrela), criando tabelas de fatos e dimensões que servem como uma "única fonte da verdade" para toda a análise.

- Análise Exploratória e Modelagem Preditiva (Python/Jupyter): Os notebooks Python se conectam ao Data Warehouse (PostgreSQL) para consumir os dados já tratados pelo dbt. Nesta fase, são realizadas a EDA e o treinamento dos modelos de Machine Learning para prever a rejeição de refeições.

- Visualização: Python se conecta diretamente ao Data Warehouse para criar analises valiosas. Isso permite que os usuários de negócio (gestores, nutricionistas) explorem os dados e os resultados do modelo, sem precisar de conhecimento técnico.

---

## ⚙️ Como Configurar e Rodar o Projeto

##### Pré-requisitos
- Docker e Docker Compose (para rodar Airflow e PostgreSQL)

- Python 3.9+

- dbt-core e dbt-postgres

---

### Instalação

1. Clone o repositório:

```bash
git clone https://github.com/seu-usuario/seu-repositorio.git
cd seu-repositorio
```

2. Inicie os serviços com Docker:

(Supondo que você tenha um docker-compose.yml para Airflow e Postgres)

```bash
docker-compose up -d
```

3. Configure o dbt:

- Navegue até a pasta dbt_project/.

- Configure seu arquivo profiles.yml para conectar ao seu banco PostgreSQL.

- Execute os modelos do dbt:

```bash
dbt run
```

4. Configure o ambiente Python:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

5. Execute a Pipeline:

- Acesse a UI do Airflow (geralmente localhost:8080).

- Ative e dispare o DAG de ingestão de dados.

6. Análise e Visualização:

- Abra os notebooks na pasta notebooks/ para ver a EDA e o processo de ML.

- Abra o arquivo .pbix na pasta powerbi/ com o Power BI Desktop e atualize os dados para conectar ao seu banco local.

---

## 📊 Resultados e Principais Insights

#### Análise Exploratória

A faixa etária "Criança" e a ala de "Oncologia" representam os maiores volumes de rejeição.

O café da manhã é a refeição com a maior taxa de desperdício em todas as alas.

#### Machine Learning

Um insight crucial do projeto foi a identificação e correção de um problema de vazamento de dados (data leakage) no modelo inicial, que resultava em uma acurácia irreal de 100%.

Após a correção, o modelo final (usando LightGBM) alcançou um recall de 37% para a classe "Rejeitado", o que significa que ele é capaz de identificar proativamente mais de um terço das refeições que seriam desperdiçadas, permitindo uma intervenção prévia.

---

👨‍💻 Autor

Gabryel Januario

LinkedIn: https:[//www.linkedin.com/in/seu-perfil/](https://www.linkedin.com/in/gabryel-januario/)


