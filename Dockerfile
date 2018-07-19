FROM etna/drone-debian

RUN apt-get install -y apt-transport-https lsb-release ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
RUN apt-get update

RUN apt-get update
RUN apt-get install -y php7.1-cli \
                       php7.1-dev \
                       php7.1-mysql \
                       php7.1-curl \
                       php7.1-xdebug \
                       phpunit \
                       php7.1-gd \
                       php7.1-bcmath \
                       php7.1-mbstring \
                       php7.1-xml \
                       php7.1-zip

RUN echo 'date.timezone = "Europe/Paris"' >> /etc/php/7.1/cli/php.ini

RUN mkdir /tmp/uopz && wget http://pecl.php.net/get/uopz/5.0.2 -O - | tar -xz -C /tmp/uopz && cd /tmp/uopz/uopz* && phpize && ./configure && make && make install
RUN echo '[uopz]'                                         >> /etc/php/7.1/cli/php.ini
RUN echo 'extension=/tmp/uopz/uopz-5.0.2/modules/uopz.so' >> /etc/php/7.1/cli/php.ini

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN php -i
