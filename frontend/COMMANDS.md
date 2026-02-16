# 📝 Command Reference - Deploy Frontend to Vercel

## 🚀 Complete Deployment Commands

Copy and paste these commands in order:

### Step 1: Navigate to Frontend Folder
```bash
cd frontend-vercel
```

### Step 2: Add GitHub Remote
```bash
git remote add origin https://github.com/Thiruneelakandanb/user-management-frontend.git
```

### Step 3: Push to GitHub
```bash
git push -u origin main
```

### Step 4: Verify Push
```bash
git status
```

You should see: "Your branch is up to date with 'origin/main'"

## 🌐 Deploy on Vercel (Web Interface)

1. Open: https://vercel.com/
2. Click: **"Add New..."** → **"Project"**
3. Select: `user-management-frontend`
4. Click: **"Deploy"**

## ✅ Verification Commands

### Check Backend is Running
```bash
curl https://usermanagement-9oks.onrender.com/api/user/getall
```

Expected: JSON array of users

### Check Frontend (After Deployment)
Open in browser:
```
https://your-project-name.vercel.app/
```

## 🔄 Update Commands (Future Changes)

When you make changes to frontend:

```bash
cd frontend-vercel
git add .
git commit -m "Your update message"
git push origin main
```

Vercel will automatically redeploy!

## 🆘 Troubleshooting Commands

### Check Git Status
```bash
git status
```

### Check Remote URL
```bash
git remote -v
```

### View Commit History
```bash
git log --oneline
```

### Force Push (If Needed)
```bash
git push -f origin main
```

## 📋 Quick Reference

| Action | Command |
|--------|---------|
| Navigate to folder | `cd frontend-vercel` |
| Add remote | `git remote add origin URL` |
| Push code | `git push -u origin main` |
| Check status | `git status` |
| Update code | `git add . && git commit -m "msg" && git push` |

---

**Ready?** Start with Step 1 and run the commands in order!
