FROM php:8.1

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN apt-get -y update \
    && apt-get install -y \
        git \
        libfreetype6-dev \
        libicu-dev \
        libjpeg-dev \
        libldap2-dev \
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
        xsl \
        zip

RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install -j$(nproc) ldap

WORKDIR /var/www/html
