# Supabase Setup Guide

## Step 1: Create Supabase Project

1. Go to [https://supabase.com](https://supabase.com)
2. Sign up or log in
3. Click "New Project"
4. Fill in:
   - Project name: `user-management`
   - Database password: (save this!)
   - Region: Choose closest to you
5. Click "Create new project"

## Step 2: Get Database Connection Details

1. In your Supabase dashboard, go to **Settings** → **Database**
2. Find the **Connection String** section
3. Copy the connection details:
   - Host: `db.[your-project-ref].supabase.co`
   - Database: `postgres`
   - Port: `5432`
   - User: `postgres`
   - Password: (your database password)

## Step 3: Update application.properties

Open `src/main/resources/application.properties` and update:

```properties
spring.datasource.url=jdbc:postgresql://db.[your-project-ref].supabase.co:5432/postgres
spring.datasource.username=postgres
spring.datasource.password=[your-database-password]
```

## Step 4: Create Users Table (Optional)

The application will auto-create the table, but you can also create it manually:

1. Go to **SQL Editor** in Supabase
2. Run this SQL:

```sql
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(50),
    address TEXT
);
```

## Step 5: Run the Application

```bash
./mvnw spring-boot:run
```

Or on Windows:
```cmd
mvnw.cmd spring-boot:run
```

## Step 6: Access the Application

Open your browser and go to:
- **Main Page**: http://localhost:8080/
- **API Endpoints**:
  - GET all users: http://localhost:8080/api/user/getall
  - GET user by ID: http://localhost:8080/api/user/get/{id}
  - POST create user: http://localhost:8080/api/user/create
  - PUT update user: http://localhost:8080/api/user/update
  - DELETE user: http://localhost:8080/api/user/delete/{id}

## Troubleshooting

### Connection Issues
- Verify your Supabase project is active
- Check if your IP is allowed (Supabase allows all by default)
- Confirm database password is correct

### Port Already in Use
If port 8080 is busy, change it in `application.properties`:
```properties
server.port=8081
```

### Table Not Created
Check logs for errors. Ensure `spring.jpa.hibernate.ddl-auto=update` is set.
