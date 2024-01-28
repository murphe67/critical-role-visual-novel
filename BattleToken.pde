class BattleToken {
  PImage tokenImage;
  int xPos, yPos;
  float tokenHeight;
  
  BattleToken(PImage image, int xPos, int yPos, float tokenHeight) {
    tokenImage = image;
    this.xPos = xPos;
    this.yPos = yPos;
    this.tokenHeight = tokenHeight;
  }
}
