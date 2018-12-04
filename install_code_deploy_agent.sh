#!/bin/bash

# To deploy applications throgh codedeploy we need to have code deploy agent installed on that EC2 instancs.
# I am assuming, us-east-1 N. Virginia region.

wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install

sudo apt-get install ruby

chmod +x ./install

sudo ./install auto

sudo mv /etc/init.d/codedeploy-agent.service /lib/systemd/system/

sudo systemctl daemon-reload
# need to enable autostart at boot time, as there can be many reasons to reboot the instance.
sudo systemctl enable codedeploy-agent.service
# starting service for the first time.
sudo systemctl start codedeploy-agent.service
