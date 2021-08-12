#!/bin/bash
set -e
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/home/ubuntu/terraform.log 2>&1
apt update -y
apt install python3 python3-dev python3-pip -y
mkdir /opt/jupyter
pip3 install --upgrade pip
adduser --disabled-password --shell /bin/false --gecos "User" jupyter
chown jupyter:jupyter /opt/jupyter
su jupyter
cd /opt/jupyter
python3 -m venv venv
source venv/bin/activate
pip3 install jupyter
ufw allow 8080
#not safe
jupyter notebook  --ip 0.0.0.0 --port 8080 --no-browser --NotebookApp.password='admingogo' --NotebookApp.token='oke' &
