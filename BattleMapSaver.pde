import java.util.Map;

class BattleMapSaver {
  String battle;
  int numRows, numColumns;
  ArrayList<BattleTokenSaver> tokenSavers = new ArrayList<BattleTokenSaver>();

  LinkedHashMap<String, BattleGraphic> behindGraphicMap;
  LinkedHashMap<String, BattleGraphic> infrontGraphicMap;
  ArrayList<Line> lines;

  boolean drawBattle;

  BattleMapSaver(BattleMap map) {
    battle = map.battle;
    numRows = map.numRows;
    numColumns = map.numColumns;

    drawBattle = map.drawBattle;

    for (BattleToken token : map.tokenMap.values()) {
      tokenSavers.add(new BattleTokenSaver(token));
    }

    behindGraphicMap = new LinkedHashMap<String, BattleGraphic>(map.behindGraphicMap);
    infrontGraphicMap = new LinkedHashMap<String, BattleGraphic>(map.infrontGraphicMap);
    lines = new ArrayList<Line>(map.lines);
  }

  void update(BattleMap map) {
    if (drawBattle) {
      map.SetBattleMap(battle, numRows, numColumns);

      map.lines = new ArrayList<Line>(lines);

      map.tokenMap = new LinkedHashMap<String, BattleToken>();

      for (BattleTokenSaver saver : tokenSavers) {
        map.ReAddToken(saver.tokenName, saver.name, saver.imageName, saver.xPos, saver.yPos);
        map.SetProne(saver.tokenName, saver.prone);
        map.SetShadow(saver.tokenName, saver.shadow);
      }

      for (BattleGraphic graphic : behindGraphicMap.values()) {
        graphic.RefreshToken();
      }

      for (BattleGraphic graphic : infrontGraphicMap.values()) {
        graphic.RefreshToken();
      }

      map.behindGraphicMap = new LinkedHashMap<String, BattleGraphic>(behindGraphicMap);
      map.infrontGraphicMap = new LinkedHashMap<String, BattleGraphic>(infrontGraphicMap);

      map.UpdateBattle();
    } else {
      map.EndBattle();
    }
  }
}
