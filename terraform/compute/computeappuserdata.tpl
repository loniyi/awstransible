#!/bin/bash
yum -y update
yum install httpd -y
echo "Welcome to DRAMATAZZ: ${message}" >> /var/www/html/index.html
chown ec2-user /var/www/html
service httpd start
chkconfig httpd on