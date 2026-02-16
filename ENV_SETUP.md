# Environment Variables Setup

## Why Use Environment Variables?

✅ **Security**: Keeps sensitive credentials out of source code
✅ **Flexibility**: Easy to change configurations without code changes
✅ **Best Practice**: Industry standard for managing secrets

## Setup Instructions

### 1. Environment Variables are Already Configured

The `.env` file has been created with your Supabase credentials:

```env
SUPABASE_DB_URL=jdbc:postgresql://db.rhebewpkkimrlddyceax.supabase.co:5432/postgres
SUPABASE_DB_USERNAME=postgres
SUPABASE_DB_PASSWORD=elm12HSk3YRBOtWf
SUPABASE_URL=https://rhebewpkkimrlddyceax.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SERVER_PORT=8081
```

### 2. The .env File is Protected

✅ Added to `.gitignore` - won't be committed to Git
✅ Credentials stay secure on your local machine

### 3. How It Works

The `application.properties` file now uses environment variables:

```properties
spring.datasource.url=${SUPABASE_DB_URL:jdbc:postgresql://...}
spring.datasource.username=${SUPABASE_DB_USERNAME:postgres}
spring.datasource.password=${SUPABASE_DB_PASSWORD:your-password}
```

The format `${VAR_NAME:default_value}` means:
- Use the environment variable if it exists
- Otherwise, use the default value

### 4. Running the Application

Simply run as normal:
```cmd
.\mvnw.cmd spring-boot:run
```

The spring-dotenv library automatically loads variables from `.env` file.

## For Production Deployment

### Option 1: System Environment Variables (Recommended)

Set environment variables in your system:

**Windows:**
```cmd
setx SUPABASE_DB_URL "jdbc:postgresql://db.rhebewpkkimrlddyceax.supabase.co:5432/postgres"
setx SUPABASE_DB_USERNAME "postgres"
setx SUPABASE_DB_PASSWORD "elm12HSk3YRBOtWf"
```

**Linux/Mac:**
```bash
export SUPABASE_DB_URL="jdbc:postgresql://db.rhebewpkkimrlddyceax.supabase.co:5432/postgres"
export SUPABASE_DB_USERNAME="postgres"
export SUPABASE_DB_PASSWORD="elm12HSk3YRBOtWf"
```

### Option 2: Cloud Platform Environment Variables

Most cloud platforms (Heroku, AWS, Azure, etc.) provide UI to set environment variables.

### Option 3: Docker

In `docker-compose.yml`:
```yaml
environment:
  - SUPABASE_DB_URL=jdbc:postgresql://...
  - SUPABASE_DB_USERNAME=postgres
  - SUPABASE_DB_PASSWORD=your-password
```

## Files Structure

```
SpringBoot-Java/
├── .env                    # Your actual credentials (NOT in Git)
├── .env.example           # Template without real credentials (safe to commit)
├── .gitignore             # Ensures .env is not committed
└── src/main/resources/
    └── application.properties  # Uses environment variables
```

## Security Best Practices

✅ Never commit `.env` to Git
✅ Share `.env.example` with your team (without real credentials)
✅ Use different credentials for development and production
✅ Rotate passwords regularly
✅ Use read-only database users when possible

## Troubleshooting

### Variables Not Loading?

1. Check `.env` file exists in project root
2. Verify spring-dotenv dependency in `pom.xml`
3. Restart the application after changing `.env`

### Still Using Default Values?

The application will use default values from `application.properties` if:
- `.env` file is missing
- Environment variables are not set
- Variable names don't match exactly

This is intentional - the app can still run with defaults!
