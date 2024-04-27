static class TokenOffset {

  static HashMap<String, Float> XMap = new HashMap<String, Float>();
  static HashMap<String, Float> YMap = new HashMap<String, Float>();


  static void Initialise() {
    XMap.put("percy", -0.05);
    XMap.put("trinket", -0.05);
    XMap.put("trinket2", 0.05);
    XMap.put("vex", -0.02);
    XMap.put("naga", 0.1);
    YMap.put("umberhulk", 0.3);
    YMap.put("bulette", 0.3);
    XMap.put("bulette", -0.5);
    XMap.put("rhino", -0.7);
    YMap.put("rhino", 0.2);
    XMap.put("hook_horror", -0.2);
    YMap.put("hook_horror", 0.2);
    XMap.put("gianteagle", 0.1);
    YMap.put("gianteagle", -0.1);
    XMap.put("minxie", -0.25);
    YMap.put("minxie", 0.2);
  }

  static float GetX(String name) {
    if (XMap.containsKey(name)) {
      return XMap.get(name);
    }
    return 0;
  }
  
  static float GetY(String name) {
    if (YMap.containsKey(name)) {
      return YMap.get(name);
    }
    return 0;
  }
}
