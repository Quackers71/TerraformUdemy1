#!/bin/bash
sudo yum update -y
sudo yum install nginx -y
sudo service nginx start
sudo chkconfig nginx on