FROM registry.access.redhat.com/ubi8/ubi:latest

EXPOSE 8080

ENV MSG="Containerfile"

RUN yum install -y httpd php-fpm; \
    yum clean all; \
    sed -i 's/^Listen 80 *$/Listen 8080/' /etc/httpd/conf/httpd.conf; \
    sed -i 's/^;clear_env/clear_env/' /etc/php-fpm.d/www.conf; \
    mkdir /run/php-fpm
#    echo -e "#!/bin/bash\nphp-fpm\nhttpd -DFOREGROUND" > /usr/local/bin/startup; \
#    chmod 755 /usr/local/bin/startup

ADD src/* /var/www/html/

USER 1008

CMD php-fpm & httpd -DFOREGROUND
