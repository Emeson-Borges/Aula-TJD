// Variáveis do jogador
float playerX, playerY; // Posições X e Y do jogador
float playerSize = 40; // Tamanho do jogador (diâmetro do círculo)
float playerSpeed = 5; // Velocidade de movimento do jogador

// Quantidade de obstáculos
int numObstacles = 5; // Número de obstáculos

// Arrays para armazenar a posição e tamanho dos obstáculos
float[] obstacleX = new float[numObstacles]; // Posição X de cada obstáculo
float[] obstacleY = new float[numObstacles]; // Posição Y de cada obstáculo
float[] obstacleWidth = new float[numObstacles]; // Largura de cada obstáculo
float[] obstacleHeight = new float[numObstacles]; // Altura de cada obstáculo
float obstacleSpeed = 6; // Velocidade dos obstáculos

// Variável para controlar o estado do jogo
boolean gameOver = false; // Controla se o jogo está em estado de "Game Over"

// Função de configuração inicial do Processing
void setup() {
  size(800, 600); // Define o tamanho da tela (largura 800, altura 600)
  
  // Posição inicial do jogador (definido em 1/4 da largura e no meio da tela)
  playerX = width / 4; // Posição X inicial do jogador
  playerY = height / 2; // Posição Y inicial do jogador
  
  // Inicializar a posição e tamanho dos obstáculos
  for (int i = 0; i < numObstacles; i++) {
    obstacleX[i] = random(width, width * 2); // Posição X aleatória fora da tela (à direita)
    obstacleY[i] = random(height - 40); // Posição Y aleatória dentro da tela, considerando altura
    obstacleWidth[i] = random(40, 80); // Largura aleatória do obstáculo entre 40 e 80 pixels
    obstacleHeight[i] = random(20, 60); // Altura aleatória do obstáculo entre 20 e 60 pixels
  }
}

// Função de repetição do Processing (roda continuamente)
void draw() {
  if (!gameOver) { // Se o jogo não estiver em "Game Over"
    background(255); // Preenche o fundo da tela com a cor branca (255)

    // Desenhar o jogador (um círculo azul)
    fill(0, 150, 255); // Define a cor azul para o jogador
    ellipse(playerX, playerY, playerSize, playerSize); // Desenha o jogador como um círculo nas posições X e Y
    
    // Movimento do jogador baseado nas teclas pressionadas
    if (keyPressed) { // Verifica se alguma tecla está sendo pressionada
      if (key == 'w' || key == 'W') playerY -= playerSpeed; // Move o jogador para cima ao pressionar 'W'
      if (key == 's' || key == 'S') playerY += playerSpeed; // Move o jogador para baixo ao pressionar 'S'
      if (key == 'a' || key == 'A') playerX -= playerSpeed; // Move o jogador para a esquerda ao pressionar 'A'
      if (key == 'd' || key == 'D') playerX += playerSpeed; // Move o jogador para a direita ao pressionar 'D'
    }
    
    // Impedir que o jogador saia da tela (limita as bordas)
    playerX = constrain(playerX, playerSize / 2, width - playerSize / 2); // Limita a posição X
    playerY = constrain(playerY, playerSize / 2, height - playerSize / 2); // Limita a posição Y
    
    // Atualizar e desenhar cada obstáculo
    for (int i = 0; i < numObstacles; i++) { // Loop para cada obstáculo
      fill(255, 100, 0); // Define a cor laranja para os obstáculos
      rect(obstacleX[i], obstacleY[i], obstacleWidth[i], obstacleHeight[i]); // Desenha o obstáculo como um retângulo
      
      // Movimento dos obstáculos (da direita para a esquerda)
      obstacleX[i] -= obstacleSpeed; // Reduz a posição X, movendo o obstáculo para a esquerda
      
      // Reposicionar o obstáculo quando ele sair da tela (volta para a direita)
      if (obstacleX[i] + obstacleWidth[i] < 0) { // Se o obstáculo passar completamente pela esquerda
        obstacleX[i] = width; // Reposiciona o obstáculo para a borda direita da tela
        obstacleY[i] = random(height - obstacleHeight[i]); // Escolhe uma nova posição Y aleatória
      }
      
      // Checar colisão entre o jogador e cada obstáculo
      if (dist(playerX, playerY, obstacleX[i] + obstacleWidth[i]/2, obstacleY[i] + obstacleHeight[i]/2) < (playerSize/2 + obstacleWidth[i]/2)) {
        // Se a distância entre o jogador e o obstáculo for menor que a soma dos seus raios, ocorre colisão
        gameOver = true; // Define o estado de "Game Over"
      }
    }
    
  } else { // Se o estado do jogo for "Game Over"
    // Tela de fim de jogo
    background(255, 0, 0); // Preenche o fundo com a cor vermelha
    textAlign(CENTER, CENTER); // Alinha o texto no centro
    fill(255); // Define a cor branca para o texto
    textSize(50); // Define o tamanho da fonte
    text("Game Over!", width / 2, height / 2); // Exibe a mensagem "Game Over!" no centro da tela
    textSize(25); // Define o tamanho da fonte menor
    text("Pressione 'R' para reiniciar", width / 2, height / 2 + 50); // Exibe a instrução para reiniciar o jogo
    
    // Reiniciar o jogo se a tecla 'R' for pressionada
    if (keyPressed && (key == 'r' || key == 'R')) { // Se a tecla 'R' for pressionada
      gameOver = false; // Reseta o estado de "Game Over"
      playerX = width / 4; // Reinicia a posição X do jogador
      playerY = height / 2; // Reinicia a posição Y do jogador
      
      // Reiniciar a posição dos obstáculos
      for (int i = 0; i < numObstacles; i++) { // Para cada obstáculo
        obstacleX[i] = random(width, width * 2); // Reposiciona os obstáculos fora da tela, à direita
        obstacleY[i] = random(height - 40); // Define uma nova posição Y aleatória para cada obstáculo
      }
    }
  }
}
