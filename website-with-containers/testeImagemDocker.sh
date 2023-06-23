#!/bin/bash

yum install -y docker
systemctl start docker
systemctl enable docker

# Vamos criar um diretório para trabalho
mkdir /aplicacao
cd /aplicacao

# Criar um diretorio para hospedar os arquivos do site
mkdir aplicacao-web
touch aplicacao-web/index.html