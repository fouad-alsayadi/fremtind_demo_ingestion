-- This query is executed using Databricks Workflows (see resources/ingestion_sql.job.yml)

USE CATALOG {{catalog}};
CREATE DATABASE IF NOT EXISTS IDENTIFIER({{schema}});