FROM php:5.6
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

COPY --from=composer:1 /usr/bin/composer /usr/bin/composer

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
        xmlrpc \
        xsl \
        zip

RUN docker-php-ext-configure gd --with-freetype-dir --with-jpeg-dir --with-webp-dir \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install -j$(nproc) ldap

WORKDIR /var/www/html
