class Sword {

  float x;
  float y;
  float radius;
  boolean isDead = false;
  PImage img;
  float angle;
  float timer;

  Sword(float xPos, float yPos, float angle) {
    x = xPos + 200 * cos(angle);
    y = yPos + 200 * sin(angle);
    this.angle = angle;
    img = loadImage("Slash.png");
    radius = 100;
  }

  void update() {   
   
    timer += 1 * dt; 
    if(timer >= .05){
      isDead = true;
      timer = 0;
    }
  }

  void draw() {
    //ellipse(x, y, 50, 50);
    pushMatrix();
    translate(x, y);
    rotate(angle + PI / 2);
    image(img, -img.width / 2, img.height / 2 - 150, radius, radius);
    popMatrix();
    //circle(x, y, radius);
  }
}
