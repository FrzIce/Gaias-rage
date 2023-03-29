class IceShard {
  
  //Declare
  float x;
  float y;
  int radius;
  boolean isDropped = false;
  boolean playerOn = false;
  PImage shard;
  float shardHeight;
  float shardWidth;
  
  
  IceShard(float xPos, float yPos) {
    x = xPos;
    y = yPos;
    shard = loadImage("iceShard.png");
    shardWidth = shard.width;
    shardHeight = shard.height;
  }
  
  void update() {
    if(playerOn == true) isDropped = false;
  }
  
  void draw() {
    if(isDropped == true) image(shard, x, y, shardWidth, shardHeight);
  
  }
}
