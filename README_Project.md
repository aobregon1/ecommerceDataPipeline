Cloud-Native Medallion Architecture & E-Commerce ELT Pipeline
=============================================================
An end-to-end data engineering framework designed to ingest, transform, and model high-volume e-commerce data. This project demonstrates a modern enterprise stack utilizing Snowflake, dbt, Apache Airflow, and Docker to implement a robust Medallion Architecture (Bronze/Silver/Gold layers).

Architecture Overview
======================
The pipeline follows a modern ELT (Extract, Load, Transform) pattern:

Extraction: Python-based ingestion scripts extract raw e-commerce data.

Loading (Bronze): Data is staged into Snowflake using optimized COPY INTO commands.

Transformation (Silver): dbt performs modular cleaning, casting, and schema validation.

Analytics (Gold): Final analytical models (RFM, Geospatial, CLV) are generated for downstream BI.

Orchestration: Apache Airflow (via Astronomer Cosmos) manages task dependencies and lineage.

Infrastructure: Entire stack is containerized using Docker for environment parity.

Tech Stack
==========
Data Warehouse: Snowflake

Transformation: dbt (Data Build Tool)

Orchestration: Apache Airflow / Astronomer Cosmos

Language: Python, SQL

Environment: Docker / Astro CLI

Key Features
============
Medallion Architecture: Logical separation of concerns across Raw (Bronze), Cleansed (Silver), and Curated (Gold) data layers.

Dynamic Orchestration: Utilizes Astronomer Cosmos to automatically map dbt models into Airflow Task Groups, providing granular observability.

Data Quality Assurance: Implemented custom dbt schema tests and casting logic to ensure 100% data type consistency and integrity.

Advanced Analytics: Built specialized models including:

RFM Analysis: Recency, Frequency, and Monetary metrics for customer segmentation.

Geospatial Density: Regional revenue concentration and logistics performance.

CLV (Customer Lifetime Value): Predictive modeling for long-term revenue impact.

Setup & Installation
=====================
Clone the Repository:

Bash
git clone https://github.com/aobregon1/ecommerce_data_pipeline.git
Configure Environment Variables:
Update your .env file with Snowflake credentials (SNOWFLAKE_ACCOUNT, SNOWFLAKE_USER, etc.).

Launch with Astro CLI:
astro dev start

Run the Pipeline:
Access the Airflow UI at localhost:8080 and trigger the ecom_full_pipeline DAG.