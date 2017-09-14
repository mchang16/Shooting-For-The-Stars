class Bat {

  int speed;
  int xPos;
  int yPos;
  PImage bat;

  Bat (int gspeed, int gxPos, int gyPos, PImage batImage) {
    speed = gspeed;
    xPos = gxPos;
    yPos = gyPos;
    bat = batImage;
  }

  void displayBat() {    
    bat.resize(0, 50);
    image(bat, xPos, yPos);
  }

  void moveBat() {    //Making it bounce back and forth
    xPos = xPos + speed;
    if (xPos+50 >= width || xPos <= 0)
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