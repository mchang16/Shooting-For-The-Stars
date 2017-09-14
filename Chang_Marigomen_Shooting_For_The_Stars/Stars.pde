class Star {

  int speed;
  int xPos;
  int yPos;
  PImage star;

  Star(int gspeed, int gxPos, int gyPos, PImage starImage) {
    speed = gspeed;
    xPos = gxPos;
    yPos = gyPos;
    star = starImage;
  }

  void displayStar() {
    star.resize(0, 50);
    image(star, xPos, yPos);
  }

  void moveStar() {    //Making it bounce back and forth
    xPos = xPos + speed;
    if (xPos >= width-55 || xPos <= 0)
      speed = -speed;
  }

  void isCaught() {
    // Stop it from moving by setting speed equal to zero
    speed = 0; 
    // Set the location to somewhere way off-screen
    yPos = - 1000;
  }

  void stopMovement() {
    speed = 0;
  }
}