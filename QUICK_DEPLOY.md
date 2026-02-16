# 🚀 Quick Deploy Guide

## ✅ GitHub - DONE!

Your code is live at:
**https://github.com/Thiruneelakandanb/USERMANAGEMENT**

## ⚠️ Vercel Won't Work for Spring Boot

Vercel only supports:
- Frontend (React, Next.js, Vue)
- Node.js serverless functions

Your Spring Boot app needs Java runtime, which Vercel doesn't provide.

## 🎯 Deploy in 5 Minutes: Railway (Recommended)

### Step 1: Sign Up
Visit: https://railway.app/

Click **"Login with GitHub"**

### Step 2: Create New Project
1. Click **"New Project"**
2. Select **"Deploy from GitHub repo"**
3. Choose: `Thiruneelakandanb/USERMANAGEMENT`

### Step 3: Add Environment Variables
Click **"Variables"** tab and add:

```
SUPABASE_DB_URL=jdbc:postgresql://aws-1-ap-south-1.pooler.supabase.com:6543/postgres
SUPABASE_DB_USERNAME=postgres.rhebewpkkimrlddyceax
SUPABASE_DB_PASSWORD=elm12HSk3YRBOtWf
SERVER_PORT=8080
```

### Step 4: Deploy
Click **"Deploy"**

Railway will:
- Detect Spring Boot automatically
- Build your application
- Deploy it
- Give you a public URL

### Step 5: Get Your URL
After deployment completes (~3-5 minutes):
- Click **"Settings"** → **"Generate Domain"**
- Your app will be at: `https://your-app.up.railway.app`

## 🧪 Test Your Deployed API

Replace `YOUR_URL` with your Railway URL:

```powershell
# Get all users
curl https://YOUR_URL.up.railway.app/api/user/getall

# Create user
curl -X POST https://YOUR_URL.up.railway.app/api/user/create \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","phone":"+91-1234567890","address":"Test Address"}'
```

## 🌐 Deploy Frontend to Vercel (Optional)

If you want the frontend on Vercel:

### Step 1: Create Frontend-Only Repo
1. Create new folder: `user-management-frontend`
2. Copy these files:
   ```
   index.html (from src/main/resources/static/)
   styles.css (from src/main/resources/static/)
   script.js (from src/main/resources/static/)
   ```

### Step 2: Update API URL
In `script.js`, change line 1:
```javascript
const API_BASE_URL = 'https://YOUR_RAILWAY_URL.up.railway.app/api/user';
```

### Step 3: Deploy to Vercel
1. Push frontend folder to new GitHub repo
2. Go to https://vercel.com/
3. Click **"Import Project"**
4. Select your frontend repo
5. Click **"Deploy"**

## 📊 Architecture After Deployment

```
Frontend (Vercel)
    ↓ HTTPS
Backend (Railway) ← Spring Boot
    ↓ JDBC
Database (Supabase) ← PostgreSQL
```

## 💰 Cost Breakdown

| Service | Free Tier | Cost |
|---------|-----------|------|
| GitHub | ✅ Unlimited public repos | Free |
| Railway | ✅ $5 credit/month | Free to start |
| Vercel | ✅ Unlimited deployments | Free |
| Supabase | ✅ 500MB database | Free |

**Total**: $0/month for small projects!

## 🔄 Auto-Deployment

Once set up, every time you push to GitHub:
- Railway automatically rebuilds and redeploys backend
- Vercel automatically redeploys frontend

Just run:
```bash
git add .
git commit -m "Update feature"
git push origin main
```

## 🆘 Troubleshooting

### Railway Build Fails
- Check build logs in Railway dashboard
- Ensure `mvnw` has execute permissions
- Verify environment variables are set

### Can't Connect to Database
- Verify Supabase credentials
- Check if Supabase project is active (not paused)
- Test connection from Railway logs

### Frontend Can't Reach Backend
- Check CORS configuration in `WebConfig.java`
- Verify API URL in `script.js`
- Check Railway deployment status

## 📝 Next Steps

1. ✅ Deploy backend to Railway
2. ✅ Test API endpoints
3. ✅ Deploy frontend to Vercel (optional)
4. ✅ Update frontend API URL
5. ✅ Test full application
6. ✅ Set up custom domain (optional)

## 🎉 You're Done!

Your application is now:
- ✅ Hosted on Railway
- ✅ Connected to Supabase
- ✅ Accessible worldwide
- ✅ Auto-deploying from GitHub

---

**Need help?** Check `DEPLOYMENT_GUIDE.md` for detailed instructions.
