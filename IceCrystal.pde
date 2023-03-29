class IceCrystal {
  
  //Declare
  float x;
  float y;
  int radius;
  boolean isDropped = false;
  boolean playerOn = false;
  PImage crystal;
  
  
  IceCrystal(float xPos, float yPos) {
    crystal = loadImage("ship.png");
  }
  
  void Update() {
    
  }
  
  void Draw() {
    if(isDropped == true) image(crystal, x - radius, y - radius, radius, 75);
  
  }
}
