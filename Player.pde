class Player { 

  float x, y;
  float speed = 10;
  float radius;
  boolean isDead = false;
  PImage img;
  float angle;
  int health = 5;
  boolean hasUlt = false;
  boolean hasIceCrystal = false;
  boolean hasFireCrystal = false;
  boolean hasElectricCrystal = false;


  Player() {
    x = width/2;
    y = height/2;
    img = loadImage("Geni Basic.png");
    radius = img.height/2;
  }

  void update() {

    if (currentWeapon == 0)
    {
      img = loadImage("Geni Sword.png");
    } else if (currentWeapon == 1)
    {
      img = loadImage("Geni Ice.png");
    } else if (currentWeapon == 2)
    {
      img = loadImage("Geni Fire.png");//NEED CHARACER MODEL STILL
    } else if (currentWeapon == 3)
    {
      img = loadImage("Geni Electric.png");
    } else if (currentWeapon == 4)
    {
      img = loadImage("Geni Basic.png");
    }

    calcAngleToMouse();

    if (aKey) {
      if (x - img.width/4 > 0) x -= speed;
    }
    if (dKey) {
      if (x + img.width/4 < 800) x += speed;
    }
    if (sKey) {
      if (y + img.height/4 < 1000) y += speed;
    }
    if (wKey) {
      if (y - img.height/4 > 0) y -= speed;
    }

    if (health <= 0) 
    {
      isDead = true;
    }

    if (isDead == true)
    {
      switchToGameOver();
      isDead = false;
    }
    
    if(hasIceCrystal == true && hasFireCrystal == true && hasElectricCrystal == true){
      hasUlt = true;
      hasIceCrystal = false;
      hasFireCrystal = false;
      hasElectricCrystal = false;      
    }
  }

  void draw() {

    pushMatrix();
    translate(x, y);
    rotate(angle + PI / 2);
    image(img, -img.width / 2, -img.height / 2);
    popMatrix();
    fill(0, 255, 0);
    //ellipse(x, y, radius * 2, radius * 2);
  }

  void calcAngleToMouse() {
    float dx = mouseX - x;
    float dy = mouseY - y;
    angle = atan2(dy, dx);
  }
}
