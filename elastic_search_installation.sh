#!/bin/bash
sudo apt update -y
sudo apt install openjdk-8-jdk -y
sudo apt install apt-transport-https -y

####Installing Elasticsearch####
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.4.3-amd64.deb
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.4.3-amd64.deb.sha512
shasum -a 512 -c elasticsearch-8.4.3-amd64.deb.sha512
sudo dpkg -i elasticsearch-8.4.3-amd64.deb

##Initial Service Restart##
sudo systemctl daemon-reload
sudo systemctl enable --now elasticsearch.service
sudo systemctl start elasticsearch.service

##Superuser password reset##
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password --batch -u  elastic  > /tmp/elastic.txt
