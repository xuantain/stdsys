FROM php:7.2-fpm

# Copy composer.lock and composer.json
# COPY ./webroot/composer.lock ./webroot/composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libmcrypt-dev \
    mysql-client \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mysqli mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd

RUN ls /usr/local/etc/php
RUN ls /usr/local/etc/php/conf.d
# Install docker-php-ext
RUN pecl install -f mcrypt
RUN echo extension=/usr/local/lib/php/extensions/no-debug-non-zts-20170718/mcrypt.so > /usr/local/etc/php/php.ini-development
# RUN echo extension=/usr/lib/php/20170718/mcrypt.so > /etc/php/7.2/cli/conf.d/mcrypt.ini

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for laravel application
# RUN groupadd -g 1000 www
# RUN useradd -u 1000 -ms /bin/bash -g www www

# Change current user to www
# USER www
RUN usermod -u 1000 www-data

# Copy existing application directory contents
# COPY ./webroot /var/www/

# Copy existing application directory permissions
# COPY --chown=www:www . /var/www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
