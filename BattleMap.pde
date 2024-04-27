import java.util.LinkedHashMap;

class Line {
  int startX, startY, endX, endY;
  String character, colorBase;

  Line(String character, String colorBase, int startX, int startY, int endX, int endY) {
    this.character = character;
    this.colorBase = colorBase;
    this.startX = startX;
    this.startY = startY;
    this.endX = endX;
    this.endY = endY;
  }
}
class BattleMap {
  boolean showMap = false;
  String battle;

  PImage map;
  PImage mapShadow;
  int battleImage;

  int numRows;
  int numColumns;

  boolean drawBattle = false;
  LinkedHashMap<String, PImage> battleMapHashMap = new LinkedHashMap<String, PImage>();
  LinkedHashMap<String, BattleToken> tokenMap = new LinkedHashMap<String, BattleToken>();
  LinkedHashMap<String, BattleGraphic> behindGraphicMap = new LinkedHashMap<String, BattleGraphic>();
  LinkedHashMap<String, BattleGraphic> infrontGraphicMap = new LinkedHashMap<String, BattleGraphic>();
  ArrayList<Line> lines = new ArrayList<Line>();

  int xCentre = width/2;
  int yCentre = int(375 * heightScaling);

  float mapHeight = int(700 * heightScaling);

  int squareWidth;

  BattleMap() {
    mapShadow = loadImage("images/token shadow.png");
  }

  void load(String battle) {
    map = loadImage("images/battles/" + battle + ".png");
    map.resize(0, int(mapHeight));
    battleMapHashMap.put(battle, map);
  }

  void SetBattleMap(String battle, int numRows, int numColumns) {
    this.battle = battle;
    map = battleMapHashMap.get(battle);
    this.numRows = numRows;
    this.numColumns = numColumns;
    drawBattle = true;
    mapShadow.resize(int(map.width * 1.8), int(map.height * 1.2));
    squareWidth = int(float(map.width) / numColumns);
  }

  void AddToken(String tokenName, String name, String imageName, float xIndex, float yIndex) {
    BattleToken token = new BattleToken(tokenName, name, imageName, indexToWidth(xIndex), indexToHeight(yIndex), int(squareWidth));
    tokenMap.put(tokenName, token);
  }
  
  void ReAddToken(String tokenName, String name, String imageName, int xPos, int yPos) {
    BattleToken token = new BattleToken(tokenName, name, imageName, xPos, yPos, int(squareWidth));
    tokenMap.put(tokenName, token);
  }

  int indexToHeight(float yIndex) {
    float yEdge = yCentre - (map.height / 2);
    float yUnit = float(map.height) / numRows;
    return int(yEdge + (yIndex * yUnit) + (yUnit * 0.85));
  }

  int indexToWidth(float xIndex) {
    float xEdge = xCentre - (map.width / 2);
    float xUnit = float(map.width) / numColumns;
    return int(xEdge + (xIndex * xUnit) + (xUnit/2));
  }

  void AddGraphicOn(String graphicName, String imageName, String placement, String addShadow, String characterOn, String characterFrom) {
    color characterColor = baseColor.Get(characterFrom, "").data;
    BattleGraphic graphic = new BattleGraphic(imageName, addShadow, characterOn, characterColor, squareWidth);
    if (placement.equals("behind")) {
      behindGraphicMap.put(graphicName, graphic);
    } else {
      infrontGraphicMap.put(graphicName, graphic);
    }
  }
  
  void AddGraphic(String graphicName, String imageName, String placement, String addShadow, String characterFrom, float xIndex, float yIndex) {
    color characterColor = baseColor.Get(characterFrom, "").data;
    int xPos = indexToWidth(xIndex);
    int yPos = indexToHeight(yIndex);
    BattleGraphic graphic = new BattleGraphic(imageName, addShadow, characterColor, squareWidth, xPos, yPos);
    if (placement.equals("behind")) {
      behindGraphicMap.put(graphicName, graphic);
    } else {
      infrontGraphicMap.put(graphicName, graphic);
    }
  }

  void RemoveGraphic(String graphicName) {
    behindGraphicMap.remove(graphicName);
    infrontGraphicMap.remove(graphicName);
  }
  
  void RemoveAllGraphics(){
    behindGraphicMap = new LinkedHashMap<String, BattleGraphic>();
    infrontGraphicMap = new LinkedHashMap<String, BattleGraphic>();
  }
  void RemoveToken(String tokenName) {
    tokenMap.remove(tokenName);
  }
  void RefreshToken(String tokenName) {
    BattleToken token = tokenMap.get(tokenName);
    tokenMap.remove(tokenName);
    tokenMap.put(tokenName, token);
  }
  
  void SetProne(String tokenName, boolean prone){
    BattleToken token = tokenMap.get(tokenName);
    token.prone = prone;
  }
  
  void SetShadow(String tokenName, boolean shadow){
    BattleToken token = tokenMap.get(tokenName);
    token.shadow = shadow;
  }

  void MoveToken(String tokenName, float xDelta, float yDelta, String colorBase) {
    println(tokenName);
    BattleToken token = tokenMap.get(tokenName);
    int startX = token.xPos;
    int startY = token.yPos;
    token.xPos += squareWidth * xDelta;
    token.yPos += squareWidth * yDelta;
    int endX = token.xPos;
    int endY = token.yPos;
    lines.add(new Line(tokenName, colorBase, startX, startY, endX, endY));
  }

  void UpdateBattle() {
    if (globalSkipText) {
      screenshot = true;
    }
    updateBackground = true;
  }

  void PauseBattle(){
    drawBattle = false;
  }

  void EndBattle() {
    drawBattle = false;
    behindGraphicMap = new LinkedHashMap<String, BattleGraphic>();
    infrontGraphicMap = new LinkedHashMap<String, BattleGraphic>();
    tokenMap = new LinkedHashMap<String, BattleToken>();
    lines = new ArrayList<Line>();
  }

  void DrawMap() {
    if (drawBattle) {
      backgroundGraphics.imageMode(CENTER);
      backgroundGraphics.tint(255, 255);
      backgroundGraphics.image(mapShadow, xCentre, yCentre);

      backgroundGraphics.image(map, xCentre, yCentre);

      if (globalSkipText) {
        backgroundGraphics.fill(255, 255);
        backgroundGraphics.textSize(12);
        backgroundGraphics.textAlign(CENTER);
        for (int i=0; i<numRows; i++) {
          for (int j=0; j<numColumns; j++) {

            backgroundGraphics.text(j + " " + i, indexToWidth(j), indexToHeight(i));
          }
        }
      }

      for (Line lineToDraw : lines){
        backgroundGraphics.stroke(baseColor.Get(lineToDraw.colorBase, "").data, 255);
        backgroundGraphics.strokeWeight(8 * widthScaling);
        backgroundGraphics.line(lineToDraw.startX, lineToDraw.startY, lineToDraw.endX, lineToDraw.endY);
        backgroundGraphics.stroke(0, 255);
      }

      lines = new ArrayList<Line>();

      for (BattleGraphic graphic : behindGraphicMap.values()) {
        graphic.Show();
      }

      for (BattleToken token : tokenMap.values()) {
        token.Show();
      }

      for (BattleGraphic graphic : infrontGraphicMap.values()) {
        graphic.Show();
      }
    }
  }
}
