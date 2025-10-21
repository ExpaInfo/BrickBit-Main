# 🔧 Site Deployed But Showing Nothing? Fix It!

## Your site is UP but shows a blank page or error? Here's how to fix it:

### 🚀 Quick Fix (Run in DigitalOcean Console)

1. **Go to DigitalOcean App Platform**
2. **Click on your app** → "Console" tab
3. **Run this script:**

```bash
bash digitalocean-init.sh
```

### 📋 Manual Fix Steps (if script doesn't work)

Run these commands one by one in the DigitalOcean Console:

```bash
# 1. Clear all caches
php artisan config:clear
php artisan cache:clear
php artisan route:clear  
php artisan view:clear

# 2. Run database migrations
php artisan migrate --force

# 3. Check migration status
php artisan migrate:status

# 4. Seed database (if seeders exist)
php artisan db:seed --force --class=RequiredSeeder

# 5. Create storage link
php artisan storage:link

# 6. Optimize for production
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

### 🔍 Check What's Wrong

```bash
# Check application logs
tail -f storage/logs/laravel.log

# Or use Laravel command
php artisan log:tail

# Check if database is connected
php artisan tinker
>>> DB::connection()->getPdo();
>>> exit
```

### 🐛 Common Issues & Solutions

#### Issue 1: Blank White Page
**Cause:** APP_KEY not set or migrations not run  
**Solution:**
```bash
php artisan key:generate --force
php artisan migrate --force
```

#### Issue 2: "500 Internal Server Error"
**Cause:** Database connection issue or missing environment variables  
**Solution:** Check in DigitalOcean:
- Settings → Environment Variables
- Make sure all database variables are set correctly
- Verify DB_HOST, DB_PORT, DB_DATABASE, DB_USERNAME, DB_PASSWORD

#### Issue 3: "Route Not Found" 
**Cause:** Routes not cached or APP_URL wrong  
**Solution:**
```bash
php artisan route:clear
php artisan route:cache
```
Also check: APP_URL in environment variables should match your domain

#### Issue 4: "No Application Encryption Key"
**Cause:** APP_KEY environment variable not set  
**Solution:**
```bash
php artisan key:generate --force
```
Or manually set in DigitalOcean environment variables:
```
APP_KEY=base64:zz1Qkl2BYRacIZlksfSquJ5A+jbfEjCWc/cZzJ11iRk=
```

#### Issue 5: Database Tables Don't Exist
**Cause:** Migrations haven't run  
**Solution:**
```bash
# Check which migrations need to run
php artisan migrate:status

# Run all migrations
php artisan migrate --force

# If migrations fail, check database connection
php artisan config:clear
php artisan migrate --force
```

### ✅ Verify Site Is Working

1. **Check Home Page:**
   - Visit your app URL (e.g., https://brickbit-xxxxx.ondigitalocean.app)
   - Should show the BrickHill homepage

2. **Check Database:**
   ```bash
   php artisan migrate:status
   ```
   Should show all migrations as "Ran"

3. **Check Logs:**
   ```bash
   tail -n 50 storage/logs/laravel.log
   ```
   Should not show errors

### 🔄 Force Redeploy

If nothing works, force a complete redeploy:

1. In DigitalOcean App Platform
2. Click "Actions" → "Force Rebuild and Deploy"
3. Wait for deployment to complete
4. Run `bash digitalocean-init.sh` in Console

### 🆘 Still Not Working?

**Check these environment variables in DigitalOcean:**

Required variables:
```
APP_NAME=BrickBit.net
APP_ENV=production
APP_KEY=base64:zz1Qkl2BYRacIZlksfSquJ5A+jbfEjCWc/cZzJ11iRk=
APP_DEBUG=false
APP_URL=https://YOUR-APP-URL.ondigitalocean.app
DB_CONNECTION=mysql
DB_HOST=your-db-host
DB_PORT=25060
DB_DATABASE=defaultdb
DB_USERNAME=doadmin
DB_PASSWORD=your-db-password
LOG_CHANNEL=stderr
```

### 💡 Debug Mode (Temporary)

To see actual errors, temporarily enable debug mode:

1. In DigitalOcean → Settings → Environment Variables
2. Change: `APP_DEBUG=true`
3. Redeploy
4. Visit your site to see the actual error message
5. **DON'T FORGET to set `APP_DEBUG=false` after fixing!**

### 📞 Last Resort

If absolutely nothing works:

1. Check **Runtime Logs** in DigitalOcean (bottom of app page)
2. Look for PHP errors or database connection errors
3. Make sure **MySQL database** is properly connected under "Database" tab
4. Make sure all environment variables from `DIGITALOCEAN_ENV_VARS.md` are set

---

**Most Common Fix:**  
Just run `bash digitalocean-init.sh` in the DigitalOcean console! 🎉