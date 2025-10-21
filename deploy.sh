#!/bin/bash

# BrickBit Deployment Script
# Run this script to deploy updates to your live site

echo "🚀 Starting deployment..."

# Check if we're in the right directory
if [ ! -f "artisan" ]; then
    echo "❌ Error: Not in Laravel project directory"
    exit 1
fi

# Pull latest changes
echo "📥 Pulling latest changes from git..."
git pull origin main

# Install/update dependencies
echo "📦 Installing dependencies..."
composer install --optimize-autoloader --no-dev --ignore-platform-req=php

# Clear and rebuild cache
echo "🧹 Clearing caches..."
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# Run database migrations
echo "🗃️  Running database migrations..."
php artisan migrate --force

# Cache configuration and routes for performance
echo "⚡ Caching for performance..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Set proper permissions
echo "🔐 Setting permissions..."
chmod -R 755 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache

# Optional: Restart web server (uncomment as needed)
# echo "🔄 Restarting web server..."
# sudo systemctl reload nginx
# sudo systemctl reload php8.1-fpm

echo "✅ Deployment completed successfully!"
echo "🌐 Your site should now be updated!"

# Optional: Run a quick health check
if command -v curl &> /dev/null; then
    echo "🏥 Running health check..."
    if curl -f -s http://localhost > /dev/null; then
        echo "✅ Site is responding correctly"
    else
        echo "⚠️  Site might have issues, check error logs"
    fi
fi