FROM etna/drone-debian

RUN echo 'deb http://packages.dotdeb.org jessie all'     >> /etc/apt/sources.list
RUN echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
RUN wget http://www.dotdeb.org/dotdeb.gpg
RUN apt-key add dotdeb.gpg

RUN echo "deb http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list

RUN apt-get -o Acquire::Check-Valid-Until=false update
RUN apt-get install -y unzip pdftk
RUN apt-get install -y php7.0-cli \
                       php7.0-dev \
                       php7.0-mysql \
                       php7.0-curl \
                       php7.0-xdebug \
                       php7.0-gd \
                       php7.0-bcmath \
                       php7.0-mbstring \
                       php7.0-xml \
                       php7.0-zip \
                       php7.0-apcu \
                       php7.0-memcached

RUN echo 'date.timezone = "Europe/Paris"' >> /etc/php/7.0/cli/php.ini

RUN mkdir /tmp/uopz && wget http://pecl.php.net/get/uopz/5.0.2 -O - | tar -xz -C /tmp/uopz && cd /tmp/uopz/uopz* && phpize && ./configure && make && make install
RUN echo '[uopz]'                                         >> /etc/php/7.0/cli/php.ini
RUN echo 'extension=/tmp/uopz/uopz-5.0.2/modules/uopz.so' >> /etc/php/7.0/cli/php.ini

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN php -i
