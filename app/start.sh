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

# Start PHP-FPM in the background
php-fpm -D

# Wait for database to be ready
echo "Waiting for database connection..."
until php artisan tinker --execute="DB::connection()->getPdo();" 2>/dev/null; do
  echo "Database is unavailable - sleeping"
  sleep 2
done
echo "Database is ready!"

composer dump-autoload

# artisan migrate
# php artisan migrate

# php artisan db:seed

# Start queue worker in the background
# php artisan queue:work --sleep=3 --tries=3 --max-time=3600 &

# Start scheduler in the background
# php artisan schedule:work &

# Wait for all background processes
wait
