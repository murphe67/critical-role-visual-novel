class SceneData {
  String name = "";
  String background = "";
  String music = "";
  int realScene;

  int index;

  boolean showBattleMap;
  String battle;
  int battleNumber;

  ArrayList<CharacterBust> characters;
  HashMap<CharacterBust, ArrayList<Float>> characterPositions = new HashMap<CharacterBust, ArrayList<Float>>();

  boolean showSpeaker;
  String speaker;

  HashMap<String, String> changedArt;
  float heightScale;

  SceneData() {
  }

  SceneData(SceneData data) {
    background = data.background;
    music = data.music;
  }

  void SetCharacters(ArrayList<CharacterBust> characters) {
    this.characters = (ArrayList<CharacterBust>)characters.clone();
    for (CharacterBust character : characters) {
      characterPositions.put(character, (ArrayList<Float>)character.xPositions.clone());
    }
  }

  void GetCharacters() {
    characterDisplay.displayedCharacterBusts = (ArrayList<CharacterBust>)characters.clone();
    for (CharacterBust character : characters) {
      character.SetPositions(characterPositions.get(character));
    }
    for (String character : changedArt.keySet()) {
      characterDisplay.changeArt(character, changedArt.get(character));
    }
  }
}
