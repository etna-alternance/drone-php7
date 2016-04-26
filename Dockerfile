FROM etna/drone-debian

RUN echo 'deb http://packages.dotdeb.org jessie all'           >> /etc/apt/sources.list
RUN echo 'deb-src http://packages.dotdeb.org jessie all'       >> /etc/apt/sources.list
RUN wget http://www.dotdeb.org/dotdeb.gpg
RUN apt-key add dotdeb.gpg

RUN apt-get update
RUN apt-get install -y php7.0-cli php7.0-dev php7.0-mysql php7.0-curl php7.0-xdebug phpunit php7.0-gd

RUN echo 'date.timezone = "Europe/Paris"' >> /etc/php5/cli/php.ini

RUN mkdir /tmp/uopz && wget http://pecl.php.net/get/uopz -O - | tar -xz -C /tmp/uopz && cd /tmp/uopz/uopz* && phpize && ./configure && make && make install
RUN echo '[uopz]'                      >> /etc/php5/cli/php.ini
RUN echo 'extension=/tmp/uopz/uopz.so' >> /etc/php5/cli/php.ini

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
