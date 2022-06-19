#FROM registry.access.redhat.com/rhel7
FROM registry.access.redhat.com/ubi8/php-74
#FROM openshift/rhel7


#RUN yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms update -y && \
#    yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms install -y httpd mod_rewrite php php-bcmath php-cli php-common php-devel php-mysql php-odbc php-pdo  php-pspell php-pgsql php-ldap php-mbstring php-gd mod_ssl php-pear gnupg libgpg-error gpgme gpgme-devel php-devel gcc && yum clean all
    #yum --disablerepo='*' --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-extras-rpms --enablerepo=rhel-7-server-optional-rpms install -y httpd mod_rewrite php php-bcmath php-cli php-common php-devel php-mysql php-odbc php-pdo  php-pspell php-pgsql php-ldap php-mbstring php-gd mod_ssl php-pear gnupg libgpg-error gpgme gpgme-devel php-devel gcc && yum clean all
USER 0
RUN yum install -y httpd php wget iproute iputils net-tools curl php php-bcmath php-cli php-common php-devel php-odbc php-pdo php-pgsql php-ldap php-mbstring php-gd mod_ssl php-pear && yum clean all

#RUN pear config-set http_proxy http://css:Secret%40Kpr0d13@proxy.example.com:8080 && \
    #pear config-set https_proxy http://css:Secret%40Kpr0d13@proxy.example.com:8080 && \
#    pear clear-cache && \
#    pear update-channels && \
#    pear upgrade && \
#    pecl install gnupg && \
#    echo "extension=gnupg.so" >> /etc/php.ini
    
#RUN usermod apache -u 1001 \
# && groupmod apache -g 1001 \
RUN chown -R apache:apache /var/log/httpd \
 && chown -R apache:apache /etc/httpd \
 && chown -R apache:apache /var/www/html \
 && chmod -R 777 /var/run/httpd \
 && chmod -R 777 /var/log/httpd \
 && chmod -R 777 /etc/httpd \
 && chmod -R 777 /etc/pki

 RUN sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf \
 && sed -i 's/Listen 443/Listen 8443/g' /etc/httpd/conf.d/ssl.conf \
 && sed -i 's/VirtualHost _default_:443/VirtualHost _default_:8443/g' /etc/httpd/conf.d/ssl.conf \
 && sed -i 's/SSLCertificateFile \/etc\/pki\/tls\/certs\/localhost.crt/SSLCertificateFile \/certs\/tls.crt/g' /etc/httpd/conf.d/ssl.conf \
 && sed -i 's/SSLCertificateKeyFile \/etc\/pki\/tls\/private\/localhost.key/SSLCertificateKeyFile \/certs\/tls.key/g' /etc/httpd/conf.d/ssl.conf
# && sed -i 's/SSLCertificateFile \/etc\/pki\/tls\/certs\/localhost.crt/SSLCertificateFile \/etc\/pki\/tls\/certs\/frontend.cert/g' /etc/httpd/conf.d/ssl.conf \
# && sed -i 's/SSLCertificateKeyFile \/etc\/pki\/tls\/private\/localhost.key/SSLCertificateKeyFile \/etc\/pki\/tls\/private\/frontend.key/g' /etc/httpd/conf.d/ssl.conf

RUN ln -sf /dev/stdout /etc/httpd/logs/access_log \
 && ln -sf /dev/stderr /etc/httpd/logs/error_log

ADD run.sh /tmp/run.sh
RUN chmod 777 /tmp/run.sh

USER 1001

EXPOSE 8080 8443

COPY index.html /var/www/html/
#COPY db-ssl.php /var/www/html/
COPY db.php /var/www/html/
COPY CERT /tmp/CERT

CMD ["/tmp/run.sh"]
