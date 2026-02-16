# Quick Supabase Reset Checklist

Use this checklist to quickly verify and fix Supabase authentication issues.

## ⚡ Quick Diagnosis

Current Error: `FATAL: Tenant or user not found`

**This means**: Supabase cannot authenticate with the provided credentials.

## 🔍 5-Minute Fix

### Step 1: Check Project Status (30 seconds)

1. Open: https://supabase.com/dashboard/project/rhebewpkkimrlddyceax
2. Look at the top of the page
3. **If you see "Project Paused"**:
   - Click **"Resume Project"**
   - Wait 30-60 seconds for activation
   - ✅ This often fixes the issue immediately

### Step 2: Get Fresh Connection String (2 minutes)

1. In Supabase Dashboard, go to: **Settings** → **Database**
2. Scroll to **"Connection string"** section
3. Select **"URI"** tab
4. Click **"Show"** to reveal the password
5. Copy the entire connection string

**It should look like:**
```
postgresql://postgres.[PROJECT]:[PASSWORD]@aws-0-ap-south-1.pooler.supabase.com:6543/postgres
```

### Step 3: Extract Credentials (1 minute)

From the connection string, extract:

**Format**: `postgresql://[USERNAME]:[PASSWORD]@[HOST]:[PORT]/[DATABASE]`

Example:
```
postgresql://postgres.rhebewpkkimrlddyceax:abc123xyz@aws-0-ap-south-1.pooler.supabase.com:6543/postgres
```

Extract:
- **Username**: `postgres.rhebewpkkimrlddyceax`
- **Password**: `abc123xyz`
- **Host**: `aws-0-ap-south-1.pooler.supabase.com`
- **Port**: `6543`
- **Database**: `postgres`

### Step 4: Update Configuration (1 minute)

Open `.env` file and update:

```env
SUPABASE_DB_URL=jdbc:postgresql://[HOST]:[PORT]/[DATABASE]
SUPABASE_DB_USERNAME=[USERNAME]
SUPABASE_DB_PASSWORD=[PASSWORD]
```

**Example**:
```env
SUPABASE_DB_URL=jdbc:postgresql://aws-0-ap-south-1.pooler.supabase.com:6543/postgres
SUPABASE_DB_USERNAME=postgres.rhebewpkkimrlddyceax
SUPABASE_DB_PASSWORD=abc123xyz
```

### Step 5: Restart Application (30 seconds)

```cmd
.\mvnw.cmd spring-boot:run
```

Watch for:
- ✅ "HikariPool-1 - Start completed"
- ✅ "Started FirstAppApplication"
- ❌ No connection errors

## 🎯 Success Indicators

Application started successfully if you see:
```
Started FirstAppApplication in X.XXX seconds
Tomcat started on port 8081
```

Test the API:
```bash
curl http://localhost:8081/api/user/getall
```

Expected: `[]` (empty array) or user data

## 🔄 Alternative: Reset Password

If the connection string password doesn't work:

1. In Supabase Dashboard: **Settings** → **Database**
2. Click **"Reset database password"**
3. Copy the NEW password
4. Update `.env` file
5. Restart application

## ⚠️ Common Mistakes

### ❌ Wrong Username Format
```env
# WRONG (missing project reference)
SUPABASE_DB_USERNAME=postgres

# CORRECT (with project reference)
SUPABASE_DB_USERNAME=postgres.rhebewpkkimrlddyceax
```

### ❌ Wrong Port
```env
# WRONG (direct connection port - blocked by firewall)
SUPABASE_DB_URL=jdbc:postgresql://db.rhebewpkkimrlddyceax.supabase.co:5432/postgres

# CORRECT (pooler port - works behind firewalls)
SUPABASE_DB_URL=jdbc:postgresql://aws-0-ap-south-1.pooler.supabase.com:6543/postgres
```

### ❌ Extra Spaces or Characters
```env
# WRONG (space after password)
SUPABASE_DB_PASSWORD=abc123xyz 

# CORRECT (no extra spaces)
SUPABASE_DB_PASSWORD=abc123xyz
```

## 📋 Verification Checklist

Before running the application, verify:

- [ ] Supabase project status is **Active** (not paused)
- [ ] Connection string copied from **Settings → Database → Connection string → URI**
- [ ] Username includes project reference: `postgres.[project-ref]`
- [ ] Password is current (no spaces, exact match)
- [ ] Using pooler host: `aws-0-ap-south-1.pooler.supabase.com`
- [ ] Using pooler port: `6543`
- [ ] `.env` file saved with correct values
- [ ] No typos in any credential

## 🆘 Still Not Working?

### Test Connection Manually

```powershell
# Test if pooler is reachable
Test-NetConnection -ComputerName aws-0-ap-south-1.pooler.supabase.com -Port 6543
```

Expected: `TcpTestSucceeded : True`

### Check Application Logs

Look for the exact error in console output:
- "Tenant or user not found" → Wrong username/password
- "Connection timeout" → Network/firewall issue
- "Database does not exist" → Wrong database name

### Share for Help

If still failing, provide:
1. Masked connection string (hide password)
2. Project status (active/paused)
3. Exact error message from console
4. Result of `Test-NetConnection` command

## 🎉 Expected Outcome

Once credentials are correct:
- Application starts in ~10-15 seconds
- No errors in console
- API responds at http://localhost:8081/api/user/getall
- UI loads at http://localhost:8081/

---

**Time to fix**: Usually 5 minutes or less
**Success rate**: 99% after following these steps
