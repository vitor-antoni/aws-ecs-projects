# Website With Containers
### Apresentação
Neste projeto, usei um pouco de Shell Scripting (para automatizar algumas tarefas e comandos) e um arquivo Dockerfile para criar uma imagem personalizada a partir da imagem do NGNIX. Você pode encontrar, também, um passo a passo para "levantar" seu website usando containers com o serviço ECS.

## ❗ Explicação
Antes de começarmos o passo a passo, vamos começar explicando a existência de arquivo dentro deste diretório: <br>
→ *[Dockerfile](Dockerfile)* : Este é o arquivo responsável por personalizar o pacote *NGINX* e referenciar o arquivo HTML existente dentro do diretório `html/` presente neste projeto.

→ *[testeImagemDocker.sh](testeImagemDocker.sh)* : Aqui, podemos executar este script para instalar o *Docker*, montar a imagem e rodar um container.

→ *[enviaParaECR.sh](enviaParaECR.sh)* : Após o teste de imagem ser bem sucedido, este script deverá ser executado para encaminhar a imagem personalizada próprio para o Elastic Container Registry (ECR).

→ *[html/](html/)* : Diretório que possuí o index.html (Sua página WEB).

## 🔧 Passo a passo
> Atente-se, neste projeto foi utilizado o sistema operacional Amazon Linux 2, a partir de uma EC2. Portanto, os comandos se assemelham ao Linux Red Hat. Caso for utilizar Ubuntu, por exemplo, será preciso alterar alguns comandos dentro dos arquivos de Shell Scripting.

> Atente-se também a executar os scripts usando o usuário **root**.

1. Realize o download deste repositório ou copie o código que está dentro de cada arquivo para sua máquina local.
2. Edite os arquivos: `html/index.html`, `enviaParaECR.sh` e `testeImagemDocker.sh`.
3. Execute o arquivo `testeImagemDocker.sh`, aguarde a instalação do *Docker* e, logo, será retornado ao terminal, o conteúdo do site através do comando `curl localhost:80` se houver sucesso na execução do scripting e na configuração do `Docker`.

Vamos prontos para partir para próxima etapa! ✅
4. Nesta estapa, precisamos criar um repositório privado utilizando o Elastic Container Registry (ECR). Para isto, vamos logar ao Console da AWS e navegar até a aba deste serviço...
