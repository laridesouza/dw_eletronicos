from pathlib import Path 
import os 

from dotenv import load_dotenv
from sqlalchemy import create_engine, text 

BASE_DIR = Path(__file__).resolve().parent.parent
env_path = BASE_DIR / ".env"

load_dotenv(dotenv_path=env_path)

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5433")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

connection_string = (
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

engine = create_engine(connection_string)

try:
    with engine.connect() as conn:
        conn.execute(text("SELECT 1"))
        print("Conexão com PostgreSQL realizada com sucesso.")
        print(f"Banco conectado: {DB_NAME}")
except Exception as e:
    print("Erro ao conectar no PostgreSQL: ")
    print(e)