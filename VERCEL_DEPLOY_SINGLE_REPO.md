# 🚀 Deploy Frontend to Vercel (Single Repository)

## ✅ Setup Complete

Your frontend is now in the `frontend/` folder of your main repository.

## 📁 Repository Structure

```
USERMANAGEMENT/
├── frontend/              # Frontend files (for Vercel)
│   ├── index.html
│   ├── styles.css
│   ├── script.js
│   └── ...
├── src/                   # Spring Boot backend (for Render)
├── pom.xml
└── vercel.json           # Vercel configuration
```

## 🎯 Deploy to Vercel

### Step 1: Push to GitHub (if not already done)

```bash
cd SpringBoot-Java
git add .
git commit -m "Add frontend for Vercel deployment"
git push origin main
```

### Step 2: Deploy on Vercel

1. Go to: **https://vercel.com/**
2. Click **"Add New..."** → **"Project"**
3. Import: **`USERMANAGEMENT`** (your existing repo)
4. Configure:
   - **Root Directory**: Leave as `./`
   - **Framework Preset**: Other
   - **Build Command**: (leave empty)
   - **Output Directory**: `frontend`
5. Click **"Deploy"**

## 🌐 Result

After deployment:
- **Frontend (Vercel)**: `https://your-project.vercel.app/`
- **Backend (Render)**: `https://usermanagement-9oks.onrender.com`

Both from the SAME repository!

## 📝 Important Notes

- Vercel will only deploy the `frontend/` folder
- Render will continue to deploy the Spring Boot backend
- Both services read from the same GitHub repository
- No conflicts - they deploy different parts

## 🔄 Future Updates

**Update Frontend:**
```bash
cd SpringBoot-Java/frontend
# Make changes to HTML/CSS/JS
cd ..
git add frontend/
git commit -m "Update frontend"
git push origin main
# Vercel auto-redeploys
```

**Update Backend:**
```bash
cd SpringBoot-Java
# Make changes to Java code
git add src/
git commit -m "Update backend"
git push origin main
# Render auto-redeploys
```

## ✅ Advantages

- ✅ Single repository to manage
- ✅ Both services auto-deploy from same repo
- ✅ Easier version control
- ✅ Simpler workflow

---

**Ready?** Go to https://vercel.com/ and import your `USERMANAGEMENT` repository!
