class BattleTokenSaver{
  String tokenName;
  String name;
  String imageName;
  int xPos;
  int yPos;
  boolean prone;
  boolean shadow;
  
  BattleTokenSaver(BattleToken token){
    tokenName = token.tokenName;
    name = token.name;
    xPos = token.xPos;
    yPos = token.getInputYPos();
    imageName = token.imageName;
    prone = token.prone;
    shadow = token.shadow;
  }
}
