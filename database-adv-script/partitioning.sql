-- Task 5: Partitioning Large Tables

-- Create a partitioned version of the Booking table
-- Partition by start_date to optimize date range queries

-- First, create the partitioned table structure
CREATE TABLE Booking_Partitioned (
    booking_id UUID NOT NULL,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (booking_id, start_date),
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Alternative: Partition by month for more granular partitioning
CREATE TABLE Booking_Monthly_Partitioned (
    booking_id UUID NOT NULL,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (booking_id, start_date),
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
)
PARTITION BY RANGE (TO_DAYS(start_date)) (
    PARTITION p202401 VALUES LESS THAN (TO_DAYS('2024-02-01')),
    PARTITION p202402 VALUES LESS THAN (TO_DAYS('2024-03-01')),
    PARTITION p202403 VALUES LESS THAN (TO_DAYS('2024-04-01')),
    PARTITION p202404 VALUES LESS THAN (TO_DAYS('2024-05-01')),
    PARTITION p202405 VALUES LESS THAN (TO_DAYS('2024-06-01')),
    PARTITION p202406 VALUES LESS THAN (TO_DAYS('2024-07-01')),
    PARTITION p202407 VALUES LESS THAN (TO_DAYS('2024-08-01')),
    PARTITION p202408 VALUES LESS THAN (TO_DAYS('2024-09-01')),
    PARTITION p202409 VALUES LESS THAN (TO_DAYS('2024-10-01')),
    PARTITION p202410 VALUES LESS THAN (TO_DAYS('2024-11-01')),
    PARTITION p202411 VALUES LESS THAN (TO_DAYS('2024-12-01')),
    PARTITION p202412 VALUES LESS THAN (TO_DAYS('2025-01-01')),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Performance test queries for partitioned tables

-- Query 1: Fetch bookings for a specific date range (should use partition pruning)
SELECT COUNT(*) 
FROM Booking_Partitioned 
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';

-- Query 2: Fetch bookings for a specific year
SELECT 
    property_id,
    COUNT(*) as booking_count,
    SUM(total_price) as total_revenue
FROM Booking_Partitioned 
WHERE start_date >= '2024-01-01' AND start_date < '2025-01-01'
GROUP BY property_id
ORDER BY total_revenue DESC;

-- Query 3: Monthly booking statistics
SELECT 
    YEAR(start_date) as booking_year,
    MONTH(start_date) as booking_month,
    COUNT(*) as monthly_bookings,
    AVG(total_price) as avg_booking_price
FROM Booking_Partitioned
WHERE start_date >= '2024-01-01'
GROUP BY YEAR(start_date), MONTH(start_date)
ORDER BY booking_year, booking_month;

-- Add indexes to partitioned table for better performance
ALTER TABLE Booking_Partitioned ADD INDEX idx_property_date (property_id, start_date);
ALTER TABLE Booking_Partitioned ADD INDEX idx_user_date (user_id, start_date);
ALTER TABLE Booking_Partitioned ADD INDEX idx_status (status);

-- Commands to check partition information
-- SHOW TABLE STATUS LIKE 'Booking_Partitioned';
-- SELECT * FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 'Booking_Partitioned';

-- Example of adding a new partition for future dates
-- ALTER TABLE Booking_Partitioned ADD PARTITION (PARTITION p2026 VALUES LESS THAN (2027));

-- Example of dropping old partitions (be careful with this!)
-- ALTER TABLE Booking_Partitioned DROP PARTITION p2020;
