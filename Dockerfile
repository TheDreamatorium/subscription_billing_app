# Use PHP 8.3 FPM (minimum requirement for Symfony 7)
FROM php:8.3-fpm-alpine

# Install system dependencies and PHP extensions
RUN apk add --no-cache \
    git \
    unzip \
    libzip-dev \
    icu-dev \
    libpng-dev \
    postgresql-dev \
    && docker-php-ext-install \
    pdo_pgsql \
    zip \
    intl \
    opcache

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Install dependencies (optional: use --no-dev for production)
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer install --no-interaction --optimize-autoloader

# Expose port 9000 for PHP-FPM
EXPOSE 9000

CMD ["php-fpm"]
