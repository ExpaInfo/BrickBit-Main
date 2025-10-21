#!/bin/bash

# BrickBit Initialization Script
# This ensures all required directories and permissions are set up correctly

set -e  # Exit on error

echo "🚀 Initializing BrickBit Laravel Application..."

# Create all required storage directories
echo "📁 Creating storage directories..."
mkdir -p storage/app/public
mkdir -p storage/framework/cache/data
mkdir -p storage/framework/sessions
mkdir -p storage/framework/views
mkdir -p storage/logs
mkdir -p bootstrap/cache

# Set proper permissions
echo "🔐 Setting permissions..."
chmod -R 755 storage
chmod -R 755 bootstrap/cache

# Create .env from example if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from .env.example..."
    cp .env.example .env
fi

# Clear all caches
echo "🧹 Clearing caches..."
php artisan config:clear || true
php artisan cache:clear || true
php artisan view:clear || true
php artisan route:clear || true

# Generate application key if needed
if grep -q "APP_KEY=$" .env || grep -q "APP_KEY=\s*$" .env; then
    echo "🔑 Generating application key..."
    php artisan key:generate --force
fi

# Create storage link
echo "🔗 Creating storage link..."
php artisan storage:link || true

# Check database connection
echo "🗄️  Checking database connection..."
php artisan migrate:status || echo "⚠️  Database not accessible yet (this is normal for first deploy)"

echo "✅ Initialization complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Configure your .env file with proper database credentials"
echo "   2. Run: php artisan migrate --seed"
echo "   3. Run: php artisan serve"
echo ""