# 🚀 Deploy to Vercel - Step by Step

## ✅ Code is Ready!

Your Node.js API is now on GitHub and ready for Vercel deployment.

## 📋 Follow These Steps Exactly

### Step 1: Go to Vercel
Visit: **https://vercel.com/**

Click **"Sign Up"** or **"Login"** (use GitHub)

### Step 2: Import Project
1. Click **"Add New..."** button (top right)
2. Select **"Project"**
3. Click **"Import Git Repository"**
4. Find and select: **`Thiruneelakandanb/USERMANAGEMENT`**
5. Click **"Import"**

### Step 3: Configure Project
Leave these settings as default:
- Framework Preset: **Other**
- Root Directory: **`./`**
- Build Command: (leave empty)
- Output Directory: (leave empty)

### Step 4: Add Environment Variables
Click **"Environment Variables"** section

Add these 5 variables (copy exactly):

**Variable 1:**
- Name: `SUPABASE_DB_HOST`
- Value: `aws-1-ap-south-1.pooler.supabase.com`

**Variable 2:**
- Name: `SUPABASE_DB_PORT`
- Value: `6543`

**Variable 3:**
- Name: `SUPABASE_DB_NAME`
- Value: `postgres`

**Variable 4:**
- Name: `SUPABASE_DB_USERNAME`
- Value: `postgres.rhebewpkkimrlddyceax`

**Variable 5:**
- Name: `SUPABASE_DB_PASSWORD`
- Value: `elm12HSk3YRBOtWf`

**Important:** For each variable, make sure to select all three environments:
- ✅ Production
- ✅ Preview
- ✅ Development

### Step 5: Deploy
Click **"Deploy"** button

Wait 1-2 minutes for deployment to complete.

### Step 6: Get Your URL
After deployment succeeds:
- You'll see: **"Congratulations! Your project has been deployed"**
- Click **"Visit"** or copy the URL
- Your URL will be like: `https://usermanagement-xxx.vercel.app`

## 🧪 Test Your Deployment

Replace `YOUR_URL` with your actual Vercel URL:

### Test 1: Check Frontend
Open in browser:
```
https://YOUR_URL.vercel.app/
```
You should see your User Management UI.

### Test 2: Check API
Open in browser or use curl:
```
https://YOUR_URL.vercel.app/api/user/getall
```
You should see JSON array of users.

### Test 3: Create User
```powershell
curl -X POST https://YOUR_URL.vercel.app/api/user/create -H "Content-Type: application/json" -d "{\"name\":\"Test User\",\"email\":\"test@example.com\",\"phone\":\"+91-1234567890\",\"address\":\"Test Address\"}"
```

## ⚠️ Before Testing: Create Database Table

If you get errors, you need to create the `users` table in Supabase:

1. Go to: https://supabase.com/dashboard/project/rhebewpkkimrlddyceax/sql
2. Paste this SQL:

```sql
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(255),
    address VARCHAR(255)
);

ALTER TABLE users ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow all operations on users"
    ON users FOR ALL
    USING (true)
    WITH CHECK (true);

INSERT INTO users (name, email, phone, address) VALUES
    ('John Doe', 'john.doe@example.com', '+91-9876543210', '123 Main St, Mumbai'),
    ('Jane Smith', 'jane.smith@example.com', '+91-9876543211', '456 Park Ave, Delhi'),
    ('Bob Johnson', 'bob.johnson@example.com', '+91-9876543212', '789 Oak Rd, Bangalore')
ON CONFLICT (email) DO NOTHING;
```

3. Click **"Run"**

## 🎉 Success Checklist

- [ ] Vercel project created
- [ ] All 5 environment variables added
- [ ] Deployment successful
- [ ] Frontend loads at your Vercel URL
- [ ] API returns data at `/api/user/getall`
- [ ] Can create users via UI
- [ ] Can edit/delete users

## 🔄 Auto-Deployment

From now on, every time you push to GitHub:
```bash
git add .
git commit -m "Update"
git push origin main
```

Vercel will automatically redeploy your app!

## 🆘 Troubleshooting

### "Internal Server Error" on API
- Check environment variables are set correctly
- Verify Supabase project is active (not paused)
- Check Vercel deployment logs

### "Table does not exist"
- Run the SQL script in Supabase (see above)

### Frontend loads but API doesn't work
- Check browser console for errors
- Verify API URL in browser: `https://YOUR_URL.vercel.app/api/health`

### Need to see logs
1. Go to Vercel dashboard
2. Click your project
3. Click **"Deployments"**
4. Click latest deployment
5. Click **"Functions"** tab
6. Click **"View Logs"**

## 📱 Share Your App

Once deployed, share your URL:
```
https://YOUR_URL.vercel.app
```

Anyone can access it worldwide!

## 💰 Cost

**FREE!** Vercel free tier includes:
- ✅ Unlimited deployments
- ✅ Automatic HTTPS
- ✅ Global CDN
- ✅ 100GB bandwidth/month
- ✅ Serverless functions

---

**Ready?** Go to https://vercel.com/ and start Step 1!
