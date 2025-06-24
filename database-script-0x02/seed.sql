USE airbnb_db;

-- Insert Users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
('uuid-001', 'Alice', 'Smith', 'alice@example.com', 'hashed_password_1', '1234567890', 'guest'),
('uuid-002', 'Bob', 'Johnson', 'bob@example.com', 'hashed_password_2', '0987654321', 'host');

-- Insert Properties
INSERT INTO property (property_id, host_id, name, description, location, pricepernight)
VALUES
('uuid-prop-001', 'uuid-002', 'Cozy Cottage', 'A lovely cottage near the lake.', 'Lakeview', 120.00),
('uuid-prop-002', 'uuid-002', 'Modern Apartment', 'Downtown apartment with amenities.', 'City Center', 200.00);

-- Insert Bookings
INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
('uuid-book-001', 'uuid-prop-001', 'uuid-001', '2025-07-01', '2025-07-05', 480.00, 'confirmed'),
('uuid-book-002', 'uuid-prop-002', 'uuid-001', '2025-08-10', '2025-08-12', 400.00, 'pending');

-- Insert Payments
INSERT INTO payment (payment_id, booking_id, amount, payment_method)
VALUES
('uuid-pay-001', 'uuid-book-001', 480.00, 'credit_card');

-- Insert Reviews
INSERT INTO review (review_id, property_id, user_id, rating, comment)
VALUES
('uuid-rev-001', 'uuid-prop-001', 'uuid-001', 5, 'Amazing stay, very clean and quiet.');

-- Insert Messages
INSERT INTO message (message_id, sender_id, recipient_id, message_body)
VALUES
('uuid-msg-001', 'uuid-001', 'uuid-002', 'Hi Bob, is the cottage available for early check-in?');
