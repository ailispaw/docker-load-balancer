#!/bin/bash

sed -i "s/HOST_ID/$HOSTNAME/" /var/www/html/index.html

/opt/bin/caddy
