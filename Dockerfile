FROM php:8.1-fpm

# Create Magento user and directories
RUN useradd magento_user --create-home --user-group --groups www-data \
    && mkdir -p /var/www/magento-user \
    && chown -R magento_user:www-data /var/www/magento-user

# Install necessary packages and PHP extensions
RUN apt-get update && apt-get install -y \
    bzip2 cron fontconfig g++ libmcrypt-dev libfreetype6-dev \
    libicu-dev libjpeg62-turbo-dev libpng-dev libxml2-dev libxslt1-dev \
    default-mysql-client vim zlib1g-dev git libcurl4-openssl-dev curl \
    sudo gpg libonig-dev zip libzip-dev libmagickwand-dev libmagickcore-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure zip \
    && docker-php-ext-install -j$(nproc) gd iconv intl mbstring opcache mysqli \
       pdo_mysql soap xsl xml zip bcmath sockets curl \
    && pecl install xdebug-3.1.6 redis imagick \
    && docker-php-ext-enable xdebug redis imagick \
    && rm -rf /var/lib/apt/lists/*

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Configure PHP-FPM to use magento_user
RUN sed -i 's/user = www-data/user = magento_user/g' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's/group = www-data/group = magento_user/g' /usr/local/etc/php-fpm.d/www.conf

# Set permissions and working directory
RUN chown -R magento_user:www-data /var/www/magento-user \
    && chmod -R 755 /var/www/magento-user

USER magento_user
WORKDIR /var/www/magento-user

EXPOSE 9000
