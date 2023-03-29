class Ice {

  float x;
  float y;  
  float shipY;
  float shipX;
  float radius;
  boolean isDead = false;
  float speed = 20;
  PImage img;
  float angle;

  Ice(float xPos, float yPos, float angle) {
    x = xPos;
    y = yPos;   
    this.angle = angle;
    img = loadImage("Ice.png");
    radius = 50;
  }

  void update() {   
    x += speed * cos(angle);
    y += speed * sin(angle);
    //x += speedX;
    if (y < img.height/4) isDead = true; //TOP
    if (x < img.width/4) isDead = true; // RIGHT
    if (y < 0 - img.height) isDead = true; //DOWN
    if (x < 0 - img.width) isDead = true; //LEFT
  }

  void draw() {
    //ellipse(x, y, 50, 50);
    pushMatrix();
    translate(x, y);
    rotate(angle + PI / 2);
    image(img, -img.width / 2 + 35, img.height / 2 - 225, 50, 75);
    popMatrix();
  }
}
