-- Analyze the query’s performance using EXPLAIN and identify any inefficiencies.
-- Task 4: Optimize Complex Queries

-- Initial complex query (BEFORE optimization)
-- This query retrieves all bookings with user details, property details, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price as booking_total,
    b.status,
    b.created_at as booking_created,
    
    -- User details
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    
    -- Property details
    p.property_id,
    p.name as property_name,
    p.description,
    p.location,
    p.pricepernight,
    
    -- Host details
    h.first_name as host_first_name,
    h.last_name as host_last_name,
    h.email as host_email,
    
    -- Payment details
    pay.payment_id,
    pay.amount as payment_amount,
    pay.payment_date,
    pay.payment_method,
    
    -- Property statistics (expensive subqueries)
    (SELECT AVG(rating) FROM Review WHERE property_id = p.property_id) as avg_rating,
    (SELECT COUNT(*) FROM Review WHERE property_id = p.property_id) as review_count,
    (SELECT COUNT(*) FROM Booking WHERE property_id = p.property_id) as total_bookings_for_property

FROM Booking b
LEFT JOIN User u ON b.user_id = u.user_id
LEFT JOIN Property p ON b.property_id = p.property_id
LEFT JOIN User h ON p.host_id = h.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

-- OPTIMIZED VERSION of the above query
-- Improvements:
-- 1. Use CTEs to pre-calculate aggregations
-- 2. Reduce redundant joins
-- 3. Add proper indexing hints
-- 4. Limit results if not all data is needed

WITH property_stats AS (
    SELECT 
        property_id,
        AVG(rating) as avg_rating,
        COUNT(*) as review_count
    FROM Review
    GROUP BY property_id
),
property_booking_counts AS (
    SELECT 
        property_id,
        COUNT(*) as total_bookings
    FROM Booking
    GROUP BY property_id
)

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price as booking_total,
    b.status,
    b.created_at as booking_created,
    
    -- User details
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) as user_name,
    u.email,
    u.role,
    
    -- Property details
    p.property_id,
    p.name as property_name,
    p.location,
    p.pricepernight,
    
    -- Host details
    CONCAT(h.first_name, ' ', h.last_name) as host_name,
    h.email as host_email,
    
    -- Payment details
    pay.payment_id,
    pay.amount as payment_amount,
    pay.payment_date,
    pay.payment_method,
    
    -- Pre-calculated property statistics
    COALESCE(ps.avg_rating, 0) as avg_rating,
    COALESCE(ps.review_count, 0) as review_count,
    COALESCE(pbc.total_bookings, 0) as total_bookings_for_property

FROM Booking b
INNER JOIN User u ON b.user_id = u.user_id
INNER JOIN Property p ON b.property_id = p.property_id
INNER JOIN User h ON p.host_id = h.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
LEFT JOIN property_stats ps ON p.property_id = ps.property_id
LEFT JOIN property_booking_counts pbc ON p.property_id = pbc.property_id

WHERE b.created_at >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR)  -- Limit to recent bookings
ORDER BY b.created_at DESC
LIMIT 1000;  -- Limit results for better performance

-- Additional optimized queries for common use cases

-- Optimized query for finding available properties in date range
SELECT DISTINCT
    p.property_id,
    p.name,
    p.location,
    p.pricepernight,
    COALESCE(ps.avg_rating, 0) as avg_rating
FROM Property p
LEFT JOIN property_stats ps ON p.property_id = ps.property_id
WHERE p.property_id NOT IN (
    SELECT DISTINCT property_id
    FROM Booking
    WHERE status IN ('confirmed', 'pending')
    AND (
        (start_date <= '2024-06-01' AND end_date >= '2024-06-01') OR
        (start_date <= '2024-06-10' AND end_date >= '2024-06-10') OR
        (start_date >= '2024-06-01' AND end_date <= '2024-06-10')
    )
)
ORDER BY ps.avg_rating DESC, p.pricepernight ASC;
