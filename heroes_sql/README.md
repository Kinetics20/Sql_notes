

# 🧙‍♂️ Heroes SQL 🐉

A mini project using **SQLAlchemy** to explore and analyze data from a fantasy game database.

## 📁 Project Structure

* `heroes_of_endless_war_ch1.ipynb` – SQLAlchemy Core queries, filtering, ordering, and aggregation.
* `heroes_of_endless_war_ch2.ipynb` – ORM models, table relationships, and advanced joins with automap.

## 🛠 Technologies Used

* Python 3
* SQLite
* SQLAlchemy (Core, ORM, Automap)
* Jupyter Notebook

## 🔍 Key Concepts Covered

### 🧱 SQLAlchemy Core

* `create_engine()` – connect to the SQLite database.
* `Table()`, `select()`, `text()` – defining and executing SQL queries.
* `where()`, `order_by()`, `limit()`, `offset()` – advanced filtering and slicing.
* `func.count()` – aggregating data (e.g. event totals per participant).

### 🧙 SQLAlchemy ORM

* Declarative models using `orm.DeclarativeBase` and `mapped_column()`.
* Class-based querying of `heroes`, `battle_events`, and `battle_participants`.
* Complex joins between related tables.
* Grouping and ordering results (e.g. total battles per hero).

### 🧠 Automap (Reflection)

* `automap_base()` and `prepare()` – reflect database schema automatically.
* Dynamically mapped classes (e.g. `Heroes`, `BattleEventTypes`) used for rich queries.

## 📊 Sample Queries & Goals

* Fetch all heroes and their metadata.
* Display the top heroes by name or by number of battles.
* Identify heroes with the most kills (`HERO_KILL` event type).
* Explore event frequency and hero participation across battles.

## ⚙️ Setup

This project uses **[uv](https://github.com/astral-sh/uv)** for managing dependencies.
To install all required packages, simply run:

```bash
uv sync
```

> Ensure `uv` is installed on your system. If not, you can install it with:
> `curl -LsSf https://astral.sh/uv/install.sh | sh`


