import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

PFont optionsFont;
PFont fontTitle;
PFont basic;
PImage sky;
PImage gameBackground;
PImage starImage;
PImage batImage;
PImage characterImage;
PImage characterImage2;
PImage RainbowImage;
boolean lockPlay = false;
boolean lockEasy = false;
boolean lockHard = false;
boolean lockIns = false;
boolean lockMenu = false;
boolean lockOver = false;
boolean lockBoy = false;
boolean lockGirl = false;
boolean lockCharSelect = false;
boolean lockTint = false;
int y2 = 0;
int y1 = 0;

String [] lives = {". ", ". ", ". "};

Star [] starArray = new Star [15];
Star [] starArray2 = new Star[20];

Bat [] batArray = new Bat [5];
Bat [] batArray2 = new Bat [10];

Character myChar = new Character(15, 150, 200, characterImage, 150, 200, 10);    //creates boy Character ojects
Character myChar2 = new Character(15, 150, 50, characterImage, 150, 200, 10);

Character girlChar = new Character(15, 150, 200, characterImage2, 150, 200, 20); //creates girl Character ojects
Character girlChar2 = new Character(15, 150, 50, characterImage2, 150, 200, 20);

RainbowStar rStar = new RainbowStar((int)random(5, 8), (int)random(0, 200), (int)random(600, 800), RainbowImage);

int score;
int j;

Minim minim;
AudioPlayer song;
AudioSnippet starEffect;
AudioSnippet batEffect;
AudioSnippet rainbowEffect;


public void setup() {
  size(1002, 1044);
  background(255);
  sky = loadImage("Lighter New .jpg");
  gameBackground =loadImage("NightSky3.png");
  optionsFont = loadFont("Monserga-100.vlw");
  basic = loadFont("GillSansMT-48.vlw");
  fontTitle = loadFont("DJBIt'sFullofStars-100.vlw");
  starImage = loadImage("Light Yellow Star.png");        
  batImage = loadImage("Bat.gif");
  characterImage = loadImage("Moon Character.png");
  characterImage2 = loadImage("Moon Character2.png");
  RainbowImage = loadImage("Rainbow.png");

  rStar = new RainbowStar((int)random(10, 11), (int)random(0, 200), (int)random(600, 800), RainbowImage);

  myChar =  new Character(30, 150, 200, characterImage, 150, 200, 10);     //creates boy Character ojects
  myChar2 = new Character(30, 150, 50, characterImage, 150, 200, 10);

  girlChar = new Character(15, 150, 200, characterImage2, 150, 200, 17);   //creates girl Character ojects
  girlChar2 = new Character(15, 150, 50, characterImage2, 150, 200, 17);

  minim = new Minim(this);
  song = minim.loadFile("Snowdin.mp3");
  song.loop();

  starEffect = minim.loadSnippet("Twinkle.mp3");
  batEffect = minim.loadSnippet("Page Flip.mp3");
  rainbowEffect = minim.loadSnippet("RainbowChime.mp3");

  score = 0;
  j = 0;

  for (int i = 0; i<starArray.length; i++) {  
    starArray[i] = new Star((int)random(10, 13), (int)random(0, 200), (int)random(600, 800), starImage);     //puts lots of Stars into array for Easy level
  }

  for (int i = 0; i <starArray2.length; i++) {
    starArray2[i] = new Star((int)random(14, 17), (int)random(0, 200), (int)random(600, 800), starImage);    //puts lots of Stars into array for Hard level
  }

  for (int i = 0; i < batArray.length; i++) {
    batArray[i] = new Bat((int)random(10, 13), (int)random(0, 200), (int)random(600, 800), batImage);        //puts lots of Bats into array for Easy level
  }

  for (int i = 0; i < batArray2.length; i++) {
    batArray2[i] = new Bat((int)random(14, 17), (int)random(0, 200), (int)random(600, 800), batImage);       //puts lots of Bats into array for Hard level
  }
}

public void draw() {
  background(sky);
  fill(#FAF1AC);
  textAlign(CENTER);

  textFont(fontTitle);                    
  textSize(90);
  text("Fishing For The", width/2, 250);
  text("Stars", width/2, 400);

  fill(0);
  textFont(optionsFont);
  text("Play", width/2, height/2+50 );
  highlightPlay();

  fill(0);
  text("Instructions", width/2, height/2+150);
  highlightIn();
  fill(0);

  text("Quit", width/2, height/2+250);
  highlightQuit();
  fill(0);

  if (lockPlay) {               //Used to load each screen/stage
    menu();
    playScreen();
  }

  if (lockEasy) {
    characterSelection();
    menu();
    lockTint = true;
    if (lockBoy) {
      lockTint = false;
      easyLevel();
      menu();
    }
    if (lockGirl) {
      lockTint = false;
      easyLevelGirl();
      menu();
    }
  }

  if (lockHard) {
    characterSelection();
    menu();
    lockTint = true;
    if (lockBoy) {
      lockTint = false;
      hardLevel();
      menu();
    }
    if (lockGirl) {
      lockTint = false;
      hardLevelGirl();
      menu();
    }
  }

  if (lockIns) {
    instructions();
    menu();
  }

  if (lockOver) {
    gameOver();
  }
}

public void highlightPlay() { //Highlights "Play" button
  if (mouseX <width/2+50 && mouseX >width/2-50 && mouseY<height/2+50 && mouseY>height/2) {

    fill(#F7CE91);
    text("Play", width/2, height/2+50 );
  }
}

public void highlightIn() {//Highlights "Instructons" button
  if (mouseX <width/2+150 && mouseX >width/2-150 && mouseY<height/2+150 && mouseY>height/2+100) {

    fill(#F7CE91);
    text("Instructions", width/2, height/2+150);
  }
}

public void highlightQuit() { //Highlights "Quit" button
  if (mouseX <width/2+50 && mouseX >width/2-50 && mouseY<height/2+250 && mouseY>height/2+200) {

    fill(#F7CE91);
    text("Quit", width/2, height/2+250);
  }
}

public void playScreen() {    //Creates the level select screen
  background(sky);
  fill(#FAF1AC);
  textFont(fontTitle);
  textSize(90);
  text("Select a Level", width/2, 250);

  fill(0);
  textFont(optionsFont);
  text("Easy", width/2 - 150, height/2+50 );
  highlightEasy();

  fill(0);
  textFont(optionsFont);
  text("Hard", width/2+150, height/2+50);
  highlightHard();
}

public void highlightEasy() {  //Highlights "Easy" on level select screen
  if (mouseX <width/2-100 && mouseX >width/2-200 && mouseY<height/2+50 && mouseY>height/2) {
    fill(#F7CE91);
    text("Easy", width/2-150, height/2+50 );
  }
}

public void highlightHard() {  //Highlights "Hard" on level select screen
  if (mouseX <width/2+200 && mouseX >width/2+100 && mouseY<height/2+50 && mouseY>height/2) {
    fill(#F7CE91);
    text("Hard", width/2+150, height/2+50);
  }
}

public void easyLevel() {                      //loads the Easy level
  gameBackground.resize(1002, 1044);           //creates moving background
  image(gameBackground, y1, 0);                //draws image at (0,0);
  y1 -= 2;                                     //Shifting it to the left
  image(gameBackground, width - y2, 0);        //Drawing another background, so as the first one slides, the next one follows
  y2+=2;
  if (y1 <= -width) {                          //resets to zero if image gets off screen
    y1 = 0;
  }
  if (y2 >= width) {                           //resets to zero if image gets off screen
    y2 = 0;
  }
  stroke(255);
  displayScore();
  displayLife();
  myChar.displayChar();
  myChar.drawRod();


  for (int i =0; i< starArray.length; i++) {      //telling it that each Star will be displayed and will move for Easy level
    starArray[i].moveStar();
    starArray[i].displayStar();

    if (myChar.isCollide(starArray[i])) {         //if rod collides with star, move star position way off screen using isCaught method
      starArray[i].isCaught();
      myChar.rodPosy = myChar.yPos;               //makes rod bounce back after it catches something
      score++;                                    //increase score by 1
      starEffect.play();                          //sound effects for star collision
      starEffect.rewind();
    }
  }

  for (int i = 0; i < batArray.length; i++) {      //telling it that each Bat will be displayed and will move for Easy level
    batArray[i].displayBat();
    batArray[i].moveBat();

    if ( myChar.isCollide(batArray[i])) {          //if collison with a bat
      batArray[i].isCaught();                      //if rod collides with bat, move bat position way off screen using isCaught method
      myChar.rodPosy = myChar.yPos;                //makes rod bounce back up

      lives[2 -j ] = " ";                          
      if (j < lives.length)
        j++;
      if (lives[0].equals(" ")) {                  //if no more lives, shows "Game Over" screen
        lockOver = true;
      }
      batEffect.play();
      batEffect.rewind();
    }
  }
  rStar.moveStarR();                             //rainbow star move and display
  rStar.displayStarR();

  if (myChar.isCollide(rStar)) {                  
    rStar.isCaught();
    myChar.speed = 50;                            //increases speed of player after getting rainbow star
    myChar.rodPosy = myChar.yPos;                 //resets the rod position each time something is caught
    rStar.xPos = -1000;                           //if rod and rainbow star collide, move the star off screen

    rainbowEffect.play();
    rainbowEffect.rewind();
  }

  if (lockOver) {                                 //if Easy level Game Over, all objects stop moving
    myChar.rodPosy = myChar.yPos;
    for (int i = 0; i < batArray.length; i++) {
      batArray[i].stopMovement();
    }
    for (int i = 0; i < starArray.length; i++) {
      starArray[i].stopMovement();
    }
    rStar.stopMovement();
    myChar.stopMovement();
  }

  if (score == 10) {                              //if Easy level Win, show Winning Screen and stop all movement
    youWin();
    myChar.rodPosy = myChar.yPos;
    for (int i = 0; i < batArray.length; i++) {
      batArray[i].stopMovement();
    }
    for (int i = 0; i < starArray.length; i++) {
      starArray[i].stopMovement();
    }
    rStar.stopMovement();
    myChar.stopMovement();
  }
}

public void hardLevel() { //loads Hard level for Boy
  gameBackground.resize(1002, 1044);
  image(gameBackground, y1, 0);
  y1 -= 2;
  image(gameBackground, width - y2, 0);
  y2+=2;
  if (y1 <= -width) {
    y1 = 0;
  }
  if (y2 >= width) {
    y2 = 0;
  }
  stroke(255);
  displayScore();
  displayLife();
  myChar2.displayChar();
  myChar2.drawRod();

  for (int i =0; i< starArray2.length; i++) {      //telling it that each Star will be displayed and will move for Hard level
    starArray2[i].moveStar();
    starArray2[i].displayStar();

    if ( myChar2.isCollide(starArray2[i])) {       //if collision between rod and star
      starArray2[i].isCaught();
      myChar2.rodPosy = myChar2.yPos;              //makes the rod bounce back
      score++;
      starEffect.play();
      starEffect.rewind();
    }
  }

  for (int i = 0; i < batArray2.length; i++) {      //telling it that each Bat will be displayed and will move for Hard level
    batArray2[i].displayBat();
    batArray2[i].moveBat();

    if ( myChar2.isCollide(batArray2[i])) {          //if collision between rod and bat
      batArray2[i].isCaught();
      myChar2.rodPosy = myChar2.yPos;                //makes the rod bounce back
      lives[2 -j ] = " ";
      if (j < lives.length)
        j++;
      if (lives[0].equals(" ")) {
        lockOver = true;
      }
      batEffect.play();
      batEffect.rewind();
    }
  }

  rStar.moveStarR();
  rStar.displayStarR();

  if (myChar2.isCollide(rStar)) {
    rStar.isCaught();
    myChar2.speed = 50;
    myChar2.rodPosy = myChar2.yPos;
    rStar.xPos = -1000;
    starEffect.play();
    starEffect.rewind();
  }

  if (lockOver) {  //if Hard level Game Over, show Game Over Screen and stop all movement
    myChar2.rodPosy = myChar2.yPos;
    for (int i = 0; i < batArray2.length; i++) {
      batArray2[i].stopMovement();
    }
    for (int i = 0; i < starArray2.length; i++) {
      starArray2[i].stopMovement();
    }
    rStar.stopMovement();
    myChar2.stopMovement();
  }


  if (score == 15) {  //if Hard level Win, show Winning Screen and stop all movement
    youWin();
    myChar2.rodPosy = myChar2.yPos;
    for (int i = 0; i < batArray2.length; i++) {
      batArray2[i].stopMovement();
    }
    for (int i = 0; i < starArray2.length; i++) {
      starArray2[i].stopMovement();
    }
    rStar.stopMovement();
    myChar2.stopMovement();
  }
}

void easyLevelGirl() {                           //loads Easy level for Girl
  gameBackground.resize(1002, 1044);
  image(gameBackground, y1, 0);
  y1 -= 2;
  image(gameBackground, width - y2, 0);
  y2+=2;
  if (y1 <= -width) {
    y1 = 0;
  }
  if (y2 >= width) {
    y2 = 0;
  }
  stroke(255);
  displayScore();
  displayLife();
  girlChar.displayChar();
  girlChar.drawRod();

  for (int i =0; i< starArray.length; i++) {      //telling it that each Star will be displayed and will move for Easy level
    starArray[i].moveStar();
    starArray[i].displayStar();

    if (girlChar.isCollide(starArray[i])) {         //if rod collides with star, move star position using isCaught method
      starArray[i].isCaught();
      girlChar.rodPosy = girlChar.yPos;
      score++;
      starEffect.play();                              //sound effects for star collision
      starEffect.rewind();
    }
  }

  for (int i = 0; i < batArray.length; i++) {      //telling it that each Bat will be displayed and will move for Easy level
    batArray[i].displayBat();
    batArray[i].moveBat();

    if ( girlChar.isCollide(batArray[i])) {
      batArray[i].isCaught();
      girlChar.rodPosy = myChar.yPos;

      lives[2 -j ] = " ";
      if (j < lives.length)
        j++;
      if (lives[0].equals(" ")) {
        lockOver = true;
      }
      batEffect.play();
      batEffect.rewind();
    }
  }
  rStar.moveStarR();                             //rainbow star move and display
  rStar.displayStarR();

  if (girlChar.isCollide(rStar)) {                  
    rStar.isCaught();
    girlChar.speed = 35;                            //increases speed of player after getting rainbow star
    girlChar.rodPosy = myChar.yPos;                 //resets the rod position each time something is caught
    rStar.xPos = -1000;                           //if rod and rainbow star collide, move the star off screen
    score++;
    rainbowEffect.play();
    rainbowEffect.rewind();
  }

  if (lockOver) {                     //if Easy level Game Over, all objects stop moving
    girlChar.rodPosy = girlChar.yPos;
    for (int i = 0; i < batArray.length; i++) {
      batArray[i].stopMovement();
    }
    for (int i = 0; i < starArray.length; i++) {
      starArray[i].stopMovement();
    }
    rStar.stopMovement();
    girlChar.stopMovement();
  }

  if (score == 10) {                 //if Easy level Win (player earns 10 points), show Winning Screen and stop all movement
    youWin();
    girlChar.rodPosy = girlChar.yPos;
    for (int i = 0; i < batArray.length; i++) {
      batArray[i].stopMovement();
    }
    for (int i = 0; i < starArray.length; i++) {
      starArray[i].stopMovement();
    }
    rStar.stopMovement();
    girlChar.stopMovement();
  }
}


void hardLevelGirl() {                //loads Hard level for Girl
  gameBackground.resize(1002, 1044);
  image(gameBackground, y1, 0);
  y1 -= 2;
  image(gameBackground, width - y2, 0);
  y2+=2;
  if (y1 <= -width) {
    y1 = 0;
  }
  if (y2 >= width) {
    y2 = 0;
  }
  stroke(255);
  displayScore();
  displayLife();

  girlChar2.displayChar();
  girlChar2.drawRod();

  for (int i =0; i< starArray2.length; i++) {      //telling it that each Star will be displayed and will move for Hard level
    starArray2[i].moveStar();
    starArray2[i].displayStar();

    if ( girlChar2.isCollide(starArray2[i])) {
      starArray2[i].isCaught();
      girlChar2.rodPosy = girlChar2.yPos;
      score++;
      starEffect.play();
      starEffect.rewind();
    }
  }

  for (int i = 0; i < batArray2.length; i++) {      //telling it that each Bat will be displayed and will move for Hard level
    batArray2[i].displayBat();
    batArray2[i].moveBat();

    if ( girlChar2.isCollide(batArray2[i])) {
      batArray2[i].isCaught();
      girlChar2.rodPosy = girlChar2.yPos;
      lives[2 -j ] = " ";
      if (j < lives.length)
        j++;
      if (lives[0].equals(" ")) {
        lockOver = true;
      }
      batEffect.play();
      batEffect.rewind();
    }
  }

  rStar.moveStarR();
  rStar.displayStarR();

  if (girlChar.isCollide(rStar)) {
    rStar.isCaught();
    girlChar2.speed = 35;
    girlChar.rodPosy = girlChar.yPos;
    rStar.xPos = -1000;
    starEffect.play();
    starEffect.rewind();
  }

  if (lockOver) {  //if Hard level Game Over, show Game Over Screen and stop all movement
    girlChar2.rodPosy = girlChar2.yPos;
    for (int i = 0; i < batArray2.length; i++) {
      batArray2[i].stopMovement();
    }
    for (int i = 0; i < starArray2.length; i++) {
      starArray2[i].stopMovement();
    }
    rStar.stopMovement();
    girlChar2.stopMovement();
  }


  if (score == 15) {  //if Hard level Win, show Winning Screen and stop all movement
    youWin();
    girlChar2.rodPosy = girlChar2.yPos;
    for (int i = 0; i < batArray2.length; i++) {
      batArray2[i].stopMovement();
    }
    for (int i = 0; i < starArray2.length; i++) {
      starArray2[i].stopMovement();
    }
    rStar.stopMovement();
    girlChar2.stopMovement();
  }
}



void displayScore() {  //displays Score count

  fill(255);
  textSize(40);
  textFont(fontTitle);
  text("Score:  ", 130, 100 );
  textSize(40);
  text(" " +score, 230, 100);
}

void displayLife() {    //displays Life count
  text("Lives :", 450, 100);
  textSize(200);
  int x = 600;
  for (int i = 0; i < 3; i++) {
    text(lives[2 - i], x, 110);
    x+= 50;
  }
}

void instructions() {  //loads "How To Play" screen
  background(sky);
  fill(#FFDF8E, 50);
  stroke(#FFC940);
  strokeWeight(2);
  rect(100, 50, 800, 900);

  fill(#FAF1AC);
  textFont(fontTitle);
  textSize(50);
  text("How To Play", width/2, 150);

  fill(255);
  textFont(basic);
  textSize(30);
  text("1. Select a Level", width/2, 225);
  text("2. Go Fish", width/2, 350);
  text("3. Stars and Bats", width/2, 500);

  fill(0);
  textSize(20);
  text("Easy: Collect 10 Stars to Win!", width/2, 275);
  text("Hard: Collect 15 Stars to Win!", width/2, 300);
  text("You are sitting on the moon, looking for stars to catch!", width/2, 400);
  text("Use your right and left arrow keys to move your character in the respective directions.", width/2, 425);
  text("Use the up and down arrow keys to lower and raise your rod and catch a star!", width/2, 450);
  text("In order to win, you need to catch stars!", width/2, 525);
  text("However, if you happen to catch a bat, you'll lose a life!", width/2, 550);
  text("You have three lives. If you lose all three, it's game over.", width/2, 575);

  text("Catch the rainbow star to increase your speed!", width/2, 850);

  batImage.resize(0, 50);
  image(batImage, 200, 700);
  image(batImage, 150, 720);
  image(batImage, 230, 650);

  starImage.resize(0, 50);
  image(starImage, 650, 700);
  image(starImage, 750, 750);
  image(starImage, 720, 650);

  image(characterImage, width/2-225, 500);

  RainbowImage.resize(0, 70);
  image(RainbowImage, width/2-50, 860);
}

void menu() {  //draws little orange box "Menu" button
  fill(#FFDF8E);
  stroke(#FFC940);
  strokeWeight(2);
  rect(850, 30, 100, 50);

  fill(255);
  stroke(0);
  strokeWeight(2);
  textFont(basic);
  textSize(35);
  text("Menu", 900, 65);
}

void youWin() {    //draws Winning Screen
  fill(#FFDF8E, 75);
  stroke(#FFC940);
  strokeWeight(2);
  rect(200, 300, 600, 300);
  textFont(fontTitle);
  textSize(60);
  stroke(0);
  strokeWeight(4);
  fill(255);
  text("Wow! Good Job!", width/2, 420);
  fill(0);
  textFont(optionsFont);
  text("Play Again", width/2, height/2 );
  if (mouseX <width/2+100 && mouseX >width/2-100 && mouseY<height/2 && mouseY>height/2-50) {

    fill(#F7CE91);
    text("Play Again", width/2, height/2);
  }
}

void gameOver() {   //draws Game Over screen
  fill(#FFDF8E, 75);
  stroke(#FFC940);
  strokeWeight(2);
  rect(200, 300, 600, 300);
  textFont(fontTitle);
  textSize(60);
  stroke(0);
  strokeWeight(4);
  fill(255);
  text("Game Over!", width/2, 420);
  fill(0);
  textFont(optionsFont);
  text("Play Again", width/2, height/2 );
  if (mouseX <width/2+100 && mouseX >width/2-100 && mouseY<height/2 && mouseY>height/2-50) {

    fill(#F7CE91);
    text("Play Again", width/2, height/2);
  }
}

void characterSelection() {  //draws Character Selection screen
  background(sky); 
  textAlign(CENTER);
  fill(0, 50);
  rect(0, 0, 1002, 1044);
  textFont(fontTitle);
  fill(#FAF1AC);
  textSize(70);
  text("Select Your Character", 500, 200);

  noTint();
  image(characterImage, 50, 200);
  image(characterImage2, 50, 500);

  textSize(50);
  //text("Cosmo", 600, 350);
  textFont(basic);
  textSize(30);
  text("Faster when moving left and right", 600, 400);

  textFont(fontTitle);
 // text("Stella", 600, 650);
  textFont(basic);
  textSize(30);
  text("Faster when moving rod up and down", 630, 700);

  if (lockTint && mouseX > 170 && mouseX <350 && mouseY <500 && mouseY >270) {   //Highlights the boy selection

    tint(220);
    image(characterImage, 50, 200);
  }

  if (lockTint && mouseX > 170 && mouseX <350 && mouseY <800 && mouseY >590) {   //Highlights the girl selection
    tint(220);
    image(characterImage2, 50, 500);
  }
}

void reset() {  //Resets the game when you leave the levels
  size(1002, 1044);
  background(255);
  sky = loadImage("Lighter New .jpg");
  gameBackground =loadImage("NightSky3.png");
  optionsFont = loadFont("Monserga-100.vlw");
  basic = loadFont("GillSansMT-48.vlw");
  fontTitle = loadFont("DJBIt'sFullofStars-100.vlw");
  starImage = loadImage("Light Yellow Star.png");        
  batImage = loadImage("Bat.gif");
  characterImage = loadImage("Moon Character.png");
  characterImage2 = loadImage("Moon Character2.png");
  RainbowImage = loadImage("Rainbow.png");

  rStar = new RainbowStar((int)random(10, 11), (int)random(0, 200), (int)random(600, 800), RainbowImage);

  myChar =  new Character(30, 150, 200, characterImage, 150, 200, 10);     //creates boy Character ojects
  myChar2 = new Character(30, 150, 50, characterImage, 150, 200, 10);

  girlChar = new Character(15, 150, 200, characterImage2, 150, 200, 17);   //creates girl Character ojects
  girlChar2 = new Character(15, 150, 50, characterImage2, 150, 200, 17);


  score = 0;
  j = 0;

  for (int i = 0; i<starArray.length; i++) {  
    starArray[i] = new Star((int)random(10, 13), (int)random(0, 200), (int)random(600, 800), starImage);      //puts lots of Stars into array for Easy level
  }

  for (int i = 0; i <starArray2.length; i++) {
    starArray2[i] = new Star((int)random(14, 17), (int)random(0, 200), (int)random(600, 800), starImage);    //puts lots of Stars into array for Hard level
  }

  for (int i = 0; i < batArray.length; i++) {
    batArray[i] = new Bat((int)random(10, 13), (int)random(0, 200), (int)random(600, 800), batImage);          //puts lots of Bats into array for Easy level
  }

  for (int i = 0; i < batArray2.length; i++) {
    batArray2[i] = new Bat((int)random(14, 17), (int)random(0, 200), (int)random(600, 800), batImage);      //puts lots of Bats into array for Hard level
  }

  lives[0] = ".";  //rests the lives array
  lives[1] = ".";
  lives[2] = ".";
}

void mouseClicked() {

  if (mouseX <width/2+50 && mouseX >width/2-50 && mouseY<height/2+50 && mouseY>height/2) {        //Selects Play
    lockPlay = true;
  }
  if (mouseX <width/2-100 && mouseX >width/2-200 && mouseY<height/2+50 && mouseY>height/2) {      //Selects "Easy"
    lockEasy = true;
  }
  if (mouseX <width/2+200 && mouseX >width/2+100 && mouseY<height/2+50 && mouseY>height/2) {      //Selects "Hard"
    lockHard = true;
  }
  if (!lockPlay && mouseX <width/2+150 && mouseX >width/2-150 && mouseY<height/2+150 && mouseY>height/2+100) { //Selects "How To Play"
    lockIns = true;
  }
  if (mouseX < 950 && mouseX > 850 && mouseY < 80 && mouseY > 30) {          //Small orange "Menu" box

    lockPlay = false;
    lockIns = false;
    lockEasy = false;
    lockHard = false;
    lockOver = false;
    lockBoy = false;
    lockGirl = false;
    reset();
  }

  if (mouseX <width/2+100 && mouseX >width/2-100 && mouseY<height/2 && mouseY>height/2-50) {   //Game Over play again
    lockPlay = false;
    lockOver = false;
    lockEasy = false;
    lockHard = false;
    lockOver = false;
    lockBoy = false;
    lockGirl = false;
    reset();
  }

  if (mouseX > 170 && mouseX <350 && mouseY <500 && mouseY >270) {  //If boy selected
    lockBoy = true;
  }


  if (mouseX > 170 && mouseX <350 && mouseY <800 && mouseY >590) {  //If girl selected
    lockGirl = true;
  }

  if (!lockPlay && mouseX <width/2+50 && mouseX >width/2-50 && mouseY<height/2+250 && mouseY>height/2+200) {      // when you click "Quit", it exits the game
    exit();
  }
}

void keyPressed() {
  if (keyCode == LEFT) { //Character moves Left
    if (myChar.xPos > -200)
      myChar.moveCharLeft();
    if (myChar.xPos > -200)
      myChar2.moveCharLeft();
    if (girlChar.xPos >= -200)
      girlChar.moveCharLeft();
    if (girlChar2.xPos >= -200)
      girlChar2.moveCharLeft();
  }

  if (keyCode == RIGHT) {        //Character moves Right
    if (myChar.xPos < width - 320)
      myChar.moveCharRight();
    if (myChar2.xPos < width - 320)
      myChar2.moveCharRight();
    if (girlChar.xPos < width - 320)
      girlChar.moveCharRight();
    if (girlChar2.xPos < width - 320)
      girlChar2.moveCharRight();
  }

  if (keyCode == UP) {           //Character rod moves Up
    myChar.moveRodUp();
    myChar2.moveRodUp();
    girlChar.moveRodUp();
    girlChar2.moveRodUp();
  }
  if (keyCode == DOWN) {         //Character rod moves Down
    if (lockHard) {
      myChar2.moveRodDown();
      girlChar2.moveRodDown();
    } else
      myChar.moveRodDown();
    girlChar.moveRodDown();
  }
}