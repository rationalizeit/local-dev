#!/usr/bin/env bash

apt update -y
apt-get install openconnect python3-pip -y
apt-get install ubuntu-desktop firefox -y

pip3 install https://github.com/dlenski/vpn-slice/archive/master.zip
