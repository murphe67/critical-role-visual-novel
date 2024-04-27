class BattleToken {
  PImage tokenImage;
  int xPos, yPos;
  PImage tokenShadow;
  int baseWidth;
  int baseHeight;
  int tokenOffset;
  int tokenYOffset;
  color tokenBaseColor;
  String tokenName;
  String name;
  String imageName;
  boolean prone = false;
  boolean shadow = true;
 
  BattleToken(String tokenName, String name, String imageName, int xPos, int yPos, int squareWidth) {
    this.tokenName = tokenName;
    this.xPos = xPos;

    
    this.name = name;
    this.imageName = imageName;
    
    tokenImage = loadImage("images/characters/" + imageName + ".png");
    
    int tokenHeight = int((CharacterHeights.Get(name) / 5.0) * squareWidth);
    tokenImage.resize(0, tokenHeight);
    this.yPos = yPos - (tokenImage.height/2);
    
    tokenShadow = loadImage("images/token shadow2.png");
    tokenShadow.resize(int(tokenImage.width + (squareWidth * 0.4)), int(tokenImage.height * 1.4));
    baseWidth = int(squareWidth * BaseWidths.Get(name));
    baseHeight = int(baseWidth * 0.4);
    tokenOffset = int(TokenOffset.GetX(name) * squareWidth);
    tokenYOffset = int(TokenOffset.GetY(name) * squareWidth);
    tokenBaseColor = baseColor.Get(name, tokenName).data;
  }
  
  int getInputYPos(){
    return yPos +(tokenImage.height/2);
  }

  void Show() {
    backgroundGraphics.fill(tokenBaseColor);
    backgroundGraphics.strokeWeight(3.5 * widthScaling);
    backgroundGraphics.ellipse(xPos, yPos + (tokenImage.height/2) - (baseHeight*0.1), baseWidth, baseHeight);
    
    if(!(prone || !shadow)){
      backgroundGraphics.imageMode(CENTER);
      backgroundGraphics.tint(255, 100);
      backgroundGraphics.image(tokenShadow, xPos + tokenOffset, yPos - (5 * heightScaling) + tokenYOffset);
    }

    
    backgroundGraphics.tint(255, 255);
    backgroundGraphics.fill(255, 255);
    if(!prone){
      backgroundGraphics.image(tokenImage, xPos+tokenOffset, yPos+tokenYOffset);
    } else{
       backgroundGraphics.pushMatrix();
       backgroundGraphics.translate(xPos + (baseWidth * 0.1), yPos + (tokenImage.height*0.35) - (baseHeight*0.1));
       backgroundGraphics.rotate(PI/2);
       backgroundGraphics.image(tokenImage, 0, 0);
       backgroundGraphics.popMatrix();
    }
    
    if(globalSkipText){
      backgroundGraphics.fill(255, 255);
      backgroundGraphics.textSize(12);
      backgroundGraphics.text(tokenName, xPos, yPos + (tokenImage.width*0.8));
    }
  }
}
