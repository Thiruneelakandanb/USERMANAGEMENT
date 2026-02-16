-- ============================================
-- Verify Existing Users Table Structure
-- ============================================
-- Run this to see what columns already exist
-- ============================================

-- Check table structure
SELECT 
    column_name,
    data_type,
    character_maximum_length,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'users'
ORDER BY ordinal_position;

-- Check constraints
SELECT
    tc.constraint_name,
    tc.constraint_type,
    kcu.column_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
WHERE tc.table_name = 'users';

-- View current data
SELECT * FROM users;

-- Count records
SELECT COUNT(*) as total_users FROM users;
