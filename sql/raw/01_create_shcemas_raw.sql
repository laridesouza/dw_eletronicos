--- Criando schemas da camada raw

CREATE SCHEMAS IF NOT EXISTS raw;
CREATE SCHEMAS IF NOT EXISTS staging;
CREATE SCHEMAS IF NOT EXISTS dw;

--- RAW: raw_vendas
DROP TABLE IF EXISTS raw.raw_vendas CASCADE;
CREATE TABLE raw.raw_vendas(

    pedido_id       INTEGER,
    data_pedido     VARCHAR(20),
    cliente_id      INTEGER,
    produto_id      INTEGER,
    produto         VARCHAR(100),
    categoria       VARCHAR(50),
    marca           VARCHAR(50),
    quantidade      INTEGER,
    preco_unitario  NUMERIC(12, 2),
    desconto        NUMERIC(12, 2),
    frete           NUMERIC(12, 2),
    valor_total     NUMERIC(12, 2),
    canal_venda     VARCHAR(50),
    forma_pagamento VARCHAR(50),
    cidade          VARCHAR(100),
    estado          CHAR(2),
    status_pedido   VARCHAR(30),
    _loaded_at      TIMESTAMP DEFAULT NOW()
);

--- RAW: raw_devolucoes
DROP TABLE IF EXISTS raw.raw_devolucoes CASCADE;
CREATE TABLE raw.raw_devolucoes(

    devolucao_id         INTEGER, 
    pedido_id            INTEGER,
    data_devolucao       VARCHAR(20),
    cliente_id           INTEGER,
    produto_id           INTEGER,
    quantidade_devolvida INTEGER, 
    valor_devolvido      NUMERIC(12, 2),
    motivo_devolucao     VARCHAR(100),
    status_devolucao     VARCHAR(30),
    _loaded_at           TIMESTAMP DEFAULT NOW()
);

--- RAW: raw_estoque
DROP TABLE IF EXISTS raw.raw_estoque CASCADE;
CREATE TABLE raw.raw_estoque(

    produto_id          INTEGER,
    produto             VARCHAR(100),
    categoria           VARCHAR(50),
    marca               VARCHAR(50),
    fornecedor          VARCHAR(100),
    estoque_inicial     INTEGER,
    entradas_periodo    INTEGER,
    estoque_atual       INTEGER,
    estoque_minimo      INTEGER,
    custo_unitario      NUMERIC(12, 2),
    centro_distribuicao VARCHAR(50),
    _loaded_at          TIMESTAMP DEFAULT NOW()
);

--- Comentários de Documentação
COMMENT ON SCHEMA raw IS 'Dados brutos carregados dos CSVs - sem transformação';
COMMENT ON SCHEMA staging IS 'Dados tratados e padronizados - prontos para o DW';
COMMENT ON SCHEMA dw IS 'Modelo dimensional (Star Schema) - camada analítica';