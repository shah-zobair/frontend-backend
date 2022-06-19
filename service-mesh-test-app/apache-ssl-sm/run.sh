#!/bin/bash

cat /tmp/certs/client-key.pem > /tmp/postgresql-user.key
chmod 600 /tmp/postgresql-user.key

cat /tmp/certs/frontend.key > /etc/pki/tls/private/frontend.key
chmod 600 /etc/pki/tls/private/frontend.key

httpd -D FOREGROUND
