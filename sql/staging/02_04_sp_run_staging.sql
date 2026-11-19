CREATE OR REPLACE PROCEDURE staging.sp_run_staging()
LANGUAGE plpgsql AS $$
BEGIN

    RAISE NOTICE 'Iniciando carga STAGING';

    CALL staging.sp_load_stg_vendas();
    CALL staging.sp_load_stg_devolucoes();
    CALL staging.sp_load_stg_estoque();

    RAISE NOTICE 'Carga STAGING concluida';

END;
$$;