#!/bin/bash
set -e
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/home/ubuntu/terraform.log 2>&1
cdir = $pwd
sudo apt-get update
sudo apt-get install git
sudo apt-get install python3-setuptools python3-dev build-essential
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
cd ${cdir}/training-data-analyst/courses/developingapps/python/devenv/
sudo python3 server.py
