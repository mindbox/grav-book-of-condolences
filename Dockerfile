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

ENV LANGUAGE=de

WORKDIR /var/www/html/

RUN <<-EOT
    a2enmod rewrite
    apt-get update
    apt-get install -yy \
        unzip \
        git \
        zlib1g \
        libzip-dev \
        libpng-dev \
        libjpeg-dev \
        libicu-dev
    docker-php-ext-configure gd --with-jpeg
    docker-php-ext-install \
    gd \
    zip \
    intl
EOT

# Install Composer
ADD https://getcomposer.org/installer /tmp/composer-installer
RUN <<-EOT
    php /tmp/composer-installer --install-dir=/usr/local/bin --filename=composer
    apt-get clean
    rm -rf /var/lib/apt/lists/* /usr/src/*
    git config --global --add safe.directory /var/www/html
EOT

# Prepare grav
ADD https://getgrav.org/download/core/grav/latest /var/www/html/grav.zip

RUN <<-EOT
    unzip grav.zip
    rm grav.zip
    rm -rf grav/user/
    rm -rf grav/.github/
    rm grav/README.md grav/LICENSE.txt grav/CONTRIBUTING.md grav/CODE_OF_CONDUCT.md grav/CHANGELOG.md
    mv -n grav/* ./
    mv -n grav/.[!.]* ./
    rm -rf grav/
EOT

ADD user/plugins /var/www/html/user/plugins
ADD user/.dependencies /var/www/html/user/.dependencies

RUN <<-EOT 
    ./bin/grav install
    sed -i "s/'de'/'${LANGUAGE}'/" user/config/{system,site}.yaml
EOT

# Copy built theme
COPY --from=assetbuild /app /var/www/html/user/themes/chassis

ADD .htaccess.dist /var/www/html/.htaccess
ADD user /var/www/html/user

RUN chown www-data:www-data -R .

VOLUME [ "/var/www/html/user/accounts", "/var/www/html/user/pages", "/var/www/html/user/data/flex-objects" ]
