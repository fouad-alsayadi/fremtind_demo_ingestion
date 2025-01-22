-- This query is executed using Databricks Workflows (see resources/ingestion_sql.job.yml)

USE CATALOG {{catalog}};
USE IDENTIFIER({{schema}});
CREATE TABLE IF NOT EXISTS bronze_order;
COPY INTO bronze_order FROM 
(
  SELECT 
    _c0 O_ORDERKEY,
    _c1 O_CUSTKEY, 
    _c2 O_ORDERSTATUS, 
    _c3 O_TOTALPRICE, 
    _c4 O_ORDER_DATE, 
    _c5 O_ORDERPRIORITY,
    _c6 O_CLERK, 
    _c7 O_SHIPPRIORITY, 
    _c8 O_COMMENT,
    current_timestamp() as CREATED_AT  
FROM '/Volumes/ft_ingestion/default/retail/retail_raw_data/orders/'
)
FILEFORMAT = CSV 
FORMAT_OPTIONS('header' = 'false', 'inferSchema' = 'true', 'delimiter' = '|')
COPY_OPTIONS ('mergeSchema' = 'true');