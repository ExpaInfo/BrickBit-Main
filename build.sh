#!/bin/bash

echo "🔧 Starting build process..."

# Ensure we're using PHP 8.1
export PHP_VERSION=8.1

# Clear composer cache first
echo "🧹 Clearing composer cache..."
composer clear-cache

# Install dependencies with more permissive settings
echo "📦 Installing PHP dependencies..."
COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader --ignore-platform-req=php --ignore-platform-req=ext-* --no-scripts

# Create necessary directories
echo "📁 Creating storage directories..."
mkdir -p storage/app/public
mkdir -p storage/framework/cache
mkdir -p storage/framework/sessions  
mkdir -p storage/framework/views
mkdir -p storage/logs
mkdir -p bootstrap/cache

# Set permissions
echo "🔐 Setting permissions..."
chmod -R 755 storage
chmod -R 755 bootstrap/cache

# Run composer scripts manually
echo "🔧 Running composer scripts..."
composer run-script post-autoload-dump || true

echo "✅ Build completed successfully!"
