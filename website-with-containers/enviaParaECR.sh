#!/bin/bash

# Se necessário, precisará especificar as credencias da função para a instância.
#   aws configure set aws_access_key_id <access_key>
#   aws configure set aws_secret_access_key <secret_key>
#   aws configure set aws_session_token <session_token>

aws ecr get-login-password --region [regiao] | docker login --username AWS --password-stdin [id_conta_aws].dkr.ecr.[regiao].amazonaws.com


docker tag aplicacao-web:versao0.1 [id_conta_aws].dkr.ecr.[regiao].amazonaws.com/repo-aplicacao-web:versao0.1

docker push [id_conta_aws].dkr.ecr.[regiao].amazonaws.com/repo-aplicacao-web:versao0.1