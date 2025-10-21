FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libgd-dev \
    jpegoptim optipng pngquant gifsicle \
    libfontconfig1 \
    libxrender1 \
    libxtst6 \
    wget \
    xvfb

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u 1000 -d /home/brickbit brickbit
RUN mkdir -p /home/brickbit/.composer && \
    chown -R brickbit:brickbit /home/brickbit

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=brickbit:brickbit . /var/www

# Install dependencies
RUN composer install --optimize-autoloader --no-dev --ignore-platform-req=php

# Set permissions
RUN chown -R brickbit:brickbit /var/www
RUN chmod -R 755 /var/www/storage
RUN chmod -R 755 /var/www/bootstrap/cache

# Change current user to brickbit
USER brickbit

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]