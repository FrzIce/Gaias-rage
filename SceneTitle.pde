// this class defines a "Title" scene
class SceneTitle {
  PImage title;

  SceneTitle() {
    title = loadImage("GR Title.png");
  }
  void update() {
    if (keyEnter) {
      switchToPlay();
    }
    if (keyEsc) exit();
  }
  void draw() {
    image(title, 0, 0);
    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Press ENTER to start the onslaught!", width/2, height/2);
  }
  void mousePressed() {
  }
}
