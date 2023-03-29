//This program is a twin stick shooter called Gaia's Rage where you defend against elemental units with you own elemental effects.
//Copyright Trevor Baylie

//Declare variables here...
SceneTitle sceneTitle;
ScenePlay scenePlay;
SceneGameOver sceneGameOver;

// Delta Time Variables
float dt;
float prevTime = 0;

// Declare input variables here...
boolean wKey, aKey, sKey, dKey, leftMouse, prevLeftPressed = false;
boolean keyEnter, keyEsc = false;
boolean shiftPressed, prevShiftPressed, spacePressed, prevSpacePressed = false;


// Declare Global Variables here...
int score = 0;
int currentWeapon = 0; // 0 - gun (TEST), 1 - Ice, 2 - Fire, 3 - Electric, 4 - Sword


void setup() {
  size(800, 1000);
  switchToTitle();
}

void draw() {
  //background(128); // CLEARS THE SCREEN
  calcDeltaTime();

  // update and draw any active scenes:

  if (sceneTitle != null) {
    sceneTitle.update();
    if (sceneTitle != null) sceneTitle.draw(); // this extra if statement exists because the sceneTitle.update() might result in the scene switching...
  } else if (scenePlay != null) {
    scenePlay.update();
    if (scenePlay != null) scenePlay.draw(); // this extra if statement exists because the scenePlay.update() might result in the scene switching...
  } else if (sceneGameOver != null) {
    sceneGameOver.update();
    if (sceneGameOver != null) sceneGameOver.draw(); // this extra if statement exists because the sceneGameOver.update() might result in the scene switching...
  }
} 

void switchToTitle() {
  sceneTitle = new SceneTitle();
  scenePlay = null;
  sceneGameOver = null;
}
void switchToPlay() {
  scenePlay = new ScenePlay();
  score = 0;
  currentWeapon = 0;
  sceneTitle = null;
  sceneGameOver = null;
}
void switchToGameOver() {
  sceneGameOver = new SceneGameOver();
  scenePlay = null;
  sceneTitle = null;
}


// Radial Collsion detection algorithm BASIC 
boolean checkCollisionPlayerEnemy(Player a, Enemy b) {
  float dx = b.x - a.x;
  float dy = b.y - a.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= a.radius + b.radius) return true;
  return false;
}

// Radial Collsion detection algorithm FLAIN
boolean checkCollisionPlayerFlain(Player a, Flain b) {
  float dx = b.x - a.x;
  float dy = b.y - a.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= a.radius + b.radius) return true;
  return false;
}

// Radial Collsion detection algorithm EVI
boolean checkCollisionPlayerEvi(Player a, Evi b) {
  float dx = b.x - a.x;
  float dy = b.y - a.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= a.radius + b.radius) return true;
  return false;
}

// Radial Collsion detection algorithm FION
boolean checkCollisionPlayerFion(Player a, Fion b) {
  float dx = b.x - a.x;
  float dy = b.y - a.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= a.radius + b.radius) return true;
  return false;
}

// Radial Collsion detection algorithm ICESHARD
boolean checkCollisionPlayerIceShard(Player a, IceShard b) {
  float dx = b.x - a.x;
  float dy = b.y - a.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= a.radius + b.radius) return true;
  return false;
}

// Radial Collsion detection algorithm FIRESHARD
boolean checkCollisionPlayerFireShard(Player a, FireShard b) {
  float dx = b.x - a.x;
  float dy = b.y - a.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= a.radius + b.radius) return true;
  return false;
}

// Radial Collsion detection algorithm ELECTRICSHARD
boolean checkCollisionPlayerElectricShard(Player a, ElectricShard b) {
  float dx = b.x - a.x;
  float dy = b.y - a.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= a.radius + b.radius) return true;
  return false;
}

//NORMAL ENEMY

//GUN(ADMIN)
boolean isCollidingWithBullet(Enemy e, Bullet b) {
  float distance = dist(e.x, e.y, b.x, b.y);
  float bothRadii = e.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//SWORD
boolean isCollidingWithSlash(Enemy e, Sword b) {
  float distance = dist(e.x, e.y, b.x, b.y);
  float bothRadii = e.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//ICE
boolean isCollidingWithIce(Enemy a, Ice b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  float bothRadii = b.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//FIRE
boolean isCollidingWithFire(Enemy a, Fire b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  float bothRadii = b.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//ELECTRIC
boolean isCollidingWithElectric(Enemy a, Electric b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  float bothRadii = b.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
boolean isCollidingWithUltimate(Enemy e, Ultimate b) {
  float distance = dist(e.x, e.y, b.x, b.y);
  float bothRadii = e.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}

// FION 

//GUN(ADMIN)
boolean FionCollidingWithBullet(Fion e, Bullet b) {
  float distance = dist(e.x, e.y, b.x, b.y);
  float bothRadii = e.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//SWORD
boolean FionCollidingWithSlash(Fion e, Sword b) {
  float distance = dist(e.x, e.y, b.x, b.y);
  float bothRadii = e.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//ICE
boolean FionCollidingWithIce(Fion a, Ice b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  float bothRadii = b.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//FIRE
boolean FionCollidingWithFire(Fion a, Fire b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  float bothRadii = b.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//ELECTRIC
boolean FionCollidingWithElectric(Fion a, Electric b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  float bothRadii = b.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//ULT
boolean FionCollidingWithUltimate(Fion e, Ultimate b) {
  float distance = dist(e.x, e.y, b.x, b.y);
  float bothRadii = e.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}

// EVI

//GUN(ADMIN)
boolean EviCollidingWithBullet(Evi e, Bullet b) {
  float distance = dist(e.x, e.y, b.x, b.y);
  float bothRadii = e.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//SWORD
boolean EviCollidingWithSlash(Evi e, Sword b) {
  float distance = dist(e.x, e.y, b.x, b.y);
  float bothRadii = e.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//ICE
boolean EviCollidingWithIce(Evi a, Ice b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  float bothRadii = b.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//FIRE
boolean EviCollidingWithFire(Evi a, Fire b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  float bothRadii = b.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//ELECTRIC
boolean EviCollidingWithElectric(Evi a, Electric b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  float bothRadii = b.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
boolean EviCollidingWithUltimate(Evi e, Ultimate b) {
  float distance = dist(e.x, e.y, b.x, b.y);
  float bothRadii = e.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}

// FLAIN

//GUN(ADMIN)
boolean FlainCollidingWithBullet(Flain e, Bullet b) {
  float distance = dist(e.x, e.y, b.x, b.y);
  float bothRadii = e.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
boolean FlainCollidingWithSlash(Flain e, Sword b) {
  float distance = dist(e.x, e.y, b.x, b.y);
  float bothRadii = e.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//ICE
boolean FlainCollidingWithIce(Flain a, Ice b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  float bothRadii = b.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//FIRE
boolean FlainCollidingWithFire(Flain a, Fire b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  float bothRadii = b.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
//ELECTRIC
boolean FlainCollidingWithElectric(Flain a, Electric b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  float bothRadii = b.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}
boolean FlainCollidingWithUltimate(Flain e, Ultimate b) {
  float distance = dist(e.x, e.y, b.x, b.y);
  float bothRadii = e.radius + b.radius;

  if (bothRadii > distance) return true;
  return false;
}


void mousePressed() {
  if (mouseButton == LEFT) {
    //Bullet b = new Bullet(player.x, player.y);
    //bullets.add(b);
    leftMouse = true;
  }
}

void mouseReleased() {
  leftMouse = false;
}


void keyPressed() { 
  //println(keyCode);
  if (keyCode == 65) aKey = true;
  if (keyCode == 68) dKey = true;
  if (keyCode == 83) sKey = true;
  if (keyCode == 87) wKey = true;
  if (keyCode == 10) keyEnter = true;
  if (keyCode == 27) keyEsc = true;
  if (keyCode == 16) shiftPressed = true;
  if (keyCode == 32) spacePressed = true;
}

void keyReleased() {
  if (keyCode == 65) aKey = false;
  if (keyCode == 68) dKey = false;
  if (keyCode == 83) sKey = false;
  if (keyCode == 87) wKey = false;
  if (keyCode == 10) keyEnter = false;
  if (keyCode == 27) keyEsc = false;
  if (keyCode == 16) shiftPressed = false;
  if (keyCode == 32) spacePressed = false;
}

void calcDeltaTime() {
  float currTime = millis();
  dt = (currTime - prevTime) / 1000.0;
  prevTime = currTime;
}
