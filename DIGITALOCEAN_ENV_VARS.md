# 🔧 DigitalOcean Environment Variables

Copy these **EXACT** environment variables into your DigitalOcean App Platform dashboard:

## **Core Application Variables:**
```
APP_NAME=BrickBit.net
APP_ENV=production
APP_KEY=base64:zz1Qkl2BYRacIZlksfSquJ5A+jbfEjCWc/cZzJ11iRk=
APP_DEBUG=false
APP_URL=${APP_URL}
FAKE_NOTIFICATIONS=false
L5_SWAGGER_GENERATE_ALWAYS=false
MAIN_ACCOUNT_ID=1003
SESSION_COOKIE=bh_session
SESSION_DOMAIN=.${APP_DOMAIN}
LOG_CHANNEL=stderr
LOG_LEVEL=info
PHP_VERSION=8.2
COMPOSER_ALLOW_SUPERUSER=1
```

## **Database Variables (Your DigitalOcean MySQL):**
```
DB_CONNECTION=mysql
DB_HOST=db-brickbit-do-user-27781557-0.f.db.ondigitalocean.com
DB_PORT=25060
DB_DATABASE=defaultdb
DB_USERNAME=doadmin
DB_PASSWORD=AVNS_vwc0u32s-wrI916VvN2
DB_SSLMODE=REQUIRED
```

## **Redis Variables (Add when you create Redis database):**
```
CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_DRIVER=redis
REDIS_HOST=${redis.HOSTNAME}
REDIS_PORT=${redis.PORT}
REDIS_PASSWORD=${redis.PASSWORD}
```

## **Storage Variables:**
```
STORAGE_DOMAIN=${APP_URL}/storage
STORAGE_PENDING_512=/default/pending.png
STORAGE_PENDING_SET=/default/pendingset.png
STORAGE_DECLINED_512=/default/declined.png
STORAGE_DECLINED_SET=/default/declinedset.png
STORAGE_AVATARS_LOC=/images/avatars/
STORAGE_ITEMS_LOC=/v2/images/shop/thumbnails/
STORAGE_FILE_LOC=storage/app/public/assets
```

## **CAPTCHA (Optional - add when needed):**
```
HCAPTCHA_SECRET=0x0000000000000000000000000000000000000000
HCAPTCHA_PUBLIC=10000000-ffff-ffff-ffff-000000000001
```

## **OAuth:**
```
PASSPORT_PERSONAL_ACCESS_CLIENT_ID=1
PASSPORT_PERSONAL_ACCESS_CLIENT_SECRET=
```

---

## 📋 **Step-by-Step Setup:**

1. **Push your latest code:**
   ```bash
   git add .
   git commit -m "Add database configuration and SSL support"
   git push origin main
   ```

2. **In DigitalOcean Dashboard:**
   - Go to your app
   - Click "Settings" → "App-Level Environment Variables"
   - Add all the variables above (copy/paste each one)

3. **Add Redis Database:**
   - Go to "Database" tab
   - Click "Add Database" 
   - Select "Redis"
   - Choose basic size ($15/month)

4. **Deploy:**
   - Click "Actions" → "Force Rebuild and Deploy"
   - Monitor the build logs for success

## ✅ **What should happen:**
1. Build completes with PHP 8.1
2. Database migrations run automatically
3. App starts successfully 
4. You get a live URL like: `https://brickbit-xxxxx.ondigitalocean.app`

## 🚨 **If migration fails:**
The app might start but show database errors. You'll need to run migrations manually:
- In DigitalOcean Console, run: `php artisan migrate --force`

Your BrickBit site should be live within 10-15 minutes! 🎉