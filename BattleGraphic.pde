class BattleGraphic {
  PImage graphicImage;
  PImage shadow;
  BattleToken token;
  color characterColor;
  boolean drawShadow = false;

  String characterOn;

  int xPos, yPos;

  BattleGraphic(String imageName, String addShadow, String characterOn, color characterColor, int squareWidth) {
    graphicImage = loadImage("images/graphics/" + imageName + ".png");
    shadow = loadImage("images/token shadow2.png");
    float graphicMultiplier = graphicSize.Get(imageName);
    
    token = map.tokenMap.get(characterOn);
    
    println(token.baseWidth);
    float baseWidth = ((((token.baseWidth / float(squareWidth)) - 1) * 0.8) + 1.4) * squareWidth;
    println(baseWidth);


    int myGraphicSize = int(baseWidth + (graphicMultiplier * squareWidth));

    println(myGraphicSize);
    graphicImage.resize(0, myGraphicSize);
    shadow.resize(0, int(myGraphicSize * 1.4));
    
    this.characterColor = characterColor;

    this.characterOn = characterOn;

    if (addShadow.equals("shadow")) {
      drawShadow = true;
    }
  }

  BattleGraphic(String imageName, String addShadow, color characterColor, int squareWidth, int xPos, int yPos) {
    graphicImage = loadImage("images/graphics/" + imageName + ".png");
    shadow = loadImage("images/token shadow2.png");
    float graphicMultiplier = graphicSize.Get(imageName);
    int myGraphicSize = int(1.5 + (graphicMultiplier * squareWidth));
    graphicImage.resize(0, myGraphicSize);
    shadow.resize(0, int(1.5 + ((graphicMultiplier + 0.4) * squareWidth)));

    this.characterColor = characterColor;

    this.xPos = xPos;
    this.yPos = yPos;

    if (addShadow.equals("shadow")) {
      drawShadow = true;
    }
  }

  void RefreshToken() {
    if (token != null) {
      token = map.tokenMap.get(characterOn);
    }
  }

  void Show() {
    backgroundGraphics.imageMode(CENTER);
    if (token != null) {
      xPos = token.xPos;
      yPos = token.yPos;
    }
    if (drawShadow) {
      backgroundGraphics.tint(255, 130);
      backgroundGraphics.image(shadow, xPos, yPos);
    }

    backgroundGraphics.tint(characterColor, 255);
    backgroundGraphics.image(graphicImage, xPos, yPos);
  }
}
