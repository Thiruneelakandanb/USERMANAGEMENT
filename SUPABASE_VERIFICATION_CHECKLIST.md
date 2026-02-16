# Supabase Credential Verification Checklist

Use this checklist to verify and correct your Supabase database credentials.

## 📋 Step-by-Step Verification

### Step 1: Access Supabase Dashboard

🔗 **URL**: https://supabase.com/dashboard/project/rhebewpkkimrlddyceax

- [ ] Dashboard loads successfully
- [ ] Project is visible
- [ ] Project status shows "Active" (not paused/suspended)

### Step 2: Navigate to Database Settings

**Path**: Settings → Database

- [ ] Database settings page loads
- [ ] Connection info section is visible

### Step 3: Verify Connection Details

Copy the exact values from the dashboard:

#### Direct Connection (Port 5432)
```
Host: ___________________________________
Database: ________________________________
Port: ____________________________________
User: ____________________________________
Password: ________________________________
```

#### Connection Pooling (Port 6543)
```
Host: ___________________________________
Database: ________________________________
Port: ____________________________________
User: ____________________________________
Password: ________________________________
```

### Step 4: Check Connection String Format

From the dashboard, the connection string should look like:

**Session Mode (Direct)**:
```
postgresql://postgres:[YOUR-PASSWORD]@db.rhebewpkkimrlddyceax.supabase.co:5432/postgres
```

**Transaction Mode (Pooler)**:
```
postgresql://postgres.[PROJECT-REF]:[YOUR-PASSWORD]@aws-0-ap-south-1.pooler.supabase.com:6543/postgres
```

- [ ] Connection string is visible
- [ ] Password is not masked (click "Show" if needed)
- [ ] Project reference matches: `rhebewpkkimrlddyceax`

### Step 5: Verify Password

Current password in `.env`: `elm12HSk3YRBOtWf`

- [ ] Password matches exactly (case-sensitive)
- [ ] No extra spaces or characters
- [ ] If unsure, reset password and update `.env`

### Step 6: Check Connection Pooling Status

**Path**: Settings → Database → Connection Pooling

- [ ] Connection pooling is enabled
- [ ] Pool mode is set (Transaction or Session)
- [ ] Pooler connection string is available

### Step 7: Verify Network Access

**Path**: Settings → Database → Network Restrictions

- [ ] No IP restrictions (or your IP is whitelisted)
- [ ] SSL mode is enabled
- [ ] No firewall rules blocking access

### Step 8: Test Database Connectivity

From your local machine:

```powershell
# Test pooler connection
Test-NetConnection -ComputerName aws-0-ap-south-1.pooler.supabase.com -Port 6543

# Expected result:
# TcpTestSucceeded : True
```

- [ ] Connection test succeeds
- [ ] Port 6543 is reachable

## 🔧 Update Application Configuration

Once verified, update `.env` file:

```env
# Use the EXACT values from Supabase dashboard
SUPABASE_DB_URL=jdbc:postgresql://[HOST]:[PORT]/[DATABASE]?user=[USER]
SUPABASE_DB_USERNAME=[USER]
SUPABASE_DB_PASSWORD=[PASSWORD]
```

### Example (Pooler Connection):
```env
SUPABASE_DB_URL=jdbc:postgresql://aws-0-ap-south-1.pooler.supabase.com:6543/postgres?user=postgres.rhebewpkkimrlddyceax
SUPABASE_DB_USERNAME=postgres.rhebewpkkimrlddyceax
SUPABASE_DB_PASSWORD=elm12HSk3YRBOtWf
```

## ✅ Final Verification

After updating `.env`:

1. **Restart the application**:
   ```cmd
   .\mvnw.cmd spring-boot:run
   ```

2. **Check console output** for:
   - [ ] "HikariPool-1 - Start completed"
   - [ ] "Started FirstAppApplication in X seconds"
   - [ ] No connection errors

3. **Test API**:
   ```powershell
   curl http://localhost:8081/api/user/getall
   ```
   - [ ] Returns `[]` or user data (not error)

4. **Open UI**:
   ```
   http://localhost:8081/
   ```
   - [ ] Page loads successfully
   - [ ] No console errors (F12)

## 🆘 If Still Failing

### Common Issues:

**Issue**: "Tenant or user not found"
- **Solution**: Username format is wrong. Try:
  - `postgres` (simple)
  - `postgres.rhebewpkkimrlddyceax` (with project ref)

**Issue**: "Connection timeout"
- **Solution**: Network/firewall blocking. Try:
  - Different network (mobile hotspot)
  - VPN connection
  - Contact network admin

**Issue**: "Password authentication failed"
- **Solution**: Reset password in Supabase dashboard

**Issue**: "Database does not exist"
- **Solution**: Verify database name is `postgres` (default)

## 📞 Need Help?

If verification fails, provide:

1. Screenshot of Supabase Database settings
2. Exact connection string from dashboard (mask password)
3. Error message from application console
4. Result of `Test-NetConnection` command

## 🎯 Success Criteria

✅ All checklist items completed
✅ Application starts without errors
✅ API endpoint responds
✅ UI loads successfully
✅ Can create/read/update/delete users

---

**Once all items are verified, the application will run successfully!**
