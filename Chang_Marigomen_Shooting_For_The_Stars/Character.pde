class Character {

  float speed;
  int rodSpeed;
  int xPos;
  int yPos;
  PImage Char;
  int rodPosx;
  int rodPosy;


  Character (float gspeed, int gxPos, int gyPos, PImage CharImage, int grodPosx, int grodPosy, int grodSpeed) {
    speed = gspeed;
    xPos = gxPos;
    yPos = gyPos;
    Char = CharImage;
    rodPosx = grodPosx;
    rodPosy = grodPosy;
    rodSpeed = grodSpeed;
  }

  void displayChar () {
    image(Char, xPos, yPos);
  }

  void moveCharLeft() {  //Left movment for Character
    xPos -= speed;
    rodPosx = xPos;
  }

  void moveCharRight() { //Right movement for Character
    xPos += speed;
    rodPosx = xPos;
  }

  void drawRod() {

    line(xPos+300, yPos+200, rodPosx+300, rodPosy+200);
  }

  void moveRodDown() {
    rodPosx = xPos;
    rodPosy += rodSpeed;

    if (rodPosy > 700) {
      rodPosy = yPos;
    }
  }
  void moveRodUp() {

    rodPosy -= rodSpeed;

    if (rodPosy<yPos) {
      rodPosy = yPos;
    }
  }
  boolean isCollide(Star s) { //if collision between star and rod, return true


    if (dist(s.xPos+20, s.yPos+20, rodPosx+300, rodPosy+200) <= 25) {
      return true;
    } else {
      return false;
    }
  }

  boolean isCollide(Bat b) { //if collision between bat and rod, return true


    if (dist(b.xPos+20, b.yPos+20, rodPosx+300, rodPosy+200) <= 25) {
      return true;
    } else {
      return false;
    }
  }
  boolean isCollide(RainbowStar s) { //if collision between rainbow star and rod, return true


    if (dist(s.xPos+130, s.yPos+20, rodPosx+350, rodPosy+200) <= 20) {
      return true;
    } else {
      return false;
    }
  }

  void stopMovement() { //Stops all movement
    speed = 0;
  }
}