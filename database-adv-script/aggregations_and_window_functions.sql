-- Task 2: Apply Aggregations and Window Functions

-- 1. Find the total number of bookings made by each user using COUNT and GROUP BY
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) as total_bookings,
    COALESCE(SUM(b.total_price), 0) as total_spent
FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.email
ORDER BY total_bookings DESC, total_spent DESC;

-- 2. Use window functions to rank properties based on total number of bookings
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.pricepernight,
    COUNT(b.booking_id) as total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) as booking_rank,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) as booking_rank_with_ties,
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) as dense_booking_rank
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name, p.location, p.pricepernight
ORDER BY total_bookings DESC;

-- Additional window functions examples

-- 3. Calculate running total of bookings by date
SELECT 
    DATE(b.created_at) as booking_date,
    COUNT(*) as daily_bookings,
    SUM(COUNT(*)) OVER (ORDER BY DATE(b.created_at)) as running_total_bookings
FROM Booking b
GROUP BY DATE(b.created_at)
ORDER BY booking_date;

-- 4. Find the percentage of total revenue each property contributes
SELECT 
    p.property_id,
    p.name,
    SUM(b.total_price) as property_revenue,
    ROUND(
        (SUM(b.total_price) * 100.0) / SUM(SUM(b.total_price)) OVER (), 
        2
    ) as revenue_percentage
FROM Property p
INNER JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY property_revenue DESC;

-- 5. Rank users by their total spending with quartiles
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    SUM(b.total_price) as total_spent,
    NTILE(4) OVER (ORDER BY SUM(b.total_price) DESC) as spending_quartile,
    PERCENT_RANK() OVER (ORDER BY SUM(b.total_price)) as spending_percentile
FROM User u
INNER JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_spent DESC;
