FROM php:7.4

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN apt-get -y update \
    && apt-get install -y \
        git \
        libfreetype6-dev \
        libicu-dev \
        libjpeg-dev \
        libpng-dev \
        libwebp-dev \
        libxml2-dev \
        libxslt1-dev \
        libzip-dev \
        zip \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j$(nproc) \
        bcmath \
        calendar \
        exif \
        intl \
        opcache \
        mysqli \
        pdo_mysql \
        soap \
        xmlrpc \
        xsl \
        zip

RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) gd

WORKDIR /var/www/html
