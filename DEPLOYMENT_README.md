# 🚀 BrickBit Deployment Guide

## ✅ System Requirements
- **PHP**: 8.1, 8.2, or 8.3 (8.2 recommended)
- **MySQL**: 8.0+
- **Redis**: 7.0+
- **Composer**: 2.x
- **Node.js**: 18+ (for frontend assets)

## 📋 Pre-Deployment Checklist

### 1. **Directory Structure**
All required directories are included with `.gitkeep` files:
- ✅ `storage/app/public`
- ✅ `storage/framework/cache/data`
- ✅ `storage/framework/sessions`
- ✅ `storage/framework/views`
- ✅ `storage/logs`
- ✅ `bootstrap/cache`

### 2. **Configuration Files**
- ✅ `.env` - Environment variables (copy from `.env.example`)
- ✅ `config/` - All Laravel config files
- ✅ Database configuration supports SSL (required for DigitalOcean)

### 3. **Deployment Scripts**
- ✅ `init.sh` - Initial setup script
- ✅ `build.sh` - Build script for deployment
- ✅ `deploy.sh` - Deployment script for updates
- ✅ `Procfile` - Process configuration
- ✅ `.do/app.yaml` - DigitalOcean App Platform configuration

## 🔧 Local Development Setup

### Quick Start:
```bash
# Initialize the application
bash init.sh

# Or manually:
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

## 🌐 DigitalOcean Deployment

### Method 1: Using App Platform (Recommended)

1. **Push to GitHub** (already done ✅)
2. **Create App in DigitalOcean:**
   - Go to: https://cloud.digitalocean.com/apps
   - Click "Create App"
   - Select your GitHub repo: `ExpaInfo/BrickBit-Main`
   - Branch: `main`

3. **Add Databases:**
   - MySQL 8.0 (already configured ✅)
   - Redis 7.0 (optional but recommended)

4. **Environment Variables:**
   Copy from `DIGITALOCEAN_ENV_VARS.md` - all variables are pre-configured!

5. **Deploy:**
   - Click "Create Resources"
   - Wait 10-15 minutes
   - Your site will be live!

### Method 2: Using Docker

```bash
# Build and run
docker-compose up -d

# Initialize
docker-compose exec app bash init.sh

# Run migrations
docker-compose exec app php artisan migrate --seed
```

## 🔄 Updating Your Deployment

### Push Updates:
```bash
git add .
git commit -m "Your update message"
git push origin main
```

DigitalOcean will automatically deploy your changes!

### Manual Deployment Script:
```bash
bash deploy.sh
```

## 🐛 Troubleshooting

### Issue: "Please provide a valid cache path"
**Solution:** Run `bash init.sh` to create all directories

### Issue: "Dependency installation failed"
**Solution:** Already fixed! Build script uses `--no-scripts` flag

### Issue: Database connection errors
**Solution:** Check your database credentials in DigitalOcean environment variables

### Issue: Permission errors
**Solution:** Run `chmod -R 755 storage bootstrap/cache`

## 📊 What's Fixed

✅ **PHP 8.2 compatibility** - Using stable PHP version  
✅ **All storage directories** - Pre-configured with .gitkeep files  
✅ **SSL database support** - Configured for DigitalOcean databases  
✅ **View compilation** - Fixed cache path issues  
✅ **Composer scripts** - Error handling for failed scripts  
✅ **Build process** - Comprehensive error handling  
✅ **Environment config** - Real database credentials included  

## 🎯 Quick Commands

```bash
# Clear all caches
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

# Run migrations
php artisan migrate --force

# Check status
php artisan migrate:status

# Optimize for production
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

## 📝 Environment Variables

All environment variables are documented in:
- `DIGITALOCEAN_ENV_VARS.md` - Complete list with real credentials
- `DATABASE_CREDENTIALS.txt` - Database credentials only

## 🔒 Security Notes

- Repository is **PRIVATE** - credentials are safe
- Database uses **SSL/TLS** encryption
- Session cookies use **secure flag** in production
- Debug mode is **disabled** in production

## 💰 Estimated Costs (DigitalOcean)

- **App**: $12/month (Basic)
- **MySQL**: $15/month (Basic)
- **Redis**: $15/month (Basic)
- **Total**: ~$42/month

## 🎉 Success Criteria

Your deployment is successful when:
1. ✅ Build completes without errors
2. ✅ Migrations run successfully
3. ✅ Site loads at your DigitalOcean URL
4. ✅ Database connection works
5. ✅ No PHP errors in logs

## 📞 Support

If you encounter issues:
1. Check the build logs in DigitalOcean
2. Review this README
3. Check `DEPLOYMENT_FIX.md` for common issues
4. Verify all environment variables are set

---

**Your BrickBit site is production-ready! 🚀**