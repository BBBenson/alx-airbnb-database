-- Task 3: Implement Indexes for Optimization

-- Indexes for User table
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);
CREATE INDEX idx_user_created_at ON User(created_at);

-- Indexes for Property table
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(pricepernight);
CREATE INDEX idx_property_created_at ON Property(created_at);

-- Indexes for Booking table
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_start_date ON Booking(start_date);
CREATE INDEX idx_booking_end_date ON Booking(end_date);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_created_at ON Booking(created_at);

-- Composite indexes for common query patterns
CREATE INDEX idx_booking_dates_range ON Booking(start_date, end_date);
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date, end_date);
CREATE INDEX idx_booking_user_status ON Booking(user_id, status);

-- Indexes for Review table
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_user_id ON Review(user_id);
CREATE INDEX idx_review_rating ON Review(rating);
CREATE INDEX idx_review_created_at ON Review(created_at);

-- Composite index for review analysis
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);

-- Indexes for Payment table
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);
CREATE INDEX idx_payment_method ON Payment(payment_method);
CREATE INDEX idx_payment_date ON Payment(payment_date);

-- Performance testing queries
-- Before creating indexes, run EXPLAIN on these queries:

-- Query 1: Find bookings in date range
-- EXPLAIN SELECT * FROM Booking WHERE start_date >= '2024-01-01' AND end_date <= '2024-12-31';

-- Query 2: Find properties by location with average rating
-- EXPLAIN SELECT p.*, AVG(r.rating) FROM Property p LEFT JOIN Review r ON p.property_id = r.property_id WHERE p.location LIKE '%New York%' GROUP BY p.property_id;

-- Query 3: Find user bookings with status
-- EXPLAIN SELECT * FROM Booking b JOIN User u ON b.user_id = u.user_id WHERE b.status = 'confirmed' AND u.email = 'user@example.com';
