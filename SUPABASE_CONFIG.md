# Supabase Configuration Guide

## Your Supabase Credentials

### Database Connection Details
- **Project Reference**: rhebewpkkimrlddyceax
- **Region**: ap-south-1 (Asia Pacific - Mumbai)
- **Database**: postgres
- **Username**: postgres.rhebewpkkimrlddyceax
- **Password**: elm12HSk3YRBOtWf

### Connection URLs

#### 1. Direct Connection (Port 5432) - Best for Development
```
jdbc:postgresql://aws-0-ap-south-1.pooler.supabase.com:5432/postgres?sslmode=require
```
Use this for:
- Local development
- Direct database access
- Hibernate DDL operations (create/update tables)

#### 2. Pooler Connection (Port 6543) - Best for Production
```
jdbc:postgresql://aws-0-ap-south-1.pooler.supabase.com:6543/postgres?sslmode=require&pgbouncer=true
```
Use this for:
- Production deployments
- High-traffic applications
- Connection pooling optimization

### Supabase API Details
- **URL**: https://rhebewpkkimrlddyceax.supabase.co
- **Anon Key**: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJoZWJld3Bra2ltcmxkZHljZWF4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA3OTUxODgsImV4cCI6MjA4NjM3MTE4OH0.17qiZA-D1-t9Uy0cVov6YrImoDkfJjrZcYw4LfW7AgY
- **Service Role Key**: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJoZWJld3Bra2ltcmxkZHljZWF4Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MDc5NTE4OCwiZXhwIjoyMDg2MzcxMTg4fQ.SheT6BHkUSL8xyBlodl0Bj1Gwih3WOaTowoQxk_g0LY

## Current Configuration (application.properties)

```properties
# Supabase PostgreSQL Configuration
spring.datasource.url=jdbc:postgresql://aws-0-ap-south-1.pooler.supabase.com:5432/postgres?sslmode=require
spring.datasource.username=postgres.rhebewpkkimrlddyceax
spring.datasource.password=elm12HSk3YRBOtWf
spring.datasource.driver-class-name=org.postgresql.Driver

# JPA Configuration
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.properties.hibernate.format_sql=true

# Server Configuration
server.port=8081
```

## Database Schema

The application automatically creates this table:

```sql
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(255),
    address VARCHAR(255)
);
```

## Testing the Connection

### 1. Using Supabase Dashboard
1. Go to https://supabase.com/dashboard
2. Select your project: rhebewpkkimrlddyceax
3. Navigate to **Table Editor**
4. You should see the `users` table

### 2. Using SQL Editor
Run this query in Supabase SQL Editor:
```sql
SELECT * FROM users;
```

### 3. Using Your Application
- Open: http://localhost:8081/
- Try adding a user through the UI
- Check Supabase dashboard to verify data

## Connection String Formats

### For Spring Boot (JDBC)
```
jdbc:postgresql://[HOST]:[PORT]/[DATABASE]?sslmode=require
```

### For Node.js/JavaScript
```javascript
const { createClient } = require('@supabase/supabase-js')

const supabase = createClient(
  'https://rhebewpkkimrlddyceax.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJoZWJld3Bra2ltcmxkZHljZWF4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA3OTUxODgsImV4cCI6MjA4NjM3MTE4OH0.17qiZA-D1-t9Uy0cVov6YrImoDkfJjrZcYw4LfW7AgY'
)
```

### For Python
```python
from supabase import create_client, Client

url = "https://rhebewpkkimrlddyceax.supabase.co"
key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJoZWJld3Bra2ltcmxkZHljZWF4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA3OTUxODgsImV4cCI6MjA4NjM3MTE4OH0.17qiZA-D1-t9Uy0cVov6YrImoDkfJjrZcYw4LfW7AgY"
supabase: Client = create_client(url, key)
```

## Troubleshooting

### Connection Timeout
If you get connection timeouts:
1. Check your internet connection
2. Verify Supabase project is active
3. Try the alternative pooler URL

### Authentication Failed
- Double-check username: `postgres.rhebewpkkimrlddyceax`
- Verify password: `elm12HSk3YRBOtWf`
- Ensure SSL mode is enabled

### Port Already in Use
If port 8081 is busy, change in application.properties:
```properties
server.port=8082
```

## Security Notes

⚠️ **Important**: Never commit credentials to public repositories!

For production:
1. Use environment variables
2. Store credentials in secure vaults
3. Use the Service Role Key only on backend
4. Use Anon Key for frontend/client applications

## Environment Variables (Recommended)

Create a `.env` file (add to .gitignore):
```env
SUPABASE_URL=https://rhebewpkkimrlddyceax.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SUPABASE_DB_URL=jdbc:postgresql://aws-0-ap-south-1.pooler.supabase.com:5432/postgres
SUPABASE_DB_USER=postgres.rhebewpkkimrlddyceax
SUPABASE_DB_PASSWORD=elm12HSk3YRBOtWf
```

Then reference in application.properties:
```properties
spring.datasource.url=${SUPABASE_DB_URL}
spring.datasource.username=${SUPABASE_DB_USER}
spring.datasource.password=${SUPABASE_DB_PASSWORD}
```
