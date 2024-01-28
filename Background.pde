class Background {
  PImage background;
  
  HashMap<String, PImage> backgroundHashMap;

  int tintAmount;
  Background() {
    background = loadImage("images/backgrounds/parchment.png");
    background.resize(width, height);
    backgroundHashMap = new HashMap<String, PImage>();
    backgroundHashMap.put("parchment", background);
  }
  
  void load(String backgroundName){
    background = loadImage("images/backgrounds/" + backgroundName + ".png");
    background.resize(width, height);
    
    backgroundHashMap.put(backgroundName, background);
  }

  void SetUnderlyingBackground(String backgroundName){
    background = backgroundHashMap.get(backgroundName);
  }


  void SetBackground(String backgroundName, boolean parse) {
    SetUnderlyingBackground(backgroundName);

    if (parse) {
      parser.Parse();
    }
  }

  void SetBackground(String backgroundName) {
    SetBackground(backgroundName, true);
  }

  void SetSlowBackground(String backgroundName) {
    SetBackground(backgroundName, false);
  }

  void DrawBackground() {
    backgroundGraphics.imageMode(CORNER);
    backgroundGraphics.tint(255);
    backgroundGraphics.image(background, 0, 0);
  } //<>//
}
