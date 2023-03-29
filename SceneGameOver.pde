// this class defines a "Game Over" scene
class SceneGameOver {
  SceneGameOver() {
  }
  void update() {
    if (leftMouse) switchToTitle();
    if (keyEsc) exit();
  }
  void draw() {
    background(200, 0, 200);
    textSize(40);
    fill(0);
    textAlign(CENTER, TOP);
    text("Click to return to the main menu", width/2, 20);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width/2, height/2);
    text("Your score was " + score, width/2, height/2 - 40);
  }
}
