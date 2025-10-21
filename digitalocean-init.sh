#!/bin/bash

# Run this in DigitalOcean Console to fix your site
# App Platform Console -> Select your app -> Console tab -> Run this script

echo "🚀 Initializing BrickBit on DigitalOcean..."

# Clear all caches
echo "🧹 Clearing caches..."
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

# Run database migrations
echo "🗄️  Running database migrations..."
php artisan migrate --force

# Seed database with initial data
echo "🌱 Seeding database..."
php artisan db:seed --force --class=RequiredSeeder || echo "Seeder may not exist yet"

# Create storage link
echo "🔗 Creating storage symlink..."
php artisan storage:link

# Optimize for production
echo "⚡ Optimizing..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Check database connection
echo "✅ Checking database..."
php artisan migrate:status

echo ""
echo "🎉 Initialization complete!"
echo ""
echo "If your site still shows nothing:"
echo "1. Check APP_URL in environment variables"
echo "2. Make sure database migrations ran successfully"
echo "3. Check logs: php artisan log:tail"
echo ""