class CharacterDisplay {
  int numCentres = 1;

  float leftX;
  float regionWidth;

  float centrePosition;
  float indexWidth;

  HashMap<String, CharacterBust> characterBusts = new HashMap<String, CharacterBust>();
  ArrayList<CharacterBust> displayedCharacterBusts = new ArrayList<CharacterBust>();

  HashMap<String, String> changedArt = new HashMap<String, String>();

  CharacterDisplay() {
    regionWidth = width * 0.75;
    leftX = width * 0.12;

    centrePosition = leftX + (regionWidth/2);
    indexWidth = (regionWidth/16);

    String lines[] = loadStrings("episodes/" + folderToRead + "/main.txt");
    for (int i=0; i<lines.length; i++) {
      String args[] = split(lines[i], " ");
      if (args[0].equals("-show") || args[0].equals("-slowshow")) {
        characterBusts.put(args[1], new CharacterBust(args[1]));
      }
    }
  }

  void changeArt(String character, String artName) {
    characterBusts.get(character).setArt(artName);
    changedArt.put(character, artName);
  }

  void scaleHeights(float heightScale) {
    for (CharacterBust bust : characterBusts.values()) {
      bust.setSize(heightScale);
    }
  }

  void Show(String character, float index) {
    CharacterBust bust = characterBusts.get(character);

    bust.SetPosition(centrePosition + (index * indexWidth));
    displayedCharacterBusts.add(bust);
  }

  void Refresh(String character) {
    CharacterBust bust = characterBusts.get(character);
    displayedCharacterBusts.remove(bust);
    displayedCharacterBusts.add(bust);
  }

  void ShowAnother(String character, float index) {
    CharacterBust bust = characterBusts.get(character);

    bust.AddAnotherPosition(centrePosition + (index * indexWidth));
  }

  void Hide(String character) {
    CharacterBust bust = characterBusts.get(character);
    displayedCharacterBusts.remove(bust);
  }

  void HideAll() {
    displayedCharacterBusts = new ArrayList<CharacterBust>();
  }

  void Run() {
    for (CharacterBust bust : displayedCharacterBusts) {
      bust.Display(backgroundGraphics);
    }
  }

  void Transition() {
    if (globalSkipText) {
      screenshot = true;
    }
    updateBackground = true;
  }
}
