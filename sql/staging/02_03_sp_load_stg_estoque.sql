CREATE OR REPLACE PROCEDURE staging.sp_load_stg_estoque()
LANGUAGE plpgsql AS $$
BEGIN

    INSERT INTO staging.stg_estoque (
        produto_id,
        produto,
        categoria,
        marca,
        fornecedor,
        estoque_inicial,
        entradas_periodo,
        estoque_atual,
        estoque_minimo,
        custo_unitario,
        valor_estoque_total,
        abaixo_minimo,
        centro_distribuicao,
        _loaded_at
    )
    SELECT
        produto_id,
        TRIM(produto),
        TRIM(categoria),
        TRIM(marca),
        TRIM(fornecedor),
        estoque_inicial,
        entradas_periodo,
        estoque_atual,
        estoque_minimo,
        custo_unitario,
        ROUND(estoque_atual * custo_unitario, 2),
        estoque_atual < estoque_minimo,
        TRIM(centro_distribuicao),
        NOW()
    FROM raw.raw_estoque

    ON CONFLICT (produto_id)
    DO UPDATE SET
        produto = EXCLUDED.produto,
        categoria = EXCLUDED.categoria,
        marca = EXCLUDED.marca,
        fornecedor = EXCLUDED.fornecedor,
        estoque_inicial = EXCLUDED.estoque_inicial,
        entradas_periodo = EXCLUDED.entradas_periodo,
        estoque_atual = EXCLUDED.estoque_atual,
        estoque_minimo = EXCLUDED.estoque_minimo,
        custo_unitario = EXCLUDED.custo_unitario,
        valor_estoque_total = EXCLUDED.valor_estoque_total,
        abaixo_minimo = EXCLUDED.abaixo_minimo,
        centro_distribuicao = EXCLUDED.centro_distribuicao,
        _loaded_at = NOW();

    RAISE NOTICE 'stg_estoque carregada com UPSERT.';

END;
$$;