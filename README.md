# Data Warehouse de Eletrônicos
 
Projeto de Engenharia de Dados que constrói um Data Warehouse do zero a partir de arquivos CSV de **vendas**, **estoque** e **devoluções** de uma operação de eletrônicos. Os dados passam por três camadas e chegam a um modelo dimensional pronto para análise.
 
## Stack
 
Python · PostgreSQL · SQLAlchemy · SQL (procedures) · DBeaver
 
## Arquitetura
 
```
CSVs  ──►  RAW  ──►  STAGING  ──►  DW
          bruto      tratado     analítico
```
 
| Camada | Função |
|---|---|
| **raw** | Dados exatamente como chegam dos CSVs, sem transformação. |
| **staging** | Dados limpos e padronizados, com chaves primárias que impedem duplicidade. |
| **dw** | Modelo dimensional (Star Schema) com tabelas fato e dimensão. |
 
## Modelo dimensional
 
- **Dimensões:** tempo, produto, cliente, localidade, canal de venda e forma de pagamento
- **Fatos:** vendas, devoluções e estoque
## Como funciona
 
- Toda a transformação e carga é feita com **procedures em SQL**, reutilizáveis e chamadas por uma procedure principal que executa o pipeline na ordem certa (dimensões primeiro, fatos depois).
- As cargas usam **UPSERT** (`ON CONFLICT`): se o registro existe, atualiza; se não, insere. Assim o pipeline pode rodar várias vezes sem duplicar dados.
- O Python é usado para conectar ao banco e carregar os CSVs na camada raw.
## Como executar
 
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```
 
Crie um arquivo `.env` na raiz (não o versione) com os dados de conexão:
 
```dotenv
DB_HOST=localhost
DB_PORT=5433
DB_NAME=dw_eletronicos
DB_USER=postgres
DB_PASSWORD=sua_senha
```
 
Teste a conexão e execute o pipeline:
 
```bash
python3 scripts/teste_conexao.py
```
 
```sql
CALL dw.sp_run_dw();
```
 
## Desafio: conexão com o PostgreSQL no WSL
 
A conexão do Python com o PostgreSQL falhava com `Connection refused`. O banco estava instalado no Windows, enquanto o código rodava no WSL, onde `localhost` aponta para o próprio Linux. Como o Windows 10 não oferece o modo de rede espelhada, a solução foi instalar uma instância do PostgreSQL dentro do WSL, na porta 5433 para evitar conflito com a do Windows, e atualizar o `.env`. Como o WSL não mantém o serviço ativo entre sessões, é preciso iniciá-lo com `sudo service postgresql start` ao retomar o trabalho.
 
## Aprendizados
 
- Separar os dados em camadas permite reprocessar tudo sem perder o dado original.
- Chave natural vem da origem; chave surrogada é criada pelo DW para identificar registros nas dimensões.
- UPSERT torna o pipeline idempotente.
