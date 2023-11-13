# Install composer packages
FROM composer:2 as vendor

WORKDIR /tmp/

COPY composer.json composer.json
COPY composer.lock composer.lock

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist
# Composer build stage end

# Setup app container
FROM php:8.2-fpm-alpine
LABEL org.opencontainers.image.source=https://github.com/markwcodes/personal-website

# Copy project files into web root
COPY . /var/www/html

# Copy composer packages into vendor directory
COPY --from=vendor /tmp/vendor/ /var/www/html/vendor/

# Configure Laravel
WORKDIR /var/www/html/
RUN chmod -R 775 storage
RUN php artisan storage:link

# Setup Node
ENV NODE_VERSION 20
RUN apk add npm

# Build front-end
RUN npm install && npm run build
