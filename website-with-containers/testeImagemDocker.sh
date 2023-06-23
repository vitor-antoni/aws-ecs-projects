#!/bin/bash

yum install -y docker
systemctl start docker
systemctl enable docker

# Vamos criar um diretório para trabalho
#    mkdir /website-with-containers
#    cd /website-with-containers

# Criar um diretorio para hospedar os arquivos do site
#    mkdir html
#    touch html/index.html

# Cria uma imagem com base no Dockerfile
#   "-t" → para especificar uma tag
docker image build -t aplicacao-web:versao0.1 .
docker image ls

# Rodar o container
#   "-d" → para rodar em background
#   "-p" → para especificar a porta
docker container run -d -p 80:80 aplicacao-web:versao0.1

# Testar o container
curl localhost:80

# Para para o container
docker container ls
docker container stop [container_id]
docker container rm [container_id]
