/////////////////////////////////
//Ethan Zohar                  //
//April 25                     //
//Pong                         //
/////////////////////////////////

boolean [] button = new boolean [256];
boolean gameStart = false;
boolean pause = false;
boolean cheat = false;
boolean toggle = false;
boolean soundToggle = false;

float leftY = 225;
float rightY = 225;
float rectDragLeft;
float rectDragRight;
float cheatSize = 0;
float rightRectLength = 150;
float x = 400;
float y = 300;
float speedX = 4;
float speedY = 4;

int diam;
int scoreL = 0;
int scoreR = 0;
int colourR = #FF0000;
int colourL = #0000FF;
int timer = 5;
int timerDelay = 100;
int ronRotate = 0;

PFont scoreBoardFont;
PFont comicSans;

String colourL2 = "BLUE";
String colourR2 = "RED";

PImage ball;
PImage ron;
PImage space;

import ddf.minim.*;
Minim minim;
AudioPlayer player;
AudioSample cheatStart;
AudioSample hit;
AudioSample MLG;
AudioSample beeps;

void setup() {
  size(800, 600);
  minim = new Minim(this);
  player = minim.loadFile("SANDSTORM.mp3", 150);
  cheatStart = minim.loadSample("Zelda.mp3", 1000);
  hit = minim.loadSample("Hit.mp3", 1000);
  MLG = minim.loadSample("MLGG.mp3", 1000);
  beeps = minim.loadSample("Beeps.mp3", 2000);
  comicSans = loadFont("ComicSansMS-Bold-48.vlw");
  scoreBoardFont = createFont("TIMES_SQ.TTF", 1, true);
  ball = loadImage("unnamed.png");
  ball.resize(20, 20);
  ron = loadImage("RON2.JPG");
  space = loadImage("red-space.jpg");
  frameRate(60);
  textAlign(CENTER);
  imageMode(CENTER);
}
void startScreen() {  
  if (gameStart == false) {
    fill(#FF0000);
    rect(130, 200, 50, 50);
    rect(width-180, 200, 50, 50);
    fill(#00FF00);
    rect(130, 300, 50, 50);
    rect(width-180, 300, 50, 50);
    fill(#0000FF);
    rect(130, 400, 50, 50);
    rect(width-180, 400, 50, 50);
    fill(#FFFF00);
    rect(130, 500, 50, 50);
    rect(width-180, 500, 50, 50);
    fill(#00FFFF);
    rect(130, 100, 50, 50);
    rect(width-180, 100, 50, 50);
    fill(2, 175, 30);
    rect(width/2-100, height-150, 200, 100);
    textFont(comicSans, 55);
    fill(203, 255, 210);
    text("START", width/2, height-80);

    if (colourL == #FF0000) {
      line(width-180, 200, width-130, 250);
      line(width-180, 250, width-130, 200);
    }
    if (colourL == #00FF00) {
      line(width-180, 300, width-130, 350);
      line(width-180, 350, width-130, 300);
    }
    if (colourL == #0000FF) {
      line(width-180, 400, width-130, 450);
      line(width-180, 450, width-130, 400);
    }
    if (colourL == #FFFF00) {
      line(width-180, 500, width-130, 550);
      line(width-180, 550, width-130, 500);
    }
    if (colourL == #00FFFF) {
      line(width-180, 100, width-130, 150);
      line(width-180, 150, width-130, 100);
    }
    if (colourR == #FF0000) {
      line(130, 200, 180, 250);
      line(130, 250, 180, 200);
    }
    if (colourR == #00FF00) {
      line(130, 300, 180, 350);
      line(130, 350, 180, 300);
    }
    if (colourR == #0000FF) {
      line(130, 400, 180, 450);
      line(130, 450, 180, 400);
    }
    if (colourR == #FFFF00) {
      line(130, 500, 180, 550);
      line(130, 550, 180, 500);
    }
    if (colourR == #00FFFF) {
      line(130, 100, 180, 150);
      line(130, 150, 180, 100);
    }
  }  
  if (timer >= 0) {
    fill(0);
    rect(0, 0, width, height);
    fill(255, 0, 0);
    textFont(comicSans, 30);
    text("Welcome to Ron's Pong Game", width/2, 100);
    text("1. Choose a colour", width/2, 150);
    text("2. Press the start button", width/2, 200);
    text("3. Use W/S and UP/DOWN to controll your paddle", width/2, 250);
    text("4. Press SPACE to shoot the ball", width/2, 300);
    text("5. First one to 7 points wins", width/2, 350);
    text("The game will start in", width/2-20, 450);
    fill(0, 250, 250);
    text(timer, 560, 450);
    if (frameCount % (int)frameRate == 0) {
      timer--;
    }
    if (timer == 0) {
      timerDelay = 0;
    }
  }
}
void redrawGameField() { 
  background(200);
  image(space, width/2, height/2);
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(ronRotate));
  image(ron, 0, 0);
  ron.resize(width-200, height-200);
  popMatrix();
  fill(colourL);
  rect(30, leftY+rectDragLeft, 20, 150);
  beginShape();
  vertex(30, leftY+rectDragLeft);
  vertex(40, leftY);
  vertex(60, leftY);
  vertex(50, leftY+rectDragLeft);
  endShape(CLOSE);
  beginShape();
  vertex(30, leftY+rectDragLeft+150);
  vertex(40, leftY+150);
  vertex(60, leftY+150);
  vertex(50, leftY+rectDragLeft+150);
  endShape(CLOSE);
  rect(40, leftY, 20, 150);
  fill(colourR);
  rect(width-40, rightY+rectDragRight, 20, rightRectLength);
  beginShape();
  vertex(width-20, rightY+rectDragRight);
  vertex(width-30, rightY);
  vertex(width-50, rightY);
  vertex(width-40, rightY+rectDragRight);
  endShape(CLOSE);
  beginShape();
  vertex(width-20, rightY+rectDragRight+rightRectLength);
  vertex(width-30, rightY+rightRectLength);
  vertex(width-50, rightY+rightRectLength);
  vertex(width-40, rightY+rectDragRight+rightRectLength);
  endShape(CLOSE);
  rect(width-50, rightY, 20, rightRectLength);
  rotate(radians(0));
  fill(255);
  rect(width/2-10, -10, 20, height+10);
  fill(255, 0, 255);
  diam = 20;
  image(ball, x, y);

  if (rightY > height) {
    rightY = - rightRectLength;
  } else if (rightY < -150) {
    rightY = height;
  }
  if (leftY > height) {
    leftY = -150;
  } else if (leftY < -150) {
    leftY = height;
  }
}
void bounceBall() {
  if (x > width-60 && y > rightY && y < rightY+rightRectLength && x < width-40) {
    speedX = speedX * -1;
    speedX = speedX - 0.5;
    println(speedX);
    x = x + speedX;
    speedY = random(-8, 8);
    toggle = !toggle;
    hit.trigger();
  }
  if (x < 70 && y > leftY && y < leftY+150 && x > 40) {    
    speedX = speedX * -1;
    speedX = speedX + 0.5;
    println(speedX);
    x = x + speedX;
    speedY = random(-8, 8);
    toggle = !toggle;
    hit.trigger();
  }
  if (y + 10> height || y - 10 < 0) {
    speedY = speedY * -1;
    y = y + speedY;
  }
}
void playerOne() { 
  rectDragLeft = -(leftY+75-height/2)*0.05;
  if (button['W']) {
    leftY = leftY - 8;
  }
  if (button['S']) {
    leftY = leftY + 8;
  }
  if (rightRectLength >= 150) {
    if (button['T']) {
      cheat = true;
      cheatSize = 1;
      cheatStart.trigger();
    }
  }
}
void playerTwo() {
  rectDragRight = -(rightY+75-height/2)*0.05;
  if (button[UP]) {
    rightY = rightY - 8;
  }
  if (button[DOWN]) {
    rightY = rightY + 8;
  }
}
void moveBall() {  
  if (gameStart == true) {
    x = x + speedX;
    y = y + speedY;
    if (button[' ']) {
      if (y > 5 && y < height-5) {
        if (x > 400  && pause == true && scoreL < 7 && scoreR < 7) {
          speedX = -4;
          speedY = 4;
          pause = false;
        } else if (x < 400 && pause == true && scoreL < 7 && scoreR < 7) {
          speedX = 4;
          speedY = 4;
          pause = false;
        }
      }
    }
  }
}
void castNewBall() {
  if (y != rightY + 75 && speedX == 0 && speedY == 0 && x > 600) {
    y = rightY + rightRectLength/2;
    pause = true;
  }
  if (y != leftY + 75 && speedX == 0 && speedY == 0 && x < 300) {
    y = leftY + 75;
    pause = true;
  }
}
void score() {
  if (x > 800) {
    scoreL = scoreL + 1;
    x = 720;
    y = rightY + 75;
    speedX = speedX * 0;
    speedY = speedY * 0;
  }
  if (x < 0) {
    scoreR = scoreR + 1;
    x = 90;
    y = leftY + 75;
    x = x + speedX;
    speedX = speedX * 0;
    speedY = speedY * 0;
  } 
  textFont(scoreBoardFont, 140);
  fill(colourL);
  text(scoreL, width/2-50, 80);
  fill(colourR);
  text(scoreR, width/2+50, 80);

  if (scoreL >= 7 && gameStart == true) {
    textFont(comicSans, 80);
    fill(random(255), random(255), random(255));
    text("GAME OVER", width/2, 300);
    text(colourL2 + " WINS", width/2, 400);
  }
  if (scoreR >= 7 && gameStart == true) {
    textFont(comicSans, 80);
    fill(random(255), random(255), random(255));
    text("GAME OVER", width/2, 300);
    text(colourR2 + " WINS", width/2, 400);
  }
}
void colour() {
  if (mousePressed) {
    if (mouseX > width/2-100 && mouseX < width/2 + 100 && mouseY > height-150 && mouseY < height-50) {
      gameStart = true;
    }
    if (mouseX > 130 && mouseX < 180) {
      if (mouseY > 200 && mouseY < 250 && colourR != #FF0000) {
        colourL = #FF0000;
        colourL2 = "RED";
      }  
      if (mouseY > 300 && mouseY < 350 && colourR != #00FF00) {
        colourL = #00FF00;
        colourL2 = "GREEN";
      }  
      if (mouseY > 400 && mouseY < 450 && colourR != #0000FF) {
        colourL = #0000FF;
        colourL2 = "BLUE";
      }  
      if (mouseY > 500 && mouseY < 550 && colourR != #FFFF00) {
        colourL = #FFFF00;
        colourL2 = "YELLOW";
      }  
      if (mouseY > 100 && mouseY < 150 && colourR != #00FFFF) {
        colourL = #00FFFF;
        colourL2 = "CYAN";
      }
    }
    if (mouseX > width-180 && mouseX < width-130) {
      if (mouseY > 200 && mouseY < 250 && colourL != #FF0000) {
        colourR = #FF0000;
        colourR2 = "RED";
      }  
      if (mouseY > 300 && mouseY < 350 && colourL != #00FF00) {
        colourR = #00FF00;
        colourR2 = "GREEN";
      }  
      if (mouseY > 400 && mouseY < 450 && colourL != #0000FF) {
        colourR = #0000FF;
        colourR2 = "BLUE";
      }  
      if (mouseY > 500 && mouseY < 550 && colourL != #FFFF00) {
        colourR = #FFFF00;
        colourR2 = "YELLOW";
      }  
      if (mouseY > 100 && mouseY < 150 && colourL != #00FFFF) {
        colourR = #00FFFF;
        colourR2 = "CYAN";
      }
    }
  }
}
void restart() {
  if (button['R']) {
    if (scoreL >= 7 || scoreR >= 7) {
      scoreL = 0;
      scoreR = 0;
      gameStart = false;
    }
  }
}
void cheat() {
  if (cheat == true) {
    rightRectLength = rightRectLength - cheatSize;
  } else if (cheat == false) {
    rightRectLength = rightRectLength + cheatSize;
  }
  if (rightRectLength <= 40) {
    cheatSize = 0;
  } else if (rightRectLength >= 150) {
    cheatSize = 0;
  }
  if (rightRectLength<=40 && toggle == true && x > 700) {
    cheat = false;
    cheatSize = 1;
    MLG.trigger();
  }
}
void sound() {
  if (!player.isPlaying()) {
    player.rewind();
    player.play();
  }
  if (timer == 3 && soundToggle == false) {
    beeps.trigger();
    soundToggle = true;
  }
}
void keyPressed() {
  button[keyCode] = true;
}
void keyReleased() {
  button[keyCode] = false;
}
void draw() {
  redrawGameField();
  score();
  startScreen();
  bounceBall();
  playerOne();
  playerTwo();
  moveBall();
  castNewBall();
  colour();
  restart();
  cheat();
  sound();
  delay(timerDelay);
  ronRotate++;
}

