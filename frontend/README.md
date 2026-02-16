# User Management System - Frontend

Frontend for User Management System deployed on Vercel.

## 🌐 Live URLs

- **Frontend (Vercel)**: Will be available after deployment
- **Backend API (Render)**: https://usermanagement-9oks.onrender.com

## 🚀 Deploy to Vercel

### Step 1: Create GitHub Repository

```bash
cd frontend-vercel
git init
git add .
git commit -m "Initial commit - User Management Frontend"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/user-management-frontend.git
git push -u origin main
```

### Step 2: Deploy to Vercel

1. Go to https://vercel.com/
2. Click **"Add New..."** → **"Project"**
3. Import your GitHub repository
4. Click **"Deploy"**

That's it! No environment variables needed.

## 📡 API Configuration

The frontend is configured to connect to your Render backend:
```javascript
const API_BASE_URL = 'https://usermanagement-9oks.onrender.com/api/user';
```

## 🔧 Local Development

To run locally:

1. Open `index.html` in your browser, or
2. Use a local server:
   ```bash
   # Using Python
   python -m http.server 8000
   
   # Using Node.js
   npx serve
   ```

## 📁 Files

- `index.html` - Main HTML file
- `styles.css` - Styling
- `script.js` - JavaScript logic (connects to Render API)
- `vercel.json` - Vercel configuration

## 🎯 Features

- View all users
- Add new users
- Edit existing users
- Delete users
- Search functionality
- Responsive design
- Toast notifications

## 🔗 Architecture

```
Frontend (Vercel)
    ↓ HTTPS
Backend (Render) ← Spring Boot
    ↓ JDBC
Database (Supabase) ← PostgreSQL
```

## ✅ CORS Configuration

Your Spring Boot backend already has CORS enabled in `WebConfig.java` to allow requests from any origin.

## 📝 Notes

- Frontend is static HTML/CSS/JS (no build step required)
- Backend API is on Render (Spring Boot)
- Database is on Supabase (PostgreSQL)
- All three services work together seamlessly
