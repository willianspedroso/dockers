FROM ubuntu:20.04

# Evita perguntas interativas durante a instalação
ENV DEBIAN_FRONTEND=noninteractive
ENV ACCEPT_EULA=Y

# Atualiza e instala dependências básicas de sistema e repositório
RUN apt-get update && apt-get install -y \
    locales \
    software-properties-common \
    ca-certificates \
    curl \
    gnupg2 \
    && locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8

# Adiciona o PPA e instala o PHP 5.6 em um único bloco para garantir o update
RUN add-apt-repository ppa:ondrej/php -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    php5.6 \
    php5.6-dev \
    php5.6-cli \
    php5.6-gd \
    php5.6-mbstring \
    php5.6-intl \
    php5.6-ldap \
    php5.6-pgsql \
    php5.6-mysql \
    php5.6-mcrypt \
    php5.6-redis \
    php5.6-soap \
    php5.6-curl \
    php-pear \
    php5.6-xml \
    libapache2-mod-php5.6 \
    apache2 \
    git \
    unzip \
    vim \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
 
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

#RUN cp /etc/php/8.0/mods-available/xdebug.ini /etc/php/8.0/cli/conf.d/. \
#    && cp /etc/php/8.0/mods-available/xdebug.ini /etc/php/8.0/apache2/conf.d/.

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
