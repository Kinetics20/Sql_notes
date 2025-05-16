
# 📘 Sakila\_python

This repository contains exercises and learning examples focused on SQL and the SQLAlchemy ORM library in Python. It is structured around a course project that uses the **Sakila** database — a sample database representing a DVD rental store.

Exercises are written in Python and use libraries such as:

* **SQLAlchemy** – Python SQL toolkit and ORM
* **python-dotenv** – For loading environment variables from `.env` files
* **pandas** – For data manipulation and export
* **openpyxl** – For working with Excel files
* **requests** – For accessing external APIs (e.g., currency exchange)

---

## ⚙️ Setup

### 1. Create a virtual environment

If you have an active virtual environment from another project, **deactivate it first**:

```bash
deactivate
```

Now, in the root of this project directory, create and activate a new virtual environment:

```bash
python -m venv .venv
source .venv/bin/activate
```

Make sure your interpreter is set to `.venv/bin/python` in your IDE (e.g., PyCharm).

---

### 2. Install dependencies using `uv`

Instead of `pip`, this project uses [uv](https://github.com/astral-sh/uv) – a fast Python package manager.

Install dependencies from `requirements.txt` using:

```bash
uv sync
```

---

### 3. Create `.env` file

Before running any scripts, create a `.env` file in the `sakila_python/` directory with your database credentials:

```dotenv
DB_USER=root
DB_PASSWORD=password
DB_NAME=sakila
DB_HOST=localhost
DB_PORT=3308
```

The `.env` file is excluded from version control (`.gitignore`), so you need to create it locally.

---

## 📄 File Descriptions

### `sqlalchemy_example_4_sakila_conn.py`

* Connects to the Sakila database using environment variables.
* Reflects the schema and selects the first 10 actor names from the `actor` table.
* Demonstrates basic usage of SQLAlchemy Core with `select()` and table metadata reflection.

---

### `sqlalchemy_example_5_generate_table.py`

* Creates a `feedback` table in the Sakila schema (if it doesn't exist).
* The table includes:

  * Foreign keys to `film` and `customer`
  * A rating (1–5) with a check constraint
  * A comment field
  * A uniqueness constraint on `film_id` and `contact_id`
* Demonstrates manual table definition and DDL generation in SQLAlchemy.

---

### `sql_to_excel.py`

* Uses SQLAlchemy ORM with automap to join Sakila tables.
* Queries rental and payment data, loads results into a Pandas DataFrame.
* Splits data into chunks (100 rows) and writes to separate Excel sheets.
* Uses `openpyxl` for formatting (blue headers, bold font).
* Exports file to `office_doc/film.xlsx`.

---

### `sql_to_excel_2.py`

* Loads the `payment` table using raw SQL via Pandas.
* Saves results to `office_doc/report.xlsx`.

---

### `sql_and_request.py`

* Connects using SQLAlchemy ORM with automap.
* Fetches current USD exchange rate from [NBP API](https://api.nbp.pl).
* Multiplies `payment.amount` values by the fetched exchange rate.
* Demonstrates integration of API calls with database updates.

---

### `from_excel_to_sql.py`

* Reads updated payment data from Excel.
* Loads first 100 payment records from the database.
* Compares and conditionally updates `amount` values.
* Useful for reconciling database with exported data.

---

## ✅ Key Skills Practiced

* Database connectivity via SQLAlchemy and `.env` configuration
* Schema reflection and manual table creation
* ORM querying and joins
* Data export/import using Excel
* Integration with external APIs (currency exchange)
* Data reconciliation and conditional updates

---

## 📚 Requirements

* Python 3.10+
* MySQL (with Sakila sample database)

Install the following libraries with `uv sync`:

```txt
sqlalchemy
pymysql
python-dotenv
pandas
openpyxl
requests
```

---

## 📌 Notes

This repository is part of a course project and is intended for educational purposes. The Sakila database is a well-known sample dataset used in SQL training.
