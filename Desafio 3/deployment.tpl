#!/bin/bash

sudo apt update

cd /home/ubuntu/
if [ -d "apis/clientes" ]; then
  cd apis/clientes
fi
if [ -d "apis/catalogo" ]; then
  cd apis/catalogo
fi
if [ -d "apis/inventario" ]; then
  cd apis/inventario
fi

sudo echo ${db_endpoint} >> config.txt
sudo echo ${db_port} >> config.txt
sudo echo ${lb_dns_address} >> config.txt
sudo echo ${username} >> config.txt
sudo echo ${password} >> config.txt

if [ -d "apis/clientes" ]; then
  sudo python3 Execute.py Execute
  sudo python3 Execute.py runserver 0.0.0.0:5000
fi

if [ -d "apis/catalogo" ]; then
  sudo python3 Execute.py Execute
  sudo python3 Execute.py runserver 0.0.0.0:5001
fi

if [ -d "apis/inventario" ]; then
  sudo python3 Execute.py Execute
  sudo python3 Execute.py runserver 0.0.0.0:5002
fi




