#!/bin/bash

# aws configure set aws_access_key_id <access_key>
# aws configure set aws_secret_access_key <secret_key>
# aws configure set aws_session_token <session_token>

aws ecr get-login-password --region <regiao> | docker login --username AWS --password-stdin <id_conta_aws>.dkr.ecr.<regiao>.amazonaws.com

docker build -t app-image .
docker tag app-image:latest <id_conta_aws>.dkr.ecr.<regiao>.amazonaws.com/app-image:latest

docker push <id_conta_aws>.dkr.ecr.<regiao>.amazonaws.com/app-image:latest