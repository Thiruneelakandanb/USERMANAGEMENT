# Deployment Guide

## ✅ GitHub Repository

Your code is now available at:
**https://github.com/Thiruneelakandanb/USERMANAGEMENT**

## ⚠️ Important: Vercel Limitation

**Vercel does NOT support Spring Boot applications.** Vercel is designed for:
- Frontend frameworks (React, Next.js, Vue, etc.)
- Node.js/Serverless functions
- Static sites

Your Spring Boot backend requires a Java runtime environment, which Vercel doesn't provide.

## 🚀 Recommended Deployment Options for Spring Boot

### Option 1: Railway (Easiest - Free Tier Available)

**Best for**: Quick deployment with free tier

1. Visit: https://railway.app/
2. Sign in with GitHub
3. Click **"New Project"** → **"Deploy from GitHub repo"**
4. Select: `Thiruneelakandanb/USERMANAGEMENT`
5. Railway will auto-detect Spring Boot
6. Add environment variables:
   ```
   SUPABASE_DB_URL=jdbc:postgresql://aws-1-ap-south-1.pooler.supabase.com:6543/postgres
   SUPABASE_DB_USERNAME=postgres.rhebewpkkimrlddyceax
   SUPABASE_DB_PASSWORD=elm12HSk3YRBOtWf
   SERVER_PORT=8080
   ```
7. Click **Deploy**

**Pros:**
- Free tier available ($5 credit/month)
- Auto-deployment from GitHub
- Easy setup
- Built-in PostgreSQL if needed

**Cons:**
- Limited free tier hours

### Option 2: Render (Free Tier Available)

**Best for**: Production-ready free hosting

1. Visit: https://render.com/
2. Sign in with GitHub
3. Click **"New"** → **"Web Service"**
4. Connect your GitHub repo: `USERMANAGEMENT`
5. Configure:
   - **Name**: user-management-api
   - **Environment**: Java
   - **Build Command**: `./mvnw clean install`
   - **Start Command**: `java -jar target/firstApp-0.0.1-SNAPSHOT.jar`
6. Add environment variables (same as above)
7. Click **Create Web Service**

**Pros:**
- Free tier (750 hours/month)
- Auto-deployment
- Custom domains
- SSL included

**Cons:**
- Slower cold starts on free tier

### Option 3: Heroku (Paid - Most Popular)

**Best for**: Enterprise-grade deployment

1. Visit: https://heroku.com/
2. Install Heroku CLI: https://devcenter.heroku.com/articles/heroku-cli
3. Run commands:
   ```bash
   heroku login
   heroku create user-management-spring
   heroku config:set SUPABASE_DB_URL=jdbc:postgresql://aws-1-ap-south-1.pooler.supabase.com:6543/postgres
   heroku config:set SUPABASE_DB_USERNAME=postgres.rhebewpkkimrlddyceax
   heroku config:set SUPABASE_DB_PASSWORD=elm12HSk3YRBOtWf
   git push heroku main
   ```

**Pros:**
- Industry standard
- Excellent documentation
- Add-ons ecosystem
- Reliable

**Cons:**
- No free tier (starts at $5/month)

### Option 4: AWS Elastic Beanstalk (Enterprise)

**Best for**: Scalable production deployment

1. Visit: https://aws.amazon.com/elasticbeanstalk/
2. Create application
3. Upload JAR file or connect GitHub
4. Configure environment variables
5. Deploy

**Pros:**
- Highly scalable
- AWS ecosystem integration
- Auto-scaling
- Load balancing

**Cons:**
- More complex setup
- Costs can increase with usage

### Option 5: Google Cloud Run (Serverless)

**Best for**: Serverless Spring Boot

1. Create Dockerfile (see below)
2. Push to Google Container Registry
3. Deploy to Cloud Run

**Pros:**
- Pay per use
- Auto-scaling
- Free tier available

**Cons:**
- Requires Docker knowledge

## 📦 Docker Deployment (For Any Platform)

Create `Dockerfile` in project root:

```dockerfile
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY target/firstApp-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

Build and run:
```bash
./mvnw clean package
docker build -t user-management .
docker run -p 8080:8080 \
  -e SUPABASE_DB_URL=jdbc:postgresql://aws-1-ap-south-1.pooler.supabase.com:6543/postgres \
  -e SUPABASE_DB_USERNAME=postgres.rhebewpkkimrlddyceax \
  -e SUPABASE_DB_PASSWORD=elm12HSk3YRBOtWf \
  user-management
```

## 🌐 Frontend Deployment (Can Use Vercel)

If you want to deploy ONLY the frontend (HTML/CSS/JS) to Vercel:

### Step 1: Create Separate Frontend Repo

1. Create new folder: `user-management-frontend`
2. Copy files:
   - `src/main/resources/static/index.html`
   - `src/main/resources/static/styles.css`
   - `src/main/resources/static/script.js`
3. Update `script.js` to point to your deployed backend API

### Step 2: Deploy to Vercel

1. Visit: https://vercel.com/
2. Import GitHub repository
3. Deploy

### Step 3: Update API URL

In `script.js`, change:
```javascript
const API_BASE_URL = 'https://your-backend-url.railway.app/api/user';
```

## 🔐 Security Checklist Before Deployment

- [ ] Remove `.env` from repository (already in `.gitignore`)
- [ ] Use environment variables for all secrets
- [ ] Enable HTTPS/SSL
- [ ] Configure CORS properly for production
- [ ] Update Supabase RLS policies
- [ ] Use strong database passwords
- [ ] Enable rate limiting
- [ ] Add authentication/authorization

## 📊 Recommended Architecture

```
┌─────────────────┐
│   Vercel        │  ← Frontend (HTML/CSS/JS)
│   (Frontend)    │
└────────┬────────┘
         │ HTTPS
         ↓
┌─────────────────┐
│   Railway       │  ← Backend (Spring Boot)
│   (Backend)     │
└────────┬────────┘
         │ JDBC
         ↓
┌─────────────────┐
│   Supabase      │  ← Database (PostgreSQL)
│   (Database)    │
└─────────────────┘
```

## 🎯 Quick Start: Railway Deployment

**Fastest way to deploy your Spring Boot app:**

1. Go to https://railway.app/new
2. Click **"Deploy from GitHub repo"**
3. Select `USERMANAGEMENT`
4. Add environment variables
5. Deploy!

Your app will be live in ~5 minutes at: `https://your-app.railway.app`

## 📝 Post-Deployment

After deployment:
1. Test all API endpoints
2. Verify database connection
3. Check application logs
4. Monitor performance
5. Set up custom domain (optional)

## 🆘 Need Help?

- Railway Docs: https://docs.railway.app/
- Render Docs: https://render.com/docs
- Spring Boot Deployment: https://spring.io/guides/gs/spring-boot-docker/

---

**Recommendation**: Start with Railway for the easiest deployment experience with your Spring Boot application.
