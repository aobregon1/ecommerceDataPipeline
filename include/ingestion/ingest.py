import snowflake.connector
import os
from dotenv import load_dotenv
load_dotenv()

conn = snowflake.connector.connect(
    user=os.getenv("SNOWFLAKE_USER"),
    password=os.getenv("SNOWFLAKE_PASSWORD"),
    account=os.getenv("SNOWFLAKE_ACCOUNT"),
    warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
    database=os.getenv("SNOWFLAKE_DATABASE"),
    schema=os.getenv("SNOWFLAKE_SCHEMA"),
    autocommit=True
)

cursor = conn.cursor()


# Base directory for CSV files
data_dir = os.getenv("DATA_DIR")

# Mapping: table → file
tables_to_files = {
    "customers": "olist_customers_dataset.csv",
    "geolocation": "olist_geolocation_dataset.csv",
    "products": "olist_products_dataset.csv",
    "sellers": "olist_sellers_dataset.csv",
    "order_items": "olist_order_items_dataset.csv",
    "order_payments": "olist_order_payments_dataset.csv",
    "order_reviews": "olist_order_reviews_dataset.csv",
    "orders": "olist_orders_dataset.csv",
    "product_category_name_translation": "product_category_name_translation.csv"
}

def load_csv_to_snowflake(table_name, file_name):
    file_path = os.path.join(data_dir, file_name)
    print(f"\nLoading {file_path} into {table_name}...")

    cursor.execute(f"USE DATABASE {os.getenv('SNOWFLAKE_DATABASE')}")
    cursor.execute(f"USE SCHEMA {os.getenv('SNOWFLAKE_SCHEMA')}")

    cursor.execute(f"REMOVE @ecom_stage/{file_name}")
    # Upload file to Snowflake stage
    cursor.execute(f"""
        PUT file://{file_path} @ecom_stage
        AUTO_COMPRESS=TRUE
        OVERWRITE=TRUE
    """)

    # Clear table
    cursor.execute(f"""
        TRUNCATE TABLE {table_name};
    """)
    print(f"\nTruncated {table_name}...")

    # Load into table
    cursor.execute(f"""
        COPY INTO {table_name}
        FROM @ecom_stage/{file_name}
        FILE_FORMAT = (
            TYPE = 'CSV'
            FIELD_OPTIONALLY_ENCLOSED_BY = '"'
            DATE_FORMAT = 'AUTO'
            TIMESTAMP_FORMAT = 'AUTO'
            PARSE_HEADER = TRUE
        )
        MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
    """)

    # Optional: row count check
    cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
    count = cursor.fetchone()[0]

    print(f"{table_name} now has {count} rows.")


try:
    for table, file_name in tables_to_files.items():
        
        load_csv_to_snowflake(table, file_name)

    print("\nAll files loaded successfully!")

finally:
    cursor.close()
    conn.close()
    print("Connection closed.")