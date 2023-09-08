<?php
  if (isset($_SERVER['ECS_CONTAINER_METADATA_URI_V4'])) {
    // Obtenha o endpoint de metadados da tarefa
    $metadata_endpoint = $_SERVER['ECS_CONTAINER_METADATA_URI_V4'];
    // Faça uma solicitação HTTP GET para o endpoint de metadados da tarefa
    $metadata_json = file_get_contents($metadata_endpoint);
    // Analise a resposta JSON
    $metadata = json_decode($metadata_json, true);
    // Obtenha o ID e o IP do container a partir dos metadados
    $container_id = $metadata['DockerId'];
    $container_ip = $metadata['Networks'][0]['IPv4Addresses'][0];
    // Define a mensagem a ser exibida no footer
    $footer_msg = "Fargate Mode";
    } else {
    // Use gethostname () e $_SERVER[SERVER_ADDR] como fallback
    $container_id = gethostname ();
    $container_ip = $_SERVER['SERVER_ADDR'];
    // Define a mensagem a ser exibida no footer
    $footer_msg = "Instance Mode";
  }
?>
<!DOCTYPE html>
<html>
  <head>
    <title>Container - Apache + PHP</title>
    <style>
      @import url('https://fonts.googleapis.com/css?family-Roboto|Lato');
      body {
        background-image: url('img/bg.jpg');
        background-size: cover;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
      }
      .container {
        text-align: center;
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        transition: transform 0.3s;
        transform: scale(1);
      }
      .container:hover {
        transform: scale(1.2);
      }
      h2 {
        color: #333333;
        font-family: 'Roboto', sans-serif;
      }
      p {
        color: #333333;
        font-family: 'Lato', sans-serif;
      }
      img {
        margin-bottom: 20px;
      }
      .container-info {
        display: flex;
        justify-content: space-between;
        width: 80%;
        margin: 0 auto;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <img src="/img/logo.png"><hr>
      <div class="container-info">
        <div>
          <h2>Container ID: </h2>
          <?php echo $container_id; ?>
        </div>
        <div>
          <h2>Container IP:</h2>
          <?php echo $container_ip; ?>
        </div>
      </div>
      <br><hr>

      <p><?php echo $footer_msg; ?></p>
    </div>
  </body>
</html>