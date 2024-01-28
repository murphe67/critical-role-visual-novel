class Scene {

  HashMap<Integer, SceneData> scenes = new HashMap<Integer, SceneData>();
  HashMap<Integer, SceneData> secretScenes = new HashMap<Integer, SceneData>();
  HashMap<Integer, Integer> secretScenesNumbers = new HashMap<Integer, Integer>();

  int lastScene;
  int lastSecretScene;

  String lines[];
  int index;

  String scene;
  SceneData data = new SceneData();

  SceneData secretData = new SceneData();
  SceneData sceneToChangeTo;

  int currentScene;
  int currentSecretScene;
  int nextSecretScene;


  boolean changeScene;

  PFont font;

  int secretScenePer = 10;

  PImage backgroundImage;
  
  int textX = int(width * 0.08);
  int textY = int(height * 0.12);
  int textWidth = int(width * 0.15);
  int textHeight = int(height * 0.2);


  Scene() {
    font = createFont("fonts/maragsa display.otf", 30 * widthScaling);
    backgroundImage = loadImage("images/scene background.png");
    backgroundImage.resize(width, height);

    lines = loadStrings("episodes/" + folderToRead + "/main.txt");
    TrimLines();
    index = 0;

    currentScene = 0;
    currentSecretScene = 0;

    boolean showBattleMap = false;
    String battle = "";
    int battleNumber = 0;

    boolean showSpeaker = false;
    String speaker = "";
    String lastSpeaker = "";

    float heightScale = 1;

    while (index < lines.length) {
      String line = lines[index];

      secretScenesNumbers.put(index, currentSecretScene);

      if (nextSecretScene == 0) {
        while (input.PeakLine(nextSecretScene).charAt(0) != '-' || nextSecretScene < secretScenePer) {
          nextSecretScene++;
        }
      }
      if (index == nextSecretScene) {
        secretData.index = index;
        secretData.SetCharacters(characterDisplay.displayedCharacterBusts);
        secretData.realScene = currentScene-1;
        secretData.battle = battle;
        secretData.showBattleMap = showBattleMap;
        secretData.battleNumber = battleNumber;
        secretData.heightScale = heightScale;
        secretData.showSpeaker = showSpeaker;
        secretData.speaker = speaker;
        secretData.changedArt = new HashMap<String, String>(characterDisplay.changedArt);
        secretScenes.put(currentSecretScene, secretData);
        currentSecretScene++;

        SceneData newData = new SceneData(secretData);
        secretData = newData;

        while (input.PeakLine(nextSecretScene).charAt(0) != '-' || nextSecretScene < index + secretScenePer) {
          nextSecretScene++;

          if (nextSecretScene == lines.length) {
            break;
          }
        }
      }

      String args[] = split(line, " ");
      if (args[0].equals("-scene")) {
        scene = "";
        for (int i=1; i<args.length; i++) {
          scene += args[i] + " ";
        }
        data.index = index + 1;
        data.SetCharacters(characterDisplay.displayedCharacterBusts);
        data.name = scene;

        data.battle = battle;
        data.showBattleMap = showBattleMap;
        data.battleNumber = battleNumber;
        data.heightScale = heightScale;

        data.showSpeaker = showSpeaker;
        data.speaker = speaker;
        data.changedArt = new HashMap<String, String>(characterDisplay.changedArt); 

        scenes.put(currentScene, data);
        currentScene++;

        SceneData newData = new SceneData(data);
        data = newData;
      } else if (args[0].equals("-background")) {
        background.load(args[1]);
        data.background = args[1];
        secretData.background = args[1];
      } else if (args[0].equals("-slowbackground")) {
        background.load(args[1]);
        data.background = args[1];
        secretData.background = args[1];
      } else if (args[0].equals("-music")) {
        data.music = args[1];
        secretData.music = args[1];
      } else if (args[0].equals("-show")) {
        characterDisplay.Show(args[1], int(args[2]));
      } else if (args[0].equals("-showanother")) {
        characterDisplay.ShowAnother(args[1], int(args[2]));
      } else if (args[0].equals("-hide")) {
        characterDisplay.Hide(args[1]);
      } else if (args[0].equals("-refresh")) {
        characterDisplay.Refresh(args[1]);
      } else if (args[0].equals("-setbattle")) {
        showBattleMap = true;
        battle = args[1];
        battleNumber = 0;
        map.load(args[1]);
      } else if (args[0].equals("-updatebattle")) {
        battleNumber++;
      } else if (args[0].equals("-endbattle")) {
        showBattleMap = false;
      } else if (args[0].equals("-speak")) {
        showSpeaker = true;
        speaker = args[1];
        lastSpeaker = args[1];
      } else if (args[0].equals("-narrate")) {
        showSpeaker = false;
      } else if (args[0].equals("-changeart")) {
        print("alter");
        characterDisplay.changeArt(args[1], args[2]);
      } else if (args[0].equals("-setheightscale")) {
        heightScale = float(args[1]);
      } 
      index++;
    }

    lastScene = currentScene - 1;
    lastSecretScene = currentSecretScene;
    currentScene = -1;
    currentSecretScene = -1;
    characterDisplay.HideAll();
  }

  void ChangeScene() {
    changeScene = true;
    textDisplay.displayText = false;
    dialogueDisplay.HideSpeaker();
  }

  void Run() {
    String sceneText = scenes.get(0).name;
    if (currentScene >= 0) {
      sceneText = scenes.get(currentScene).name;
    }

    backgroundGraphics.tint(255, 255);
    backgroundGraphics.imageMode(CORNER);
    backgroundGraphics.image(backgroundImage, 0, 0);
    backgroundGraphics.rectMode(CENTER);
    backgroundGraphics.textAlign(CENTER, TOP);
    backgroundGraphics.fill(0);
    backgroundGraphics.textFont(font);
    backgroundGraphics.text(sceneText, textX, textY, textWidth, textHeight);

    if (changeScene) {
      backgroundTintDelta = 80;
      changeScene = false;

      SceneData data = sceneToChangeTo;

      //music.PlayMusic(data.music);

      data.GetCharacters();

      characterDisplay.scaleHeights(data.heightScale);


      dialogueDisplay.dialogueLines = new ArrayList<String>();
      textDisplay.ClearText();
      input.index = data.index;

      if (data.showSpeaker) {
        dialogueDisplay.SetSpeaker(data.speaker);
      } else {
        dialogueDisplay.SecretSetSpeaker(data.speaker);
      }
      if (data.showBattleMap) {
        background.SetUnderlyingBackground("parchment");
        map.SetBattleNumber(data.battle, data.battleNumber);
      } else {
        map.EndBattle();
        background.SetUnderlyingBackground(data.background);
      }

      updateBackground = true;
      parser.Parse();
    }
  }

  void Previous() {
    if (currentScene > 0) {
      currentScene--;
      sceneToChangeTo = scenes.get(currentScene);
      ChangeScene();
    } else {
      currentScene = 0;
      sceneToChangeTo = scenes.get(currentScene);
      ChangeScene();
    }
  }

  void Next() {
    if (currentScene < lastScene) {
      currentScene++;
      sceneToChangeTo = scenes.get(currentScene);
      ChangeScene();
    }
  }

  void UpdateSceneNumber() {
    currentScene++;
  }

  void SkipForward() {
    int secretScene = secretScenesNumbers.get(input.index) + 1;
    if (secretScene < lastSecretScene) {
      sceneToChangeTo = secretScenes.get(secretScene);
      currentScene = sceneToChangeTo.realScene;
      ChangeScene();
    }
  }

  void SkipBackward() {
    int index = min(input.index, input.lines.length-10);
    int secretScene = secretScenesNumbers.get(index) - 2;
    secretScene = max(secretScene, 0);
    sceneToChangeTo = secretScenes.get(secretScene);
    currentScene = sceneToChangeTo.realScene;
    ChangeScene();
  }

  void TrimLines() {
    for (int i = 0; i < lines.length; i++) {
      lines[i] = trim(lines[i]);
    }
  }
}
