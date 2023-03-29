class Ultimate {

  float x;
  float y;  
  float shipY;
  float shipX;
  float radius = 50;
  boolean isDead = false;
  float speed = 20;
  PImage img;
  float angle;
  float imgWidth;
  float imgHeight;

  Ultimate(float xPos, float yPos, float angle) {
    x = xPos;
    y = yPos;   
    this.angle = angle;
    img = loadImage("Ultimate.png");
    imgWidth = 200;
    imgHeight = 100;
  }

  void update() {   
    x += speed * cos(angle);
    y += speed * sin(angle);
    //x += speedX;
    //if (y < 0 - imgHeight) isDead = true; //TOP
    //if (x < 0 - imgHeight) isDead = true; // RIGHT
    //if (y > height + imgHeight) isDead = true; //DOWN
    //if (x > width + imgHeight) isDead = true; //LEFT
  }

  void draw() {
    //ellipse(x, y, 50, 50);
    pushMatrix();
    translate(x, y);
    rotate(angle + PI / 2);
    image(img, -img.width / 2, img.height / 2 - 200);
    popMatrix();
  }
}
