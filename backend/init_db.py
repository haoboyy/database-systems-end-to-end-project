import sqlite3
from pathlib import Path

DB_PATH = Path("backend/app.db")
SCHEMA_PATH = Path("sql/schema.sql")
SEED_PATH = Path("sql/seed.sql")

def run_sql_file(conn, path):
    with open(path, "r", encoding="utf-8") as f:
        sql = f.read()
    conn.executescript(sql)

def main():
    DB_PATH.parent.mkdir(parents=True, exist_ok=True)

    conn = sqlite3.connect(DB_PATH)
    run_sql_file(conn, SCHEMA_PATH)
    run_sql_file(conn, SEED_PATH)
    conn.commit()
    conn.close()

    print("Database initialized successfully at backend/app.db")

if __name__ == "__main__":
    main()
