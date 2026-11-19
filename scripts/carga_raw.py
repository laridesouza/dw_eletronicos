from pathlib import Path 
import os 

import pandas as pd

from dotenv import load_dotenv
from config import engine

# Carregar .env

BASE_DIR = Path(__file__).resolve().parent.parent
env_path = BASE_DIR / ".env"

load_dotenv(dotenv_path=env_path)

# Caminhos dos CSV's

PATH_VENDAS = BASE_DIR / os.getenv("PATH_VENDAS")
PATH_ESTOQUE = BASE_DIR / os.getenv("PATH_ESTOQUE")
PATH_DEVOLUCOES = BASE_DIR / os.getenv("PATH_DEVOLUCOES")

# Leitura dos CSV's
df_vendas = pd.read_csv(PATH_VENDAS)
df_estoque = pd.read_csv(PATH_ESTOQUE)
df_devolucoes = pd.read_csv(PATH_DEVOLUCOES)

# Carga Raw - Vendas 
df_vendas.to_sql(
    name="raw_vendas",
    con=engine,
    schema="raw",
    if_exists="append",
    index=False
)
print("RAW vendas carregada com sucesso.")

# Carga Raw - Estoque
df_estoque.to_sql(
    name="raw_estoque",
    con=engine,
    schema="raw",
    if_exists="append",
    index=False
)
print("RAW estoque carregada com sucesso.")

# Carga Raw - Devoluções
df_devolucoes.to_sql(
    name="raw_devolucoes",
    con=engine,
    schema="raw",
    if_exists="append",
    index=False
)
print("RAW devolucoes carregada com sucesso.")