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
> Requisitos para este projeto: VPC; Security Groups; Instancia EC2 em execução com acesso WEB e SSH permitido; Target Group e Load Balancer permitindo e redirecionando a porta HTTP(80).

> Atente-se: neste projeto foi utilizado o sistema operacional Amazon Linux 2, a partir de uma EC2. Portanto, os comandos se assemelham ao Linux Red Hat. Caso for utilizar Ubuntu, por exemplo, será preciso alterar alguns comandos dentro dos arquivos de Shell Scripting.

> Atente-se: não altere o nome do diretório `html/`, tão quanto o arquivo `html/index.html`.

> Atente-se: executar os scripts usando o usuário **root**.

1. Realize o download deste repositório ou copie o código que está dentro de cada arquivo para sua máquina local.
2. Edite os arquivos: `html/index.html`, `enviaParaECR.sh` e `testeImagemDocker.sh`.
3. Execute o arquivo `testeImagemDocker.sh`, aguarde a instalação do *Docker* e, logo, será retornado ao terminal, o conteúdo do site através do comando `curl localhost:80` se houver sucesso na execução do scripting e na configuração do `Docker`.

✅ Primeira etapa concluída. Vamos para a próxima!

4. Nesta etapa, precisamos criar um repositório privado utilizando o Elastic Container Registry (ECR). Para isto, vamos realizar o login ao Console da AWS e navegar até a aba deste serviço.
5. **Criação de repositório privado**: apenas especifique o nome do repositório. Você pode ativar a opção "Imutabilidade de etiquetas" caso quiser evitar que imagens de containers com mesma tag sejam substituídas. Neste projeto, vamos manter esta opção **desativada**, pois estamos utilizando a tag "latest", logo, sempre que for realizado um *push*/update de uma nova imagem, irá substituir a imagem já existente no ECR.
6. Para realizar o *push* da imagem para o ECR, você deverá executar o arquivo `enviaParaECR.sh`.

✅ Segunda tapa concluída. Vamos para a próxima!

7. Precisamos, agora, criar um **cluster de *containers*** usando o **AWS ECS**: Especificaremos o nome do cluster, a VPC e a sub-nets desejadas. Recomendo a seleção de, **no mínimo**, **duas sub-nets privadas** para podermos garantir uma **alta disponibilidade** de nossa aplicação.
8. Vamos criar uma ***Taks Definition*** (Definição de Tarefa) especificando a tarefa que gostaríamos que o container realize. Neste caso, vamos selecionar a URI da imagem que realizamos o upload para o ECR.
9. Voltando a aba de Clusters, entraremos na configuração do cluster criado no passo anterior e **¹ criaremos** um ***serviço***(Para uma aplicação WEB, usar o *serviço* é mais adequado que uma *tarefa*). **² Selecione** a Taks Definition/Definição de tarefa, criada anteriormente, e sua versão mais recente. **³ Especifique** o nome para o serviço. **⁴ Especifique**, no mínimo, 2 no campo "tarefas desejadas", mas esta especificação pode variar dependendo do tamanho e workload da sua aplicação. **⁵ Selecione** as sub-nets privadas de sua VPC. **⁶ Habilite** a escalabilidade automática, especifique 2 para o mínimo de tarefas desejadas e 4 para o máximo. **⁷ Ainda** sobre escalabilidade, selecione a métrica de *ECSServiceAverageCPUUtilization* e utilize os valores padrões de "Valor de Destino": 70, "Aumentar a escala...": 300 e "Reduzir a escala...": 300.
10. Especificaremos o Load Balancer que está em execução na sua conta (caso não houver um ELB em execução, crie um Load Balancer e um Target Group com a porta HTTP → 80).

✅ Terceira etapa concluída. Vamos realizar o teste!

11. Procure, na aba superior, pelo serviço *EC2* e navegue até Load Balancer. 
12. Copie o URL do ELB e cole em seu navegador. É esperado que seja apresentado o site sem erros. 
13. Caso apresentar erro de *5xx*, está relacionado a erros de servidor, confira novamente o passo a passo.

✅ Passo a passo finalizado. Aprendemos a tornar um website disponível através do AWS ECS.
