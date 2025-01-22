-- This query is executed using Databricks Workflows (see resources/ingestion_sql.job.yml)

USE CATALOG {{catalog}};
USE IDENTIFIER({{schema}});
CREATE TABLE IF NOT EXISTS bronze_line_item;
COPY INTO bronze_line_item FROM 
(
  SELECT 
    _c0 L_ORDERKEY,
    _c1 L_PARTKEY, 
    _c2 L_SUPPKEY, 
    _c3 L_LINENUMBER, 
    _c4 L_QUANTITY, 
    _c5 L_EXTENDEDPRICE,
    _c6 L_DISCOUNT, 
    _c7 L_TAX, 
    _c8 L_RETURNFLAG,
    _c9 L_LINESTATUS,
    _c10 L_SHIPDATE, 
    _c11 L_COMMITDATE,
    _c12 L_SHIPINSTRUCT,
    _c13 L_SHIPMODE,
    _c14 L_COMMENT,
    current_timestamp() as CREATED_AT
FROM '/Volumes/ft_ingestion/default/retail/retail_raw_data/lineitem/'
)
FILEFORMAT = CSV 
FORMAT_OPTIONS('header' = 'false', 'inferSchema' = 'true', 'delimiter' = '|')
COPY_OPTIONS ('mergeSchema' = 'true');