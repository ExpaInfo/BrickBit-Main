# DigitalOcean App Platform Setup Guide

## Step 1: Create GitHub Repository

1. **Initialize Git Repository (if not already done):**
   ```bash
   git init
   git add .
   git commit -m "Initial BrickBit deployment"
   ```

2. **Create Repository on GitHub:**
   - Go to https://github.com/new
   - Name it something like `brickbit-laravel` or `brick-hill-site`
   - Make it public or private (your choice)
   - Don't initialize with README (since you already have files)

3. **Push to GitHub:**
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git branch -M main
   git push -u origin main
   ```

## Step 2: Deploy to DigitalOcean

1. **Go to DigitalOcean Apps:** https://cloud.digitalocean.com/apps

2. **Create New App:**
   - Click "Create App"
   - Select "GitHub" as source
   - Connect your GitHub account
   - Select your repository
   - Select `main` branch

3. **App Configuration:**
   - DigitalOcean will auto-detect it's a PHP app
   - Keep the default settings

## Step 3: Environment Variables

In the DigitalOcean App Platform dashboard, add these environment variables:

### Required Variables:
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
```

### Database Variables (Auto-configured when you add MySQL):
```
DB_CONNECTION=mysql
DB_HOST=${db.HOSTNAME}
DB_PORT=${db.PORT}
DB_DATABASE=${db.DATABASE}
DB_USERNAME=${db.USERNAME}
DB_PASSWORD=${db.PASSWORD}
```

### Redis Variables (Auto-configured when you add Redis):
```
CACHE_DRIVER=redis
SESSION_DRIVER=redis
QUEUE_DRIVER=redis
REDIS_HOST=${redis.HOSTNAME}
REDIS_PORT=${redis.PORT}
REDIS_PASSWORD=${redis.PASSWORD}
```

## Step 4: Add Database Services

1. **Add MySQL Database:**
   - In your app dashboard, go to "Database" tab
   - Click "Add Database"
   - Select "MySQL"
   - Choose size (Basic $15/month is fine for testing)

2. **Add Redis Database:**
   - Click "Add Database" again
   - Select "Redis"
   - Choose Basic size

## Step 5: Optional Services (Add Later)

### Email Service (Recommended):
```
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@yourdomain.com
```

### File Storage (If using DigitalOcean Spaces):
```
STORAGE_DOMAIN=https://your-space.nyc3.digitaloceanspaces.com
AWS_ACCESS_KEY_ID=your-spaces-key
AWS_SECRET_ACCESS_KEY=your-spaces-secret
AWS_DEFAULT_REGION=nyc3
AWS_BUCKET=your-space-name
```

### reCAPTCHA (Optional):
```
RECAPTCHA_SECRET=your-recaptcha-secret
RECAPTCHA_PUBLIC=your-recaptcha-public
```

### Stripe (If processing payments):
```
STRIPE_TESTING_KEY_PUBLIC=pk_live_your-key
STRIPE_TESTING_KEY_SECRET=sk_live_your-key
STRIPE_TESTING_WEBHOOK_SECRET=whsec_your-webhook
```

## Step 6: Deploy!

1. **Deploy the App:**
   - Click "Create Resources"
   - DigitalOcean will build and deploy your app
   - This takes 5-10 minutes

2. **Run Migrations:**
   - Once deployed, go to the "Runtime Logs"
   - The app will automatically run `php artisan migrate --force` on deployment

## Step 7: Custom Domain (Optional)

1. **Add Domain:**
   - In app settings, go to "Domains" tab
   - Add your custom domain
   - Update your DNS to point to DigitalOcean

## Estimated Costs:
- **Basic App:** $12/month
- **MySQL Database:** $15/month  
- **Redis Database:** $15/month
- **Total:** ~$42/month

For testing, you can use the $7/month database options.

## Quick Deployment Checklist:
- [ ] Create GitHub repository
- [ ] Push code to GitHub
- [ ] Create DigitalOcean App
- [ ] Add MySQL database
- [ ] Add Redis database
- [ ] Configure environment variables
- [ ] Deploy and test

## Need Help?
If you get stuck, the most common issues are:
1. **Database connection errors:** Check that DB environment variables are set
2. **Key errors:** Make sure APP_KEY is set correctly
3. **Permission errors:** DigitalOcean handles this automatically

Your app will be live at: `https://your-app-name-xxxxx.ondigitalocean.app`