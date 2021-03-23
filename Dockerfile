FROM php:7.4

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN apt-get -y update && \
    apt-get install -y \
        zip \
        libzip-dev \
        libpng-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        git \
        libicu-dev && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure \
        zip && \
    docker-php-ext-install -j$(nproc) \
        pdo \
        pdo_mysql \
        mysqli \
        bcmath \
        zip

RUN docker-php-ext-configure intl  && \
    docker-php-ext-install -j$(nproc) intl

RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd
