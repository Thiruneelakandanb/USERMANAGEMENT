# 🚀 Vercel Deployment Guide

## ⚠️ Important Note

Since Vercel doesn't support Java/Spring Boot, I've created a **Node.js/Express API** that provides the same functionality and connects to your Supabase database.

## 📁 New Files Created

- `api/index.js` - Node.js API (replaces Spring Boot)
- `package.json` - Node.js dependencies
- `vercel.json` - Vercel configuration
- `.env.vercel` - Environment variables template

## 🚀 Deploy to Vercel (5 Minutes)

### Step 1: Push New Files to GitHub

```bash
cd SpringBoot-Java
git add .
git commit -m "Add Vercel Node.js API"
git push origin main
```

### Step 2: Import to Vercel

1. Go to https://vercel.com/
2. Click **"Add New"** → **"Project"**
3. Import your GitHub repository: `Thiruneelakandanb/USERMANAGEMENT`
4. Click **"Import"**

### Step 3: Configure Environment Variables

In Vercel dashboard, go to **Settings** → **Environment Variables** and add:

| Name | Value |
|------|-------|
| `SUPABASE_DB_HOST` | `aws-1-ap-south-1.pooler.supabase.com` |
| `SUPABASE_DB_PORT` | `6543` |
| `SUPABASE_DB_NAME` | `postgres` |
| `SUPABASE_DB_USERNAME` | `postgres.rhebewpkkimrlddyceax` |
| `SUPABASE_DB_PASSWORD` | `elm12HSk3YRBOtWf` |

**Important:** Add these to all environments (Production, Preview, Development)

### Step 4: Deploy

Click **"Deploy"**

Vercel will:
- Install Node.js dependencies
- Build your application
- Deploy frontend and API
- Give you a public URL

### Step 5: Get Your URL

After deployment (~2 minutes):
- Your app will be at: `https://your-project.vercel.app`
- API will be at: `https://your-project.vercel.app/api/user/getall`

## 🧪 Test Your Deployed API

Replace `YOUR_URL` with your Vercel URL:

```bash
# Get all users
curl https://YOUR_URL.vercel.app/api/user/getall

# Create user
curl -X POST https://YOUR_URL.vercel.app/api/user/create \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","phone":"+91-1234567890","address":"Test Address"}'

# Get user by ID
curl https://YOUR_URL.vercel.app/api/user/get/1

# Update user
curl -X PUT https://YOUR_URL.vercel.app/api/user/update \
  -H "Content-Type: application/json" \
  -d '{"id":1,"name":"Updated Name","email":"updated@example.com","phone":"+91-9999999999","address":"New Address"}'

# Delete user
curl -X DELETE https://YOUR_URL.vercel.app/api/user/delete/1
```

## 📊 What Changed?

### Before (Spring Boot - Not Vercel Compatible)
```
Java Runtime → Spring Boot → PostgreSQL
❌ Vercel doesn't support Java
```

### After (Node.js - Vercel Compatible)
```
Node.js Runtime → Express API → PostgreSQL
✅ Vercel fully supports Node.js
```

## 🔄 API Endpoints (Same as Before)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/user/getall` | Get all users |
| GET | `/api/user/get/:id` | Get user by ID |
| POST | `/api/user/create` | Create new user |
| PUT | `/api/user/update` | Update user |
| DELETE | `/api/user/delete/:id` | Delete user |
| GET | `/api/health` | Health check |

## 🌐 Frontend Access

Your frontend will automatically work at:
- `https://your-project.vercel.app/` (main page)
- `https://your-project.vercel.app/index.html`

The frontend will automatically connect to the API on the same domain.

## 🔧 Local Testing (Optional)

To test locally before deploying:

```bash
# Install dependencies
npm install

# Create .env file
cp .env.vercel .env

# Run locally
npm run dev
```

Visit: http://localhost:3000/

## 🔄 Auto-Deployment

Every time you push to GitHub, Vercel automatically:
1. Pulls latest code
2. Rebuilds application
3. Redeploys

Just run:
```bash
git add .
git commit -m "Update feature"
git push origin main
```

## 🎯 Architecture

```
┌─────────────────────────────────┐
│         Vercel                  │
│  ┌──────────┐    ┌──────────┐  │
│  │ Frontend │    │ Node.js  │  │
│  │   HTML   │───▶│   API    │  │
│  │ CSS/JS   │    │ Express  │  │
│  └──────────┘    └─────┬────┘  │
└────────────────────────┼────────┘
                         │ JDBC
                         ▼
              ┌──────────────────┐
              │    Supabase      │
              │   PostgreSQL     │
              └──────────────────┘
```

## ✅ Advantages of Node.js API

- ✅ Fully compatible with Vercel
- ✅ Serverless (auto-scaling)
- ✅ Free tier (unlimited requests)
- ✅ Same functionality as Spring Boot
- ✅ Faster cold starts
- ✅ Lower memory usage

## 🆘 Troubleshooting

### Build Fails
- Check Vercel build logs
- Verify `package.json` is in root directory
- Ensure Node.js version is 18+

### Database Connection Error
- Verify environment variables in Vercel
- Check Supabase project is active
- Test connection from Vercel logs

### API Returns 404
- Check `vercel.json` routing configuration
- Verify API files are in `/api` folder
- Check deployment logs

### CORS Errors
- CORS is already configured in `api/index.js`
- If issues persist, check browser console

## 📝 Environment Variables Checklist

Before deploying, ensure these are set in Vercel:

- [ ] `SUPABASE_DB_HOST`
- [ ] `SUPABASE_DB_PORT`
- [ ] `SUPABASE_DB_NAME`
- [ ] `SUPABASE_DB_USERNAME`
- [ ] `SUPABASE_DB_PASSWORD`

## 🎉 You're Done!

Your application is now:
- ✅ Deployed on Vercel
- ✅ Using Node.js API (Vercel compatible)
- ✅ Connected to Supabase
- ✅ Accessible worldwide
- ✅ Auto-deploying from GitHub
- ✅ 100% FREE (Vercel free tier)

## 🔗 Useful Links

- Vercel Dashboard: https://vercel.com/dashboard
- Vercel Docs: https://vercel.com/docs
- Your GitHub Repo: https://github.com/Thiruneelakandanb/USERMANAGEMENT

---

**Next Step:** Push the new files to GitHub and import to Vercel!
