 🧪 Airbnb Sample Data Seeder

 📌 Objective
This script populates the database with sample records across all main tables to simulate realistic usage scenarios for an Airbnb-style application.

 📦 Tables Seeded
- `users`
- `property`
- `booking`
- `payment`
- `review`
- `message`

 💡 Notes
- Static UUIDs are used for clarity.
- Sample bookings show various `status` values (`confirmed`, `pending`).
- Payments align with bookings.
- Reviews demonstrate user-to-property relationships.
- Messages simulate guest-host communication.

 ⚙️ Usage
Ensure your database is selected and schema created (via `schema.sql`) before running this seeding script:

```sql
USE airbnb_db;
SOURCE seed.sql;
