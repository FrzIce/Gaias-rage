class Enemy {

  // DECLARE CLASS VARIABLES HERE
  float x;
  float y = -100;
  float speedY;
  float speedYSlow;
  float radius;
  boolean isDead = false;
  boolean gotPass = false;
  PImage img;
  float health = 200;
  boolean slowed = false;
  float slowTimer = 5;
  boolean burned = false;
  float burnTimer = 5;
  boolean stuned = false;
  float stunTimer = 1;

  Enemy() { // CONSTRUCTOR
    // This function is called when an object of this class is instantiated.
    // This function only runs once.
    // this function runs before any other function in this class.
    img = loadImage("Enti.png");
    x = random(width);
    speedY = 75;
    speedYSlow = speedY * .5;
    radius = random(25, 50);
  }

  void update() { // UPDATE
    // This function is called every frame.
    // This function MUST be called before the void draw() function.
    // This function is used to handle arithmetic & logical operations.



    //Freeze effect and movement

    if (!slowed) {
      if (!stuned) y += speedY * dt;
    } else {
      if (!stuned) y += speedYSlow * dt;
      slowTimer -= dt;
      if (slowTimer <= 0) {
        slowed = false;
        slowTimer = 5;
      }
    } 

    //burned
    if (burned) {
      health -= 50 * dt;
      burnTimer -= dt;
      if (burnTimer <= 0) {
        burned = false;
        burnTimer = 5;
      }
    }

    if (stuned) {
      stunTimer -= dt;
      if (stunTimer <= 0) {
        stuned = false;
        stunTimer = 1;
      }
    }




    if (y >= height + radius) {
      score -= 1;
      gotPass = true;
    }
    if (health <= 0)isDead = true;
  }

  void draw() { // DRAW
    // This function is also called every frame.
    // This function MUST be called after the void update() function.
    // This function is used to handle visual operations.
    fill(255, 0, 0);
    image(img, x - radius, y - radius, radius * 2, radius * 2);
    //ellipse(x, y, 2 * radius, 2 * radius);
    fill(255);
  }
}
