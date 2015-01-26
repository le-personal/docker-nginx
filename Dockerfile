FROM ubuntu:14.04

MAINTAINER Luis Elizondo "lelizondo@gmail.com"
ENV DEBIAN_FRONTEND noninteractive

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Update system
RUN apt-get update && apt-get dist-upgrade -y

# Prevent restarts when installing
RUN echo '#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d && chmod +x /usr/sbin/policy-rc.d

# Basic packages
RUN apt-get -y install nginx git curl supervisor

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Prepare directory
RUN mkdir /var/www
RUN usermod -u 1000 www-data
RUN usermod -a -G users www-data
RUN chown -R www-data:www-data /var/www

EXPOSE 80
WORKDIR /var/www
VOLUME ["/var/www/sites/default/files"]
CMD ["/usr/bin/supervisord", "-n"]

RUN mkdir -p /var/cache/nginx/microcache

### Add configuration files
# Supervisor
ADD ./config/supervisor/supervisord-nginx.conf /etc/supervisor/conf.d/supervisord-nginx.conf

# Nginx
ADD ./config/nginx/map_block_http_methods.conf /etc/nginx/map_block_http_methods.conf
ADD ./config/nginx/mime.types /etc/nginx/mime.types
ADD ./config/nginx/blacklist.conf /etc/nginx/blacklist.conf
ADD ./config/nginx/nginx.conf /etc/nginx/nginx.conf
ADD ./config/nginx/default /etc/nginx/sites-enabled/default