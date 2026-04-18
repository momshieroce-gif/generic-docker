FROM php:8.3-fpm-alpine

ARG UID=1000
ARG GID=1000
ARG USER=appuser
ARG GROUP=appgroup
ARG APP_CODE_PATH_CONTAINER=/var/www/html

# Install packages
RUN apk add --no-cache \
    curl \
    zip \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libxml2-dev \
    bash \
    shadow

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip xml bcmath

RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    && docker-php-ext-install gd

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin \
    --filename=composer

# Create group/user
RUN addgroup -g ${GID} ${GROUP} && \
    adduser -D -u ${UID} -G ${GROUP} -s /bin/sh ${USER}

# Directories
RUN mkdir -p /var/log \
    ${APP_CODE_PATH_CONTAINER} && \
    chown -R ${USER}:${GROUP} /var/log ${APP_CODE_PATH_CONTAINER}

WORKDIR ${APP_CODE_PATH_CONTAINER}

COPY ./start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 9000

CMD ["/start.sh"]