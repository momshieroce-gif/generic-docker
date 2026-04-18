#!/bin/bash

# Install dependencies first
if [ ! -d "vendor" ]; then
  echo "Installing Composer dependencies..."
  composer install --no-interaction --optimize-autoloader
  if [ $? -ne 0 ]; then
    echo "Composer install failed!"
    exit 1
  fi
fi

# Wait for database to be ready
echo "Waiting for database connection..."
until php artisan tinker --execute="DB::connection()->getPdo();" 2>/dev/null; do
  echo "Database is unavailable - sleeping"
  sleep 2
done
echo "Database is ready!"

composer dump-autoload

# Start PHP-FPM in foreground
php-fpm -F
