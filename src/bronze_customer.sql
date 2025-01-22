-- This query is executed using Databricks Workflows (see resources/ingestion_sql.job.yml)

USE CATALOG {{catalog}};
USE IDENTIFIER({{schema}});
CREATE TABLE IF NOT EXISTS bronze_customer;
COPY INTO bronze_customer FROM 
(
  SELECT 
    _c0 C_CUSTKEY,
    _c1 C_NAME, 
    _c2 C_ADDRESS, 
    _c3 C_NATIONKEY, 
    _c4 C_PHONE, 
    _c5 C_ACCTBAL,
    _c6 C_MKTSEGMENT, 
    _c7 C_COMMENT,
    current_timestamp() as CREATED_AT
FROM '/Volumes/ft_ingestion/default/retail/retail_raw_data/customer/'
)
FILEFORMAT = CSV 
FORMAT_OPTIONS('header' = 'false', 'inferSchema' = 'true', 'delimiter' = '|')
COPY_OPTIONS ('mergeSchema' = 'true');