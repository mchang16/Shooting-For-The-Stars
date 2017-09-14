class RainbowStar {

  int speed;
  int xPos;
  int yPos;
  PImage rainbow;
  float y;

  RainbowStar(int gspeed, int gxPos, int gyPos, PImage starImage) {
    speed = gspeed;
    xPos = gxPos;
    yPos = gyPos;
    rainbow = starImage;
  }

  void displayStarR() {
    y =700+50*sin(xPos*.04);     //Wave pattern
    rainbow.resize(0, 70);
    image(rainbow, xPos, y);
  }

  void moveStarR() {              //Making it bounce back and forth

    xPos = xPos + speed;          //If it reaches one edge of the screen, go the opposite direction
    if (xPos >= width-55 || xPos <= -40)
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