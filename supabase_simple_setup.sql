-- ============================================
-- SIMPLE Supabase Table Setup
-- ============================================
-- Copy and paste this into Supabase SQL Editor
-- https://supabase.com/dashboard/project/rhebewpkkimrlddyceax/sql
-- ============================================

-- Create users table (matches Java User entity exactly)
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(255),
    address VARCHAR(255)
);

-- Enable Row Level Security and allow all operations
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow all operations on users"
    ON users FOR ALL
    USING (true)
    WITH CHECK (true);

-- Insert test data
INSERT INTO users (name, email, phone, address) VALUES
    ('John Doe', 'john.doe@example.com', '+91-9876543210', '123 Main St, Mumbai'),
    ('Jane Smith', 'jane.smith@example.com', '+91-9876543211', '456 Park Ave, Delhi'),
    ('Bob Johnson', 'bob.johnson@example.com', '+91-9876543212', '789 Oak Rd, Bangalore')
ON CONFLICT (email) DO NOTHING;

-- Verify
SELECT * FROM users;
