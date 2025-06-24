 📘 Airbnb SQL Schema (DDL)

 📌 Objective
This directory contains the SQL Data Definition Language (DDL) script for creating the database schema of the Airbnb clone project.

 📦 Files
- `schema.sql`: Contains SQL `CREATE TABLE` statements for all entities.
- Includes constraints like:
  - Primary keys (UUID)
  - Foreign keys
  - Unique constraints
  - CHECK constraints (ENUM simulation)
  - Indexes for performance

 🏗️ Tables
- User
- Property
- Booking
- Payment
- Review
- Message

 🛠️ Indexes
Indexes are added to frequently queried fields like `email`, `property_id`, and `booking_id`.

 💡 Notes
- The schema uses `VARCHAR`, `UUID`, and `TIMESTAMP` for compatibility across RDBMS like PostgreSQL or MySQL.
- ENUM values are simulated with `CHECK` constraints.
