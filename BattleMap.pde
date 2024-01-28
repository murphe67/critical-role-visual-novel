class BattleMap {
  boolean showMap = false;
  String battle;

  PImage map;
  PImage mapShadow;
  int battleImage;

  int numRows;
  int numColumns;

  boolean drawBattle = false;
  HashMap<String, PImage> battleMapHashMap;
  HashMap<String, BattleToken> tokenMap;


  int xCentre = width/2;
  int yCentre = int(375 * heightScaling);

  int mapHeight = int(650 * heightScaling);

  BattleMap() {
    mapShadow = loadImage("images/map shadow.png");
    mapShadow.resize(width, height);

    battleMapHashMap = new HashMap<String, PImage>();
    tokenMap = new HashMap<String, BattleToken>();
  }

  void load(String battle) {
    map = loadImage("images/battles/" + battle + ".png");
    map.resize(0, mapHeight);
    battleMapHashMap.put(battle, map);
  }

  void SetBattleMap(String battle, int numRows, int numColumns) {
    map = battleMapHashMap.get(battle);
    this.numRows = numRows;
    this.numColumns = numColumns;
    drawBattle = true;
  }

  void AddToken(String name, String tokenName, int xPos, int yPos) {
    PImage tokenImage = loadImage("images/characters/" + tokenName + ".png");

    float tokenHeight = CharacterHeights.Get(name);
    BattleToken token = new BattleToken(tokenImage, xPos, yPos, tokenHeight);
    tokenMap.put(name, token);
  }

  void UpdateBattle() {
    updateBackground = true;
  }

  void SetBattleNumber(String proxy, int proxy2) {
  }

  void EndBattle() {
    drawBattle = false;
  }

  void DrawMap() {
    if (drawBattle) {
      backgroundGraphics.imageMode(CORNER);
      backgroundGraphics.tint(255);
      backgroundGraphics.image(mapShadow, 0, 0);

      backgroundGraphics.imageMode(CENTER);
      backgroundGraphics.image(map, xCentre, yCentre);
    }
  }
}
