FROM ubuntu:latest AS base

ENV ACCEPT_EULA=Y
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN apt-get install -y software-properties-common
RUN apt-get update -y

RUN apt-get install -y \
    apt-transport-https \
    cron \
    curl \
    git \
    gnupg2 \
    libpq-dev \
    unzip \
    vim \
    apache2 \
    htop


RUN add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install -y \
    php8.2 \
    php8.2-dev \
    php8.2-cli \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-intl \
    php8.2-ldap \
    php8.2-pgsql \
    php8.2-mysql \
    php8.2-sqlite3 \
    php8.2-mcrypt \
    php8.2-redis \
    php8.2-soap \
    php8.2-curl \
    php-pear \
    php8.2-xml \
    php8.0-xml \
    libapache2-mod-php8.0
 
# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN service apache2 restart

# Install necessary locales
RUN echo "America/Recife" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
RUN echo "pt_BR.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen pt_BR.UTF-8
RUN dpkg-reconfigure --frontend=noninteractive locales
RUN update-locale LANG=pt_BR.UTF-8
ENV LC_ALL=pt_BR.UTF-8
ENV LANG=pt_BR.UTF-8
ENV LANGUAGE=pt_BR.UTF-8

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# XDebug Install
#RUN yes | pecl install xdebug \
#    && echo "zend_extension=$(find /usr/lib/php/ -name xdebug.so)" > /etc/php/8.0/mods-available/xdebug.ini \
#    && echo "xdebug.remote_enable=on" >> /etc/php/8.0/mods-available/xdebug.ini \
#    && echo "xdebug.remote_autostart=off" >> /etc/php/8.0/mods-available/xdebug.ini

# RUN cp /etc/php/8.0/mods-available/xdebug.ini /etc/php/8.0/cli/conf.d/. \
#     && cp /etc/php/8.0/mods-available/xdebug.ini /etc/php/8.0/apache2/conf.d/.

# Habilita modulos
RUN rm -rf /etc/apache2/mods-enabled/ssl.load 
RUN rm -rf /etc/apache2/mods-enabled/ssl.conf 
RUN rm -rf /etc/apache2/mods-enabled/setenvif.load
RUN rm -rf /etc/apache2/mods-enabled/setenvif.conf
RUN rm -rf /etc/apache2/mods-enabled/mime.load
RUN rm -rf /etc/apache2/mods-enabled/mime.conf
RUN a2enmod setenvif
RUN a2enmod mime
RUN a2enmod socache_shmcb
RUN a2enmod ssl

RUN service apache2 restart

COPY entrypoint.sh /
EXPOSE 80 443

ENTRYPOINT ["sh", "/entrypoint.sh"]
