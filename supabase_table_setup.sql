-- ============================================
-- Supabase Table Setup for User Management
-- ============================================
-- Run this SQL in your Supabase SQL Editor
-- Dashboard: https://supabase.com/dashboard
-- Project: rhebewpkkimrlddyceax
-- ============================================

-- Drop existing table if you want to start fresh (CAUTION: This deletes all data!)
-- DROP TABLE IF EXISTS users CASCADE;

-- Create users table matching Java User entity
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(255),
    address VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- Create index on email for faster lookups
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Create index on name for search functionality
CREATE INDEX IF NOT EXISTS idx_users_name ON users(name);

-- Add comment to table
COMMENT ON TABLE users IS 'User management table for Spring Boot application';

-- Add comments to columns
COMMENT ON COLUMN users.id IS 'Auto-incrementing primary key';
COMMENT ON COLUMN users.name IS 'User full name (required)';
COMMENT ON COLUMN users.email IS 'User email address (required, unique)';
COMMENT ON COLUMN users.phone IS 'User phone number (optional)';
COMMENT ON COLUMN users.address IS 'User address (optional)';
COMMENT ON COLUMN users.created_at IS 'Timestamp when user was created';
COMMENT ON COLUMN users.updated_at IS 'Timestamp when user was last updated';

-- Create function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = TIMEZONE('utc', NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to call the function before update
DROP TRIGGER IF EXISTS update_users_updated_at ON users;
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Enable Row Level Security (RLS) - Optional but recommended
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Create policy to allow all operations (adjust based on your security needs)
-- For development: Allow all operations
DROP POLICY IF EXISTS "Allow all operations on users" ON users;
CREATE POLICY "Allow all operations on users"
    ON users
    FOR ALL
    USING (true)
    WITH CHECK (true);

-- Alternative: More secure policies for production
-- Uncomment these and comment out the above policy for production use

-- Allow anyone to read users
-- CREATE POLICY "Allow public read access"
--     ON users FOR SELECT
--     USING (true);

-- Allow authenticated users to insert
-- CREATE POLICY "Allow authenticated insert"
--     ON users FOR INSERT
--     WITH CHECK (auth.role() = 'authenticated');

-- Allow users to update their own records
-- CREATE POLICY "Allow users to update own record"
--     ON users FOR UPDATE
--     USING (auth.uid()::text = id::text)
--     WITH CHECK (auth.uid()::text = id::text);

-- Allow users to delete their own records
-- CREATE POLICY "Allow users to delete own record"
--     ON users FOR DELETE
--     USING (auth.uid()::text = id::text);

-- Insert sample data for testing (optional)
INSERT INTO users (name, email, phone, address) VALUES
    ('John Doe', 'john.doe@example.com', '+91-9876543210', '123 Main St, Mumbai, India'),
    ('Jane Smith', 'jane.smith@example.com', '+91-9876543211', '456 Park Ave, Delhi, India'),
    ('Bob Johnson', 'bob.johnson@example.com', '+91-9876543212', '789 Oak Rd, Bangalore, India')
ON CONFLICT (email) DO NOTHING;

-- Verify table creation
SELECT 
    table_name,
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'users'
ORDER BY ordinal_position;

-- Display sample data
SELECT * FROM users LIMIT 5;

-- ============================================
-- Useful Queries for Testing
-- ============================================

-- Count total users
-- SELECT COUNT(*) as total_users FROM users;

-- Find user by email
-- SELECT * FROM users WHERE email = 'john.doe@example.com';

-- Search users by name
-- SELECT * FROM users WHERE name ILIKE '%john%';

-- Get recent users
-- SELECT * FROM users ORDER BY created_at DESC LIMIT 10;

-- Update user
-- UPDATE users SET phone = '+91-1234567890' WHERE email = 'john.doe@example.com';

-- Delete user
-- DELETE FROM users WHERE email = 'john.doe@example.com';

-- Clear all data (CAUTION!)
-- TRUNCATE TABLE users RESTART IDENTITY CASCADE;
