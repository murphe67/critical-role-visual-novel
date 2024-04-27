class Map {
  boolean showMap = false;
  String battle;

  PImage map;
  int battleImage;

  boolean drawBattle = false;

  void SetBattle(String battle) {
    this.battle = battle;
    println(this.battle);
    battleImage = 0; //<>// //<>// //<>//
  }

  void UpdateBattle() {
    battleImage++;
    backgroundTintDelta = 12;
    updateBackground = true;
    drawBattle = true;
    
    map = loadImage("images/battles/" + this.battle + "/" + battleImage + ".png");
    map.resize(width, height);
  }

  void SetBattleNumber(String battle, int number) {
    battleImage = number;
    this.battle = battle;

    updateBackground = true;
    drawBattle = true;

    map = loadImage("images/battles/" + battle + "/" + battleImage + ".png");
    map.resize(width, height);
  }


  void EndBattle() {
    updateBackground = true;
    backgroundTintDelta = 12;
    drawBattle = false;
  }

  void DrawMap() {
    if(drawBattle){
      backgroundGraphics.imageMode(CORNER);
      backgroundGraphics.tint(255);
      backgroundGraphics.image(map, 0, 0);
    } //<>// //<>// //<>//
  }
}
