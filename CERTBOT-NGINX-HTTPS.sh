#!/bin/bash 

#usage ./CERTBOT-NGINX-HTTPS example.com www.example.com
#installing certbot and enbale HTTPS with nginx.
sudo add-apt-repository ppa:certbot/certbot

sudo apt-get update

sudo apt-get install python-certbot-nginx

sudo certbot --nginx -d $1 $2
