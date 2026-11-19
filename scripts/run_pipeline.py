from sqlalchemy import text
from config import engine


def executar_procedure(nome_procedure):
    with engine.begin() as conn:
        conn.execute(text(f"CALL {nome_procedure}();"))

    print(f"Procedure executada: {nome_procedure}")


if __name__ == "__main__":

    print("Iniciando pipeline...")

    executar_procedure("staging.sp_run_staging")
    executar_procedure("dw.sp_run_dw")

    print("Pipeline finalizado com sucesso.")