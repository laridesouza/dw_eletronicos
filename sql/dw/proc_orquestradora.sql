CREATE OR REPLACE PROCEDURE dw.sp_run_dw()
LANGUAGE plpgsql AS $$
BEGIN

    RAISE NOTICE '======================================';
    RAISE NOTICE 'INICIANDO DATA WAREHOUSE';
    RAISE NOTICE '======================================';

    -- DIMENSOES
    CALL dw.sp_load_dim_tempo();
    CALL dw.sp_load_dim_produto();
    CALL dw.sp_load_dim_cliente();
    CALL dw.sp_load_dim_localidade();
    CALL dw.sp_load_dim_canal_venda();
    CALL dw.sp_load_dim_pagamento();

    -- FATOS
    CALL dw.sp_load_fato_vendas();
    CALL dw.sp_load_fato_devolucoes();
    CALL dw.sp_load_fato_estoque();

    RAISE NOTICE '======================================';
    RAISE NOTICE 'DATA WAREHOUSE CONCLUIDO';
    RAISE NOTICE '======================================';

END;
$$;