class FireShard {
  
  //Declare
  float x;
  float y;
  int radius;
  boolean isDropped = false;
  boolean playerOn = false;
  PImage shard;
  float shardHeight;
  float shardWidth;
  
  FireShard(float xPos, float yPos) {
    x = xPos;
    y = yPos;
    shard = loadImage("fireShard.png");
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
