import sqlite3
import os

DB_FILE = "ecommerce.db"
SQL_FILES = [
    "schema.sql",
    "seed_users.sql",
    "seed_products.sql",
    "seed_orders.sql",
    "seed_order_items.sql",
]

def execute_sql_from_file(conn, filename):
    """Executes an SQL script from a file."""
    try:
        with open(filename, "r") as f:
            sql_script = f.read()
            conn.executescript(sql_script)
            print(f"Successfully executed {filename}")
    except sqlite3.Error as e:
        print(f"Error executing {filename}: {e}")
        raise
    except IOError as e:
        print(f"Error reading {filename}: {e}")
        raise

def validate_database(conn):
    """Validates the database by printing table names and row counts."""
    print("\n--- Database Validation ---")
    cursor = conn.cursor()

    # Get and print table names
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';")
    tables = [row[0] for row in cursor.fetchall()]
    print("Tables:", tables)

    # Get and print row counts
    for table in tables:
        cursor.execute(f"SELECT COUNT(*) FROM {table}")
        count = cursor.fetchone()[0]
        print(f"  - {table}: {count} rows")
    print("--- Validation Complete ---\n")


def main():
    """Creates and seeds the database, then validates it."""
    # Remove the old database file if it exists
    if os.path.exists(DB_FILE):
        os.remove(DB_FILE)
        print(f"Removed existing database file: {DB_FILE}")

    conn = None
    try:
        conn = sqlite3.connect(DB_FILE)
        print(f"Database {DB_FILE} created.")

        for sql_file in SQL_FILES:
            execute_sql_from_file(conn, sql_file)

        conn.commit()
        print("All SQL files executed and changes committed.")

        validate_database(conn)

    except (sqlite3.Error, IOError) as e:
        print(f"An error occurred: {e}")
    finally:
        if conn:
            conn.close()

if __name__ == "__main__":
    main()
