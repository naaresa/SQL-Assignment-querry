#  Wave Transaction SQL & Python Analysis Project

This project contains a series of SQL queries developed to analyze user behavior, transaction volume, and agent activity within a digital financial services platform similar to Wave.

---

##  Objective

To practice and showcase SQL skills by answering real-world analytical questions on a hypothetical fintech dataset involving:
- User counts
- Transaction volume by currency
- Agent activities by location and type
- Wallet-level and country-level transfer analysis

---

##  Dataset (Simulated)

> **Note:** This dataset is fictional and manually created for educational purposes. You can simulate it using tools like [Mockaroo](https://mockaroo.com/) or Python's Faker library.

### Tables Used:
- `users`: User info (u_id)
- `transfers`: Transfer transactions (e.g., currency, amount, time)
- `agent_transactions`: Activity logs for Wave agents
- `agents`: Metadata about agents (city, country)
- `wallets`: Wallet info and ledger location

---

##  Questions & Queries

This repo answers 10 analytical SQL questions, such as:
- Total users and CFA transfers
- Agent behavior over the last week
- Transfer volumes segmented by currency, country, and kind
- High-volume senders

Refer to [`Wave transaction python notebook`](Wave_SQL_Visualizations.ipynb) [`Wave transaction SQL query`]and (Wave transaction SQL query.sql)for the detailed logic.

---

##  How to Run

1. Create the database and tables in PostgreSQL (or SQLite, MySQL)
2. Load the sample data (CSV or INSERT scripts)
3. Run the queries in the SQL file using your preferred client (e.g., DBeaver, pgAdmin, or DB Fiddle)

---

##  Skills Highlighted

- SQL Aggregations (`COUNT`, `SUM`, `GROUP BY`)
- Conditional logic with `CASE`
- Time filtering with `NOW()`, `INTERVAL`
- JOINs across normalized tables
- Data segmentation and reporting

---

## Contributions

Feel free to fork, simulate your own dataset, and extend the queries!

