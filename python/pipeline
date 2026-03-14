import os
import time
import pandas as pd
from sqlalchemy import create_engine, text
from urllib.parse import quote_plus
from dotenv import load_dotenv


load_dotenv()


# =========================
# Config from environment
# =========================
DB_SERVER = os.getenv("DB_SERVER")
DB_DATABASE = os.getenv("DB_DATABASE")
DB_USERNAME = os.getenv("DB_USERNAME")
DB_PASSWORD = os.getenv("DB_PASSWORD")

EXCEL_PATH = os.getenv("EXCEL_PATH", "data/Car_Insurance_Claim.xlsx")
TABLE_NAME = os.getenv("TABLE_NAME", "insurance_policies")
VIEWS_SQL_PATH = os.getenv("VIEWS_SQL_PATH", "sql/view_project.sql")
CLEAR_TABLE_FIRST = os.getenv("CLEAR_TABLE_FIRST", "false").lower() == "true"

ALLOWED_TABLES = {"insurance_policies"}


def validate_config() -> None:
    missing = []
    if not DB_SERVER:
        missing.append("DB_SERVER")
    if not DB_DATABASE:
        missing.append("DB_DATABASE")
    if not DB_USERNAME:
        missing.append("DB_USERNAME")
    if not DB_PASSWORD:
        missing.append("DB_PASSWORD")

    if missing:
        raise ValueError(f"Missing required environment variables: {', '.join(missing)}")

    if TABLE_NAME not in ALLOWED_TABLES:
        raise ValueError(f"Invalid TABLE_NAME: {TABLE_NAME}")


# =========================
# Create DB engine
# =========================
def get_engine():
    password_encoded = quote_plus(DB_PASSWORD)

    connection_string = (
        f"mssql+pyodbc://{DB_USERNAME}:{password_encoded}@{DB_SERVER}/{DB_DATABASE}"
        "?driver=ODBC+Driver+18+for+SQL+Server"
    )

    return create_engine(
        connection_string,
        fast_executemany=True,
        pool_pre_ping=True
    )


# =========================
# Utilities
# =========================
def map_binary_column(series: pd.Series) -> pd.Series:
    mapping = {
        "Yes": 1, "No": 0,
        "YES": 1, "NO": 0,
        "yes": 1, "no": 0,
        "Y": 1, "N": 0,
        "True": 1, "False": 0,
        "true": 1, "false": 0,
        True: 1, False: 0
    }
    return series.map(mapping).fillna(0).astype(int)


# =========================
# Load and prepare data
# =========================
def load_and_prepare_data(path: str) -> pd.DataFrame:
    df = pd.read_excel(path)

    # Standardize column names
    df.columns = [
        c.lower()
         .replace(" ", "_")
         .replace("?", "")
         .replace("(", "")
         .replace(")", "")
        for c in df.columns
    ]

    # Explicit renaming safeguard
    rename_map = {
        "single_parent": "single_parent",
        "red_car": "red_car",
        "license_revoked": "license_revoked",
        "claims_flag_crash": "claims_flag_crash",
        "total_claims_5_years": "total_claims_5_years",
        "claims_frequency_5_years": "claims_frequency_5_years"
    }
    df = df.rename(columns=rename_map)

    # Convert date
    if "dob" in df.columns:
        df["dob"] = pd.to_datetime(df["dob"], errors="coerce")

    # Convert binary columns to 0/1
    binary_cols = ["single_parent", "red_car", "license_revoked", "claims_flag_crash"]
    for col in binary_cols:
        if col in df.columns:
            df[col] = map_binary_column(df[col])

    # Integer numeric columns
    int_cols = [
        "id", "driving_children", "age", "home_children", "years_on_job",
        "income", "home_value", "travel_time", "vehicle_value",
        "time_in_force", "total_claims_5_years", "claims_frequency_5_years",
        "vehicle_points", "claims_amount", "car_age"
    ]

    for col in int_cols:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors="coerce").fillna(0).astype(int)

    # Text columns
    text_cols = [
        "marital_status", "gender", "education",
        "occupation", "car_use", "car_type", "city_population"
    ]
    for col in text_cols:
        if col in df.columns:
            df[col] = df[col].astype(str).str.strip()

    expected_order = [
        "id",
        "driving_children",
        "dob",
        "age",
        "home_children",
        "years_on_job",
        "income",
        "single_parent",
        "home_value",
        "marital_status",
        "gender",
        "education",
        "occupation",
        "travel_time",
        "car_use",
        "vehicle_value",
        "time_in_force",
        "car_type",
        "red_car",
        "total_claims_5_years",
        "claims_frequency_5_years",
        "license_revoked",
        "vehicle_points",
        "claims_amount",
        "car_age",
        "claims_flag_crash",
        "city_population"
    ]

    df = df[[col for col in expected_order if col in df.columns]]
    return df


# =========================
# Database actions
# =========================
def test_connection(engine) -> None:
    with engine.connect() as conn:
        conn.execute(text("SELECT 1"))
    print("Connection successful.")


def clear_table(engine, table_name: str) -> None:
    with engine.begin() as conn:
        conn.execute(text(f"DELETE FROM {table_name}"))
    print(f"Table '{table_name}' cleared.")


def upload_data(engine, df: pd.DataFrame, table_name: str) -> None:
    start = time.time()

    df.to_sql(
        table_name,
        engine,
        if_exists="append",
        index=False,
        chunksize=1000
    )

    elapsed = time.time() - start
    print(f"Upload finished in {elapsed:.2f} seconds.")


def check_row_count(engine, table_name: str) -> None:
    with engine.connect() as conn:
        result = conn.execute(text(f"SELECT COUNT(*) FROM {table_name}"))
        row_count = result.scalar()
    print(f"Rows in '{table_name}': {row_count}")


def create_views_from_sql_file(engine, sql_file_path: str) -> None:
    with open(sql_file_path, "r", encoding="utf-8") as f:
        sql_script = f.read().strip()

    parts = sql_script.split("CREATE OR ALTER VIEW")

    statements = []
    for part in parts:
        part = part.strip()
        if part:
            stmt = "CREATE OR ALTER VIEW " + part
            stmt = stmt.rstrip(";").strip()
            statements.append(stmt)

    print(f"{len(statements)} view statements found.")

    with engine.begin() as conn:
        for i, stmt in enumerate(statements, start=1):
            conn.execute(text(stmt))
            print(f"View {i} created/updated.")

    print("Views created successfully.")


# =========================
# Main pipeline
# =========================
def main():
    validate_config()
    engine = get_engine()

    print("Loading and preparing data...")
    df = load_and_prepare_data(EXCEL_PATH)
    print(f"Data loaded: {df.shape[0]} rows, {df.shape[1]} columns")
    print(df.dtypes)

    print("Testing connection...")
    test_connection(engine)

    if CLEAR_TABLE_FIRST:
        print("Clearing existing data...")
        clear_table(engine, TABLE_NAME)

    print("Uploading data...")
    upload_data(engine, df, TABLE_NAME)

    print("Checking row count...")
    check_row_count(engine, TABLE_NAME)

    print("Creating views...")
    create_views_from_sql_file(engine, VIEWS_SQL_PATH)

    print("Pipeline executed successfully.")


if __name__ == "__main__":
    main()
