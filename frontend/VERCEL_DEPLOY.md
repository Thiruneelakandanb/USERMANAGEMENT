# 🚀 Deploy Frontend to Vercel - Step by Step

## 📋 Prerequisites

- ✅ Backend is running on Render: https://usermanagement-9oks.onrender.com
- ✅ Frontend files are ready in `frontend-vercel` folder

## 🎯 Deployment Steps

### Step 1: Create New GitHub Repository

1. Go to https://github.com/new
2. Repository name: `user-management-frontend`
3. Description: `User Management System Frontend`
4. Public repository
5. Click **"Create repository"**

### Step 2: Push Frontend to GitHub

Open terminal in the `frontend-vercel` folder:

```bash
cd frontend-vercel
git init
git add .
git commit -m "Initial commit - User Management Frontend"
git branch -M main
git remote add origin https://github.com/Thiruneelakandanb/user-management-frontend.git
git push -u origin main
```

### Step 3: Deploy to Vercel

1. Go to https://vercel.com/
2. Click **"Add New..."** (top right)
3. Select **"Project"**
4. Click **"Import Git Repository"**
5. Find and select: `user-management-frontend`
6. Click **"Import"**

### Step 4: Configure Project (Keep Defaults)

- Framework Preset: **Other**
- Root Directory: `./`
- Build Command: (leave empty)
- Output Directory: (leave empty)
- Install Command: (leave empty)

### Step 5: Deploy

Click **"Deploy"**

Wait 30-60 seconds for deployment to complete.

### Step 6: Get Your URL

After deployment:
- You'll see: **"Congratulations!"**
- Your URL will be like: `https://user-management-frontend.vercel.app`

## 🧪 Test Your Deployment

### Test 1: Open Frontend
```
https://your-frontend.vercel.app/
```

You should see the User Management UI.

### Test 2: Check API Connection

The frontend will automatically connect to your Render backend:
```
https://usermanagement-9oks.onrender.com/api/user/getall
```

### Test 3: Create a User

1. Click **"Add New User"**
2. Fill in the form
3. Click **"Save User"**
4. User should appear in the table

## 🎉 Success!

Your application is now fully deployed:

```
┌─────────────────────────────────┐
│   Frontend (Vercel)             │
│   https://your-app.vercel.app   │
└────────────┬────────────────────┘
             │ HTTPS
             ↓
┌─────────────────────────────────┐
│   Backend (Render)              │
│   Spring Boot API               │
│   https://usermanagement-       │
│   9oks.onrender.com             │
└────────────┬────────────────────┘
             │ JDBC
             ↓
┌─────────────────────────────────┐
│   Database (Supabase)           │
│   PostgreSQL                    │
└─────────────────────────────────┘
```

## 🔄 Auto-Deployment

Every time you push to GitHub:
```bash
git add .
git commit -m "Update frontend"
git push origin main
```

Vercel will automatically redeploy!

## 🆘 Troubleshooting

### CORS Error
If you see CORS errors in browser console:
- Your Spring Boot backend already has CORS enabled
- Wait a few seconds for Render backend to wake up (free tier)

### API Not Responding
- Check if Render backend is awake: https://usermanagement-9oks.onrender.com/api/user/getall
- Free tier apps sleep after inactivity (takes ~30 seconds to wake)

### Frontend Not Loading
- Check Vercel deployment logs
- Verify all files are pushed to GitHub
- Check browser console for errors

## 📝 Update API URL (If Needed)

If you need to change the backend URL, edit `script.js`:

```javascript
const API_BASE_URL = 'https://your-new-backend-url.com/api/user';
```

Then push to GitHub:
```bash
git add script.js
git commit -m "Update API URL"
git push origin main
```

## 💰 Cost

**100% FREE!**

- ✅ Vercel: Free tier (unlimited deployments)
- ✅ Render: Free tier (backend)
- ✅ Supabase: Free tier (database)
- ✅ GitHub: Free (public repositories)

## 🔗 Useful Links

- Vercel Dashboard: https://vercel.com/dashboard
- Render Dashboard: https://dashboard.render.com/
- Supabase Dashboard: https://supabase.com/dashboard
- GitHub Repo: https://github.com/Thiruneelakandanb/user-management-frontend

---

**Ready?** Start with Step 1 and create your GitHub repository!
