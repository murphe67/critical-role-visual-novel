static class CharacterHeights {

  static HashMap<String, Float> Map = new HashMap<String, Float>();

  static void Initialise() {

    Map.put("grog", 8.75);
    Map.put("vex", 5.75);
    Map.put("vax", 5.7);
    Map.put("pike", 3.5);
    Map.put("scanlan", 3.4);
    Map.put("scanlan_inv", 3.4);
    Map.put("keyleth", 6.0);
    Map.put("percy", 5.8);
    Map.put("percymask", 5.8);
    Map.put("matt", 6.0);
    Map.put("kraghammercarver", 4.0);
    Map.put("dwarf1", 4.0);
    Map.put("dwarf2", 3.9);
    Map.put("dwarf3", 4.2);
    Map.put("dwarf4", 4.0);
    Map.put("balgus", 4.0);
    Map.put("bear", 4.5);
    Map.put("cavebear", 4.5);
    Map.put("nostoc", 4.0);
    Map.put("steddos", 4.3);
    Map.put("clarota", 8.5);
    Map.put("panther", 3.5);
    Map.put("eagle", 8.0);
    Map.put("earthelemental", 11.0);
    Map.put("airelemental", 11.0);
    Map.put("duergargeneral", 4.0);
    Map.put("mindflayer", 8.5);
    Map.put("kima", 3.8);
    Map.put("ulara", 4.0);
    Map.put("kvarn", 11.0);
    Map.put("formorian", 11.0);
    Map.put("formorianfull", 20.0);
    Map.put("cloaker", 10.0);
    Map.put("cloaker3", 10.0);
    Map.put("cloaker2", 10.0);
    Map.put("bigby", 11.0);
    Map.put("cordell", 6.7);
    Map.put("erwen", 3.7);
    Map.put("allura", 5.25);
    Map.put("uriel", 6.5);
    Map.put("riskel", 6.0);
    Map.put("asum", 3.5);
    Map.put("tofor", 8.0);
    Map.put("bromgoldhand", 6.3);
    Map.put("gilmore", 6.0);
    Map.put("sherri", 5.0);
    Map.put("damon", 5.9);
    Map.put("wyvern", 11.0);
    Map.put("teera", 3.5);
    Map.put("bastionguard", 5.9);
    Map.put("platguard", 6.2);
    Map.put("blueacolyte", 5.6);
    Map.put("vord", 6.6);
    Map.put("yonn", 5.1);
    Map.put("platgolem", 11.0);
    Map.put("minxie", 3.5);
    Map.put("human4", 6.1);
    Map.put("human8", 6.0);
    Map.put("human7", 6.0);
    Map.put("aldor", 5.9);
    Map.put("tieflingbarbarian", 6.4);
    Map.put("mertin", 4.0);
    Map.put("vanessa", 6.3);
    Map.put("kern", 6.5);
    Map.put("zahra", 6.0);
    Map.put("lyra", 4.9);
    Map.put("orcbandit", 6.4);
    Map.put("frostgianttorso", 11.0);
    Map.put("frostgiant", 15.0);
    Map.put("rimefang", 20.0);
    Map.put("aldorSmall", 3.8);
    Map.put("blonde_gold_dress", 5.4);
    Map.put("gold_hag", 7.1);
    Map.put("kashaw", 6.4);
    Map.put("thorbir", 4.2);
    Map.put("dragonborn_bouncer", 7.0);
    Map.put("hosin", 4.0);
    Map.put("chained_woman", 4.9);
    Map.put("vince", 5.9);
    Map.put("otyugh", 10.0);
    Map.put("hotis", 6.0);
    Map.put("osysa", 12.0);
    Map.put("cerkonos", 7.5);
    Map.put("waterelemental", 11.0);
    Map.put("groon", 5.2);
    Map.put("kynan", 5.6);
    Map.put("samson", 6.4);
    Map.put("kordstatue", 11.5);
    Map.put("delilah", 5.2);
    Map.put("sylas", 6.6);
    Map.put("desmond", 5.8);
    Map.put("gesyra", 5.3);
  }

  static float Get(String name) {
    if (Map.containsKey(name)) {
      return  Map.get(name);
    }
    return 6;
  }
}
