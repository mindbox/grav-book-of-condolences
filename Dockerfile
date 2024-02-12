# syntax=docker/dockerfile:1-labs
ARG env="prod"

FROM node:18.17.0 as assetbuild

WORKDIR /app

RUN apt-get update && \
    apt-get install git

ADD user/themes/chassis /app/

RUN npm install && \
    npm run cssmin && \
    npm run jsmin && \
    rm -rf node_modules/

FROM php:8.1-apache-bullseye as base

WORKDIR /var/www/html/

RUN a2enmod rewrite

# Install some dependencies
RUN apt-get update && \
    apt-get install -yy \
    unzip \
    git \
    zlib1g \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libicu-dev

# Install the required php plugins
RUN docker-php-ext-configure gd --with-jpeg
RUN docker-php-ext-install \
    gd \
    zip \
    intl

# Install Composer
ADD https://getcomposer.org/installer /tmp/composer-installer
RUN php /tmp/composer-installer --install-dir=/usr/local/bin --filename=composer

# Cleanup apt
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/src/*

# Mark /var/www/html as safe
RUN git config --global --add safe.directory /var/www/html

# Prepare grav
ADD https://getgrav.org/download/core/grav/latest /var/www/html/grav.zip

RUN unzip grav.zip && \
    rm grav.zip && \
    rm -rf grav/user/ && \
    rm -rf grav/.github/ && \
    rm grav/README.md grav/LICENSE.txt grav/CONTRIBUTING.md grav/CODE_OF_CONDUCT.md grav/CHANGELOG.md && \
    mv -n grav/* ./ && \
    mv -n grav/.[!.]* ./ && \
    rm -rf grav/

ADD user/plugins /var/www/html/user/plugins
ADD user/.dependencies /var/www/html/user/.dependencies

RUN ls -la
RUN ./bin/grav install

# Copy built theme
COPY --from=assetbuild /app /var/www/html/user/themes/chassis

ADD .htaccess.dist /var/www/html/.htaccess
ADD user /var/www/html/user

RUN chown www-data:www-data -R .

VOLUME [ "/var/www/html/user/accounts", "/var/www/html/user/pages", "/var/www/html/user/data/flex-objects" ]
