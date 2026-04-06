-- 1. Setup Environment
CREATE DATABASE IF NOT EXISTS ECOMMERCE_DATA_PIPELINE;
USE DATABASE ECOMMERCE_DATA_PIPELINE;

-- 2. Setup Schema Layers (Medallion Architecture)
CREATE SCHEMA IF NOT EXISTS RAW;
CREATE SCHEMA IF NOT EXISTS STAGE;
CREATE SCHEMA IF NOT EXISTS MART;

-- 3. Set Context
USE SCHEMA RAW;

-- 4. Setup External Integration
CREATE STAGE IF NOT EXISTS RAW.ecom_stage;

CREATE TABLE IF NOT EXISTS raw.customers (
     customer_id STRING,
     customer_unique_id STRING,
     customer_zip_code_prefix STRING,
     customer_city STRING,
     customer_state STRING
);

CREATE TABLE IF NOT EXISTS raw.geolocation (
     geolocation_zip_code_prefix STRING,
     geolocation_lat STRING,
     geolocation_lng STRING,
     geolocation_city STRING,
     geolocation_state STRING
);

CREATE TABLE IF NOT EXISTS raw.order_items (
     order_id STRING,
     order_item_id STRING,
     product_id STRING,
     seller_id STRING,
     shipping_limit_date STRING,
     price STRING,
     freight_value STRING
);

CREATE TABLE IF NOT EXISTS raw.order_payments (
     order_id STRING,
     payment_sequential STRING,
     payment_type STRING,
     payment_installments STRING,
     payment_value STRING
);

CREATE TABLE IF NOT EXISTS raw.order_reviews (
     review_id STRING,
     order_id STRING,
     review_score STRING,
     review_comment_title STRING,
     review_comment_message STRING,
     review_creation_date STRING,
     review_answer_timestamp STRING
);

CREATE TABLE IF NOT EXISTS raw.orders (
     order_id STRING,
     customer_id STRING,
     order_status STRING,
     order_purchase_timestamp STRING,
     order_approved_at STRING,
     order_delivered_carrier_date STRING,
     order_delivered_customer_date STRING,
     order_estimated_delivery_date STRING
);

CREATE TABLE IF NOT EXISTS raw.products (
     product_id STRING,
     product_category_name STRING,
     product_name_lenght STRING,
     product_description_lenght STRING,
     product_photos_qty STRING,
     product_weight_g STRING,
     product_length_cm STRING,
     product_height_cm STRING,
     product_width_cm STRING     
);

CREATE TABLE IF NOT EXISTS raw.sellers (
     seller_id STRING,
     seller_zip_code_prefix STRING,
     seller_city STRING,
     seller_state STRING
);

CREATE TABLE IF NOT EXISTS raw.product_category_name_translation (
     product_category_name STRING,
     product_category_name_english STRING
);