# Deployment Guide

## Overview

This guide covers deploying the Hello World GitHub Actions Demo application to various platforms and environments.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [GitHub Setup](#github-setup)
3. [Local Deployment](#local-deployment)
4. [Cloud Deployment Options](#cloud-deployment-options)
5. [Docker Deployment](#docker-deployment)
6. [Monitoring and Maintenance](#monitoring-and-maintenance)

## Prerequisites

Before deploying, ensure you have:

- ✅ GitHub account with repository access
- ✅ Node.js 18+ installed
- ✅ Git configured locally
- ✅ Basic understanding of CI/CD concepts

## GitHub Setup

### 1. Create Repository

```bash
# Initialize git (if not already done)
git init

# Add remote repository
git remote add origin https://github.com/yourusername/hello-world-github-actions-demo.git

# Add all files
git add .

# Commit changes
git commit -m "Initial commit: Hello World with GitHub Actions"

# Push to GitHub
git push -u origin main
```

### 2. Configure GitHub Actions

GitHub Actions will automatically detect the workflow file at `.github/workflows/ci-cd.yml` and start running on the next push.

**Verify Setup**:
1. Go to your repository on GitHub
2. Click the "Actions" tab
3. You should see the "CI/CD Pipeline" workflow

### 3. Branch Protection (Optional but Recommended)

1. Go to Settings → Branches
2. Add rule for `main` branch
3. Enable:
   - ✅ Require status checks to pass before merging
   - ✅ Require branches to be up to date before merging
   - ✅ Include administrators

### 4. Secrets Configuration

If you need to add secrets (for future enhancements):

1. Go to Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Add secrets like:
   - `NPM_TOKEN` (for npm publishing)
   - `DEPLOY_KEY` (for server deployment)
   - `DATABASE_URL` (for database connection)

## Local Deployment

### Development Mode

```bash
# Start the server
npm start

# Or with custom port
PORT=8080 npm start

# Or with custom host
HOST=0.0.0.0 PORT=8080 npm start
```

### Production Mode (Local)

```bash
# Install PM2 globally
npm install -g pm2

# Start with PM2
pm2 start src/index.js --name hello-world

# View logs
pm2 logs hello-world

# Monitor
pm2 monit

# Stop
pm2 stop hello-world

# Restart
pm2 restart hello-world
```

## Cloud Deployment Options

### Option 1: Heroku

**Step 1: Install Heroku CLI**
```bash
# macOS
brew tap heroku/brew && brew install heroku

# Or download from https://devcenter.heroku.com/articles/heroku-cli
```

**Step 2: Create Heroku App**
```bash
# Login to Heroku
heroku login

# Create app
heroku create your-app-name

# Deploy
git push heroku main

# Open app
heroku open
```

**Step 3: Add Procfile**
Create `Procfile` in root:
```
web: node src/index.js
```

### Option 2: AWS EC2

**Step 1: Launch EC2 Instance**
1. Choose Ubuntu Server 22.04 LTS
2. Select t2.micro (free tier)
3. Configure security group (allow port 80, 443, 22)

**Step 2: Connect and Setup**
```bash
# SSH into instance
ssh -i your-key.pem ubuntu@your-ec2-ip

# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Install PM2
sudo npm install -g pm2

# Clone repository
git clone https://github.com/yourusername/hello-world-github-actions-demo.git
cd hello-world-github-actions-demo

# Install dependencies
npm install

# Start with PM2
pm2 start src/index.js --name hello-world
pm2 startup
pm2 save
```

**Step 3: Configure Nginx (Optional)**
```bash
# Install Nginx
sudo apt install -y nginx

# Configure reverse proxy
sudo nano /etc/nginx/sites-available/default
```

Add:
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

```bash
# Restart Nginx
sudo systemctl restart nginx
```

### Option 3: DigitalOcean

**Step 1: Create Droplet**
1. Choose Ubuntu 22.04
2. Select Basic plan ($6/month)
3. Add SSH key

**Step 2: Setup (Same as AWS EC2)**
Follow AWS EC2 steps 2-3

### Option 4: Vercel

**Step 1: Install Vercel CLI**
```bash
npm install -g vercel
```

**Step 2: Deploy**
```bash
# Login
vercel login

# Deploy
vercel

# Production deployment
vercel --prod
```

**Note**: You'll need to create `vercel.json`:
```json
{
  "version": 2,
  "builds": [
    {
      "src": "src/index.js",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "src/index.js"
    }
  ]
}
```

### Option 5: Railway

**Step 1: Connect GitHub**
1. Go to https://railway.app
2. Sign up with GitHub
3. Click "New Project"
4. Select "Deploy from GitHub repo"
5. Choose your repository

**Step 2: Configure**
Railway will auto-detect Node.js and deploy automatically.

## Docker Deployment

### Create Dockerfile

Create `Dockerfile` in root:
```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm ci --only=production

COPY src ./src

EXPOSE 3000

CMD ["node", "src/index.js"]
```

### Create .dockerignore

Create `.dockerignore`:
```
node_modules
npm-debug.log
.git
.gitignore
README.md
.env
_*
```

### Build and Run

```bash
# Build image
docker build -t hello-world-app .

# Run container
docker run -p 3000:3000 hello-world-app

# Run in background
docker run -d -p 3000:3000 --name hello-world hello-world-app

# View logs
docker logs hello-world

# Stop container
docker stop hello-world
```

### Docker Compose

Create `docker-compose.yml`:
```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - PORT=3000
    restart: unless-stopped
```

Run with:
```bash
docker-compose up -d
```

## Automated Deployment with GitHub Actions

### Deploy to Server via SSH

Add to `.github/workflows/ci-cd.yml`:

```yaml
- name: Deploy to Production Server
  if: github.ref == 'refs/heads/main'
  uses: appleboy/ssh-action@master
  with:
    host: ${{ secrets.SERVER_HOST }}
    username: ${{ secrets.SERVER_USER }}
    key: ${{ secrets.SSH_PRIVATE_KEY }}
    script: |
      cd /path/to/app
      git pull origin main
      npm install
      pm2 restart hello-world
```

### Deploy to Docker Hub

```yaml
- name: Build and Push Docker Image
  run: |
    docker login -u ${{ secrets.DOCKER_USERNAME }} -p ${{ secrets.DOCKER_PASSWORD }}
    docker build -t yourusername/hello-world:latest .
    docker push yourusername/hello-world:latest
```

## Monitoring and Maintenance

### Health Checks

Set up automated health checks:

```bash
# Using curl in cron
*/5 * * * * curl -f http://your-domain.com/health || echo "Health check failed"
```

### Logging

**PM2 Logs**:
```bash
pm2 logs hello-world
pm2 logs hello-world --lines 100
```

**System Logs**:
```bash
# View application logs
journalctl -u hello-world -f
```

### Monitoring Tools

1. **PM2 Plus**: https://pm2.io
2. **New Relic**: https://newrelic.com
3. **Datadog**: https://www.datadoghq.com
4. **Uptime Robot**: https://uptimerobot.com

### Backup Strategy

```bash
# Backup script
#!/bin/bash
DATE=$(date +%Y%m%d-%H%M%S)
tar -czf backup-$DATE.tar.gz /path/to/app
# Upload to S3 or backup location
```

### Updates and Maintenance

```bash
# Update dependencies
npm update

# Check for vulnerabilities
npm audit

# Fix vulnerabilities
npm audit fix

# Update Node.js
nvm install 18
nvm use 18
```

## Rollback Procedure

### Git Rollback

```bash
# View commit history
git log --oneline

# Rollback to previous commit
git revert HEAD

# Or reset to specific commit
git reset --hard <commit-hash>
git push -f origin main
```

### PM2 Rollback

```bash
# If using PM2 with ecosystem file
pm2 reload ecosystem.config.js --update-env
```

## Troubleshooting

### Common Issues

**Port Already in Use**:
```bash
# Find and kill process
lsof -ti:3000 | xargs kill -9
```

**Permission Denied**:
```bash
# Fix permissions
sudo chown -R $USER:$USER /path/to/app
```

**Out of Memory**:
```bash
# Increase Node.js memory
NODE_OPTIONS="--max-old-space-size=4096" node src/index.js
```

## Security Checklist

- [ ] Use environment variables for sensitive data
- [ ] Enable HTTPS with SSL certificate
- [ ] Set up firewall rules
- [ ] Regular security updates
- [ ] Implement rate limiting
- [ ] Use strong authentication
- [ ] Regular backups
- [ ] Monitor logs for suspicious activity

## Performance Optimization

1. **Enable Compression**
2. **Use CDN for static assets**
3. **Implement caching**
4. **Use load balancer for multiple instances**
5. **Optimize database queries**
6. **Monitor and profile performance**

---

**Need Help?** Open an issue on GitHub or consult the [User Guide](UserGuide.md).

*Last Updated: 2026-05-07*