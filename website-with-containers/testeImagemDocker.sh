#!/bin/bash

yum install -y docker
systemctl start docker
systemctl enable docker

# Vamos criar um diretório para trabalho
mkdir /aplicacao
cd /aplicacao