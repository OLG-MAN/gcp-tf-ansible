#!/bin/bash

# Pre-installing environment
sudo su<< HERE
apt update
apt install python-minimal python-simplejson -y
# apt install apache2 -y
# a2enmod cgid
# chomod 755 /usr/lib/cgi-bin/web.py
# service apache2 restart
HERE