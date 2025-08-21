# One Trillion Row Challenge on Apache Impala

## Introduction
In February 2024 [Coiled](https://www.coiled.io/) team published their [One Trillion Row Challenge](https://medium.com/coiled-hq/one-trillion-row-challenge-5bfd4c3b8aef) where they presented their performance test over 1T (One Trillion) rows dataset. The idea of the performance test is to measure performance when reading and aggregating one trillion records based on synthetic temperature measurements dataset.

Apache Impala has accepted the challenge.

## Data Generation
One way to try out Apache Impala on the challenge is to download the original data set from the S3 bucket s3://coiled-datasets-rp/1trc. For simplicity, we also provide a few SQL statements to generate the data. You can find the code in part-1/data-generation.sql.

## Run the challenge
You can find the SQL query of the challenge in part-1/query.sql.

## Run the extended challenge
After running part-1/data-generation.sql, you can run part-2/data-generation.sql to run the challenge on an Iceberg table with lots of delete records that need to be processed runtime. Data generation needs a larger cluster, or you can split up the insertion to the partitioned table to multiple insert statements.
