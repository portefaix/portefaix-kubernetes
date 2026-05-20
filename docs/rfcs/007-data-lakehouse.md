---
rfc: 007
status: ✅ accepted
date: 2024-09-01
deciders: nlamirault
consulted:
informed:
spdx-license: Apache-2.0
---

# RFC 007 - Data Lakehouse Strategy

## 1. 📝 Summary

This RFC proposes the implementation of a **Data Lakehouse** architecture for Portefaix. The goal is to provide a unified, high-performance query layer that can access data across disparate sources (RDBMS, Cloud Storage, Data Warehouses) while leveraging open table formats for transactional consistency on data lakes.

## 2. 🎯 Motivation

### Current State
Data is currently siloed across various PostgreSQL/MySQL databases and object storage (S3/MinIO). Querying across these sources is difficult and requires manual data movement or complex ETL pipelines.

### Problems
- **Data Silos:** No single view of data across the infrastructure.
- **Performance:** Traditional object storage lacks database-like performance for large-scale analytical queries.
- **Consistency:** Difficult to ensure ACID transactions on raw data lakes.
- **AI/ML Needs:** Increasing requirement for vector search capabilities alongside traditional SQL.

## 3. 📖 Guide-level Explanation

The Data Lakehouse architecture combines the flexibility of a Data Lake with the management and performance of a Data Warehouse.
- **Storage Layer:** Uses open formats like **Apache Parquet** and **Apache Iceberg** for performance and transactional integrity.
- **Query Engine:** A unified engine that can query storage directly and federate queries to external databases.

## 4. 🔬 Reference-level Explanation

### Technical Requirements
- Support for **Apache Iceberg** as the table format.
- Support for **Apache Parquet** as the storage format.
- **Massively Parallel Processing (MPP)** for horizontal scalability.
- Native support for **Vector Search** to support AI use cases.
- Ability to federate queries to PostgreSQL, MySQL, and S3-compatible storage.

## 5. 🔍 Considered Options

### Option 1: Trino
- **Overview:** Highly popular distributed SQL query engine.
- **Pros:** Excellent community, broad connector support, mature Iceberg integration.
- **Cons:** Primarily a query engine; might require additional components for optimal performance in some scenarios.

### Option 2: Dremio
- **Overview:** Data Lakehouse platform built on Apache Arrow.
- **Pros:** Great performance, easy-to-use UI for data curation.
- **Cons:** Some features are limited to the enterprise edition.

### Option 3: StarRocks
- **Overview:** High-performance analytical database for all-scenario data analysis.
- **Pros:** Native vectorized engine, outstanding performance on both local and external data (Iceberg), Linux Foundation project, built-in vector search.
- **Cons:** Newer ecosystem compared to Trino.

## 6. ⚠️ Drawbacks
- Significant infrastructure requirements (CPU/Memory) for MPP engines.
- Complexity in managing table formats (Iceberg catalogs).
- Learning curve for SQL optimization in a distributed environment.

## 7. 🚀 Next Steps
1. Deploy a pilot StarRocks cluster.
2. Connect S3/MinIO buckets with Iceberg tables.
3. Test federated queries against existing PostgreSQL databases.
