FROM bernhardesperester/docker-apache:latest

# File Author / Maintainer
MAINTAINER Bernhard Esperester <bernhard@esperester.de>

# install wget and curl
RUN apt-get update && apt-get -y install wget curl

# add sources
RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list
RUN echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list

# add key
RUN wget https://www.dotdeb.org/dotdeb.gpg
RUN apt-key add dotdeb.gpg

# install php
RUN apt-get update && apt-get -y install php php-bcmath php-dev php-cli php-fpm php-mysql php-mcrypt php-json php-pear libapache2-mod-php && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

