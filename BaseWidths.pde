static class BaseWidths {

  static HashMap<String, Float> Map = new HashMap<String, Float>();

  static void Initialise() {
    Map.put("grog", 1.2);
    Map.put("trinket", 1.9);
    Map.put("trinket2", 1.9);
    Map.put("cavebear", 1.9);
    Map.put("ogre", 2.3);
    Map.put("naga", 2.6);
    Map.put("gianteagle", 2.0);
    Map.put("umberhulk", 2.2);
    Map.put("snail", 0.8);
    Map.put("mindflayer", 1.5);
    Map.put("bulette", 3.6);
    Map.put("rhino", 2.5);
    Map.put("ooze", 2.5);
    Map.put("hook_horror", 2.5);
    Map.put("minxie", 2.2);
  }

  static float Get(String name) {
    if (Map.containsKey(name)) {
      return  Map.get(name);
    }
    return 1;
  }
}
