Below is the updated README file:

---

# SQL Notes

This repository contains SQL practice exercises using the Sakila database. It serves as an educational resource where you can write, test, and refine SQL queries on a realistic dataset.

## About the Sakila Database

The Sakila database is a sample database originally maintained by MySQL for learning and demonstration purposes. In this repository, only the MySQL version is used, specifically extracted from the [jOOQ Sakila repository](https://github.com/jOOQ/sakila/tree/main/mysql-sakila-db). The repository includes the following SQL files:

- **mysql-sakila-schema.sql** – Contains the schema definition.
- **mysql-sakila-insert-data.sql** – Contains the data insertion script.

## Purpose

The aim of this repository is to provide a robust database environment for exploring various SQL commands, writing complex queries, and learning effective database manipulation techniques. The Sakila database serves as a sandbox for experimenting with joins, subqueries, transactions, and more.

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your system.
- [Docker Compose](https://docs.docker.com/compose/) installed (typically included with Docker Desktop).
- A database client such as [DataGrip](https://www.jetbrains.com/datagrip/) or [PyCharm Professional](https://www.jetbrains.com/pycharm/) for connecting to and interacting with the database.

### Setup Instructions

1. **Place Files in Your Working Directory**

   Make sure you have the following files in your working directory:
   
   - `mysql-sakila-schema.sql`
   - `mysql-sakila-insert-data.sql`
   - A properly configured `docker-compose.yaml` file that sets up the MySQL container.

2. **Start the MySQL Container with Docker Compose**

   Open a terminal in the directory where your files are located and run:
   
   ```bash
   docker compose up
   ```
   
   This command will launch the MySQL database container. The container configuration should be set up to run the provided SQL files to create the database schema and insert sample data automatically.

3. **Connect Using Your Database Client**

   Once the container is running, use your preferred database client (e.g., DataGrip or PyCharm Professional) to connect to the MySQL instance. Make sure to use the connection details specified in your `docker-compose.yaml` configuration.

   *Example connection details might include:*
   - **Host:** `localhost` (or the Docker container's IP/hostname)
   - **Port:** Typically `3306`
   - **User:** As configured in the docker-compose file (e.g., `root`)
   - **Password:** As set in your configuration
   - **Database:** `sakila` (if the SQL files automatically create this database)

   Adjust these settings as necessary based on your local configuration.

## Usage

With the Sakila database up and running, you can now experiment with various SQL queries. Use this environment as a playground for writing, testing, and refining your SQL code. Explore data retrieval, complex queries, data manipulation, and other database functionalities to strengthen your SQL skills.

---

💬 Feedback

Contributions and suggestions are welcome!

👤 Author: Piotr Lipiński  
🗓 Date: April 2025