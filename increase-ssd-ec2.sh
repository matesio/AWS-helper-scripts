#!/bin/bash
#first, from ec2 console increase your ebs volume size then execute this to make change affect.
# install "cloud-guest-utils" if it is not installed already
sudo apt install cloud-guest-utils
# resize partition
sudo growpart /dev/xvda 1

sudo resize2fs /dev/xvda1
# Check after resizing ("Avail" now shows 8.7G!-):
sudo df -h
#Filesystem      Size  Used Avail Use% Mounted on

