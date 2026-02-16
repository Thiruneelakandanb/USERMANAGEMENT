# Complete Setup Instructions

## Step 1: Create Table in Supabase

### Option A: Quick Setup (Recommended)
1. Go to your Supabase SQL Editor:
   https://supabase.com/dashboard/project/rhebewpkkimrlddyceax/sql

2. Copy and paste the contents of `supabase_simple_setup.sql`

3. Click "Run" to execute

### Option B: Full Setup with Timestamps
1. Go to your Supabase SQL Editor
2. Copy and paste the contents of `supabase_table_setup.sql`
3. Click "Run" to execute

## Step 2: Verify Table Creation

In Supabase Dashboard:
1. Go to **Table Editor**
2. You should see the `users` table
3. Click on it to view the structure

Expected columns:
- `id` (bigint, primary key, auto-increment)
- `name` (varchar, not null)
- `email` (varchar, not null, unique)
- `phone` (varchar, nullable)
- `address` (varchar, nullable)
- `created_at` (timestamp, optional)
- `updated_at` (timestamp, optional)

## Step 3: Test the Connection

### From Supabase Dashboard
Run this query in SQL Editor:
```sql
SELECT * FROM users;
```

You should see 3 sample users.

### From Your Application
1. Make sure the app is running: http://localhost:8081/
2. Open the browser and you should see the user management interface
3. The sample users should appear in the table

## Step 4: Test CRUD Operations

### Create a User
1. Fill in the form on the web page
2. Click "Save User"
3. Check Supabase dashboard to verify

### Read Users
- The table automatically loads all users
- Use the search box to filter

### Update a User
1. Click "Edit" on any user
2. Modify the details
3. Click "Update User"

### Delete a User
1. Click "Delete" on any user
2. Confirm the deletion
3. User is removed from database

## Troubleshooting

### Table Already Exists Error
If you get "table already exists", the app has already created it automatically. You can:
1. Use the existing table (recommended)
2. Or drop it first: `DROP TABLE users CASCADE;` then run the setup SQL

### Connection Issues
- Verify your internet connection
- Check Supabase project status
- Ensure credentials in `application.properties` are correct

### Data Not Showing
1. Check browser console for errors (F12)
2. Verify API endpoints are accessible:
   - http://localhost:8081/api/user/getall
3. Check Supabase RLS policies are set correctly

## Database Schema Comparison

### Java Entity (User.java)
```java
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    @Column(nullable = false, unique = true)
    private String email;
    
    private String phone;
    private String address;
    
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
```

### Supabase SQL
```sql
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(255),
    address VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

✅ **Perfect Match!** Both structures are identical.

## Next Steps

1. ✅ Table created in Supabase
2. ✅ Application connected to database
3. ✅ CRUD operations working
4. ✅ Modern UI ready to use

Your user management system is fully operational!

## Quick Reference

- **Application URL**: http://localhost:8081/
- **Supabase Dashboard**: https://supabase.com/dashboard/project/rhebewpkkimrlddyceax
- **API Base**: http://localhost:8081/api/user
- **Database**: postgres@rhebewpkkimrlddyceax.supabase.co
