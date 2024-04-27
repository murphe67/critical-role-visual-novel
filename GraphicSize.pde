class GraphicSize {
  HashMap<String, Float> Map = new HashMap<String, Float>();

  GraphicSize() {
    Map.put("turn", 1.0);
    Map.put("thunderwave", 2.0);
    Map.put("magic", 1.5);
    Map.put("stinking_cloud", 8.5);
    Map.put("hammer", 0.7);
    Map.put("bad", 1.0);
    Map.put("explosion", 4.0);
    Map.put("thornwhip", 1.0);
    Map.put("claws", 0.5);
    Map.put("unconscious", -0.3);
    Map.put("dagger", -0.15);
}

  float Get(String name) {
    if (Map.containsKey(name)) {
      return Map.get(name);
    }
    return 0;
  }
}
