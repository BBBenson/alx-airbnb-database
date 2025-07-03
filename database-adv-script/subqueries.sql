-- Task 1: Practice Subqueries

-- 1. Non-correlated subquery: Find all properties where the average rating is greater than 4.0
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight
FROM Property p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM Review r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);

-- Alternative approach with JOIN for better performance
SELECT DISTINCT
    p.property_id,
    p.name,
    p.location,
    p.pricepernight,
    avg_ratings.avg_rating
FROM Property p
INNER JOIN (
    SELECT 
        property_id,
        AVG(rating) as avg_rating
    FROM Review
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
) avg_ratings ON p.property_id = avg_ratings.property_id;

-- 2. Correlated subquery: Find users who have made more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM User u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.user_id
) > 3;

-- Additional correlated subquery: Find properties that have never been booked
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight
FROM Property p
WHERE NOT EXISTS (
    SELECT 1
    FROM Booking b
    WHERE b.property_id = p.property_id
);

-- Subquery to find users who have spent more than the average total booking amount
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM User u
WHERE u.user_id IN (
    SELECT b.user_id
    FROM Booking b
    GROUP BY b.user_id
    HAVING SUM(b.total_price) > (
        SELECT AVG(user_total)
        FROM (
            SELECT SUM(total_price) as user_total
            FROM Booking
            GROUP BY user_id
        ) user_totals
    )
);
