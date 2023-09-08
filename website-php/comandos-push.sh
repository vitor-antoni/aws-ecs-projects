#!/bin/bash

aws ecr create-repository --repository-name aplicacao-php

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin {accountID}.dkr.ecr.{region}.amazonaws.com

docker build -t aplicacao-php .

docker tag aplicacao-php:latest {accountID}.dkr.ecr.{region}.amazonaws.com/aplicacao-php:latest
docker push {accountID}.dkr.ecr.{region}.amazonaws.com/aplicacao-php:latest
