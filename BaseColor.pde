class Color {
  color data;
  Color(int r, int g, int b) {
    this.data = color(r, g, b);
  }
}

class BaseColor {
  HashMap<String, Color> Map = new HashMap<String, Color>();

  BaseColor() {
    Map.put("grog", new Color(229, 167, 125));
    Map.put("vex", new Color(220, 220, 220));
    Map.put("trinket", new Color(220, 220, 220));
    Map.put("keyleth", new Color(162, 175, 64));
    Map.put("percy", new Color(132, 197, 198));
    Map.put("scanlan", new Color(175, 43, 193));
    Map.put("vax", new Color(160, 134, 203));
    Map.put("pike", new Color(252, 190, 3));
    
    Map.put("carver", new Color(33, 103, 28));
    Map.put("carver1", new Color(33, 103, 28));
    Map.put("carver2", new Color(33, 103, 28));
    Map.put("carver3", new Color(33, 103, 28));
    Map.put("dwarfman4", new Color(33, 103, 28));
    Map.put("dwarfman3", new Color(33, 103, 28));
    Map.put("dwarfman2", new Color(33, 103, 28));
    Map.put("kima_hidden", new Color(33, 103, 28));
    
    Map.put("clarota", new Color(9, 0, 179));
    Map.put("ogre_dead", new Color(0, 0, 0));
    
    Map.put("kima", new Color(250, 153, 25));
  }

  Color Get(String name, String tokenName) {
    if (Map.containsKey(tokenName)) {
      return  Map.get(tokenName);
    }
    if (Map.containsKey(name)) {
      return  Map.get(name);
    }
    return new Color(200, 0, 0);
  }
}
