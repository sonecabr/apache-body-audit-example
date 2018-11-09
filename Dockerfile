FROM ubuntu:trusty
MAINTAINER Andre Rocha <devel.andrerocha@gmail.com>

# Install base packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        curl \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql \
        php5-mcrypt \
        php5-gd \
        php5-curl \
        php-pear \
        php-apc && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN /usr/sbin/php5enmod mcrypt
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install libapache2-modsecurity && \
    a2enmod dump_io  

ENV ALLOW_OVERRIDE **False**

# Add image configuration and scripts
ADD docker-entrypoint.sh /usr/bin/docker-entrypoint
ADD apache2.conf /etc/apache2/apache2.conf
RUN chmod 755 /usr/bin/docker-entrypoint 

# Configure /app folder with sample app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
#ADD sample/ /app

EXPOSE 80
WORKDIR /app
ENTRYPOINT ["/usr/bin/docker-entrypoint"]

