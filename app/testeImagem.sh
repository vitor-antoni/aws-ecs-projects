#!/bin/bash

yum install -y docker
systemctl start docker
systemctl enable docker


# Para testar se a imagem está funcionando,
# vamos buildar esta imagem e levantar um container
# a partir dela.
docker image build . -t app-image
docker container run -d -p 80:80 app-image

curl  localhost:80