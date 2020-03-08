#!/bin/bash
set -e

echo '---- install Apache'

#DEBIAN_FRONTEND=noninteractive apt-get -y update
#DEBIAN_FRONTEND=noninteractive apt-get -y install apache2

yum update -y 
yum install nginx -y 
 

cat > /var/www/html/index.html <<HERE
Plain text FTW!
HERE
