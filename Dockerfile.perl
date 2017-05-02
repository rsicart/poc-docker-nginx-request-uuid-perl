FROM debian:jessie

ENV NGINX_VERSION 1.6.2-5+deb8u4

RUN mkdir -p /var/log/nginx/perl.example.com

RUN apt-get update && apt-get install -y \
    vim \
    less

RUN apt-get update && apt-get install -y \
    openssl \
    ssl-cert \
    libossp-uuid-perl \
    nginx-extras=${NGINX_VERSION}

COPY log_formats.conf /etc/nginx/include/log_formats.conf
COPY perl.example.com.conf /etc/nginx/sites-enabled/perl.example.conf

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/perl.example.com/access.log
RUN ln -sf /dev/stderr /var/log/nginx/perl.example.com/error.log

VOLUME ["/etc/nginx"]

EXPOSE 8080 8443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
