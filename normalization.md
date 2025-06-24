 📘 Normalization to 3NF: Airbnb Database

 🎯 Objective
To optimize the database structure by minimizing data redundancy and ensuring data integrity using the principles of normalization up to the Third Normal Form (3NF).

---

 ✅ Step 1: First Normal Form (1NF)

 🔍 Definition:
- Ensure that all attributes are atomic (indivisible).
- Each record is unique.

 ✔ Applied:
- All attributes in our entities (User, Property, Booking, etc.) are atomic.
- No repeating groups or arrays.
- Each table has a unique primary key (`user_id`, `property_id`, etc.).

---

 ✅ Step 2: Second Normal Form (2NF)

 🔍 Definition:
- Must be in 1NF.
- No partial dependency (non-key attributes should depend on the whole primary key).

 ✔ Applied:
- All tables use a single-attribute primary key (UUID), so no risk of partial dependency.
- Example: In the `Booking` table, all non-key attributes depend entirely on `booking_id`.

---

 ✅ Step 3: Third Normal Form (3NF)

 🔍 Definition:
- Must be in 2NF.
- No transitive dependency (non-key attributes depend only on the key, not other non-key attributes).

 ✔ Applied:
- All non-key attributes in all tables depend solely on their respective primary keys.
- Example: In the `User` table, attributes like `email`, `role`, `password_hash` depend directly on `user_id`.

---

 🧾 Summary of Compliance

| Table      | 1NF | 2NF | 3NF |
|------------|-----|-----|-----|
| User       | ✅  | ✅  | ✅  |
| Property   | ✅  | ✅  | ✅  |
| Booking    | ✅  | ✅  | ✅  |
| Payment    | ✅  | ✅  | ✅  |
| Review     | ✅  | ✅  | ✅  |
| Message    | ✅  | ✅  | ✅  |

---

 🏁 Conclusion

This Airbnb-like database schema adheres to all normalization principles up to the third normal form (3NF), ensuring data integrity, scalability, and performance.
