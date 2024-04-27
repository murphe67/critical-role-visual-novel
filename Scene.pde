class Scene {

  HashMap<Integer, SceneData> scenes = new HashMap<Integer, SceneData>();
  HashMap<Integer, SceneData> secretScenes = new HashMap<Integer, SceneData>();
  HashMap<Integer, Integer> secretScenesNumbers = new HashMap<Integer, Integer>();

  ArrayList<String> showHideStrings;

  int lastScene;
  int lastSecretScene;

  String lines[];
  int index;

  int maxIndex = 0;

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


  boolean scenesReadyToRun = false;

  void Initialise() {
    showHideStrings = new ArrayList<String>();
    showHideStrings.add("-show");
    showHideStrings.add("-hide");
    showHideStrings.add("-showanother");
    showHideStrings.add("-refresh");

    font = createFont("fonts/maragsa display.otf", 30 * widthScaling);
    backgroundImage = loadImage("images/scene background.png");
    backgroundImage.resize(width, height);

    lines = loadStrings("episodes/" + folderToRead + "/main.txt");
    TrimLines();
    index = 0;
    maxIndex = lines.length;

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
      println(line);
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
        secretData.battleSaver = new BattleMapSaver(map);
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

        data.battleSaver = new BattleMapSaver(map);

        scenes.put(currentScene, data);
        currentScene++;

        SceneData newData = new SceneData(data);
        data = newData;
      } else if (args[0].equals("-background")) {
        background.load(args[1]);
        data.background = args[1];
        secretData.background = args[1];
        if (globalSkipText) {
          background.SetUnderlyingBackground(args[1]);
          screenshot = true;
          updateBackground = true;
          checkBackground();
        }
      } else if (args[0].equals("-slowbackground")) {
        background.load(args[1]);
        data.background = args[1];
        secretData.background = args[1];
        if (globalSkipText) {
          background.SetUnderlyingBackground(args[1]);
          screenshot = true;
          updateBackground = true;
          checkBackground();
        }
      } else if (args[0].equals("-music")) {
        data.music = args[1];
        secretData.music = args[1];
      } else if (args[0].equals("-show")) {
        characterDisplay.Show(args[1], float(args[2]));
        if (globalSkipText) {
          String nextLine = lines[index+1];
          String args2[] = split(nextLine, " ");
          if (!(showHideStrings.contains(args2[0]))) {
            characterDisplay.Transition();
            updateBackground = true;
            checkBackground();
          }
        }
      } else if (args[0].equals("-showanother")) {
        characterDisplay.ShowAnother(args[1], float(args[2]));
        if (globalSkipText) {
          String nextLine = lines[index+1];
          String args2[] = split(nextLine, " ");
          if (!(showHideStrings.contains(args2[0]))) {
            characterDisplay.Transition();
            updateBackground = true;
            checkBackground();
          }
        }
      } else if (args[0].equals("-hide")) {
        characterDisplay.Hide(args[1]);
        if (globalSkipText) {
          String nextLine = lines[index+1];
          String args2[] = split(nextLine, " ");
          if (!(showHideStrings.contains(args2[0]))) {
            characterDisplay.Transition();
            updateBackground = true;
            checkBackground();
          }
        }
      } else if (args[0].equals("-refresh")) {
        characterDisplay.Refresh(args[1]);
        if (globalSkipText) {
          String nextLine = lines[index+1];
          String args2[] = split(nextLine, " ");
          if (!(showHideStrings.contains(args2[0]))) {
            characterDisplay.Transition();
            updateBackground = true;
            checkBackground();
          }
        }
      } else if (args[0].equals("-setbattle")) {
        map.load(args[1]);
        map.SetBattleMap(args[1], int(args[2]), int(args[3]));
        data.background = "parchment";
        secretData.background = "parchment";
        background.SetUnderlyingBackground("parchment");
      } else if (args[0].equals("-updatebattle")) {
        map.UpdateBattle();
        updateBackground = true;
        checkBackground();
      } else if (args[0].equals("-endbattle")) {
        map.EndBattle();
        updateBackground = true;
        checkBackground();
      } else if (args[0].equals("-speak")) {
        showSpeaker = true;
        speaker = args[1];
        lastSpeaker = args[1];
      } else if (args[0].equals("-narrate")) {
        showSpeaker = false;
      } else if (args[0].equals("-changeart")) {
        print("alter");
        characterDisplay.changeArt(args[1], args[2]);
        characterDisplay.Transition();
        updateBackground = true;
        checkBackground();
      } else if (args[0].equals("-setheightscale")) {
        heightScale = float(args[1]);
        updateBackground = true;
        checkBackground();
      } else if (args[0].equals("-addtoken")) {
        map.AddToken(args[1], args[2], args[3], float(args[4]), float(args[5]));
      } else if (args[0].equals("-addgraphicon")) {
        map.AddGraphicOn(args[1], args[2], args[3], args[4], args[5], args[6]);
      } else if (args[0].equals("-removegraphic")) {
        map.RemoveGraphic(args[1]);
      } else if (args[0].equals("-removeallgraphics")) {
        map.RemoveAllGraphics();
      } else if (args[0].equals("-removetoken")) {
        map.RemoveToken(args[1]);
      } else if (args[0].equals("-movetoken")) {
        String colorBase = args[1];
        if (args.length == 5) {
          colorBase = args[4];
        }
        map.MoveToken(args[1], float(args[2]), float(args[3]), colorBase);
      } else if (args[0].equals("-refreshtoken")) {
        map.RefreshToken(args[1]);
      } else if (args[0].equals("-addgraphic")) {
        map.AddGraphic(args[1], args[2], args[3], args[4], args[5], float(args[6]), float(args[7]));
      } else if (args[0].equals("-setprone")) {
        map.SetProne(args[1], boolean(args[2]));
      } else if (args[0].equals("-setshadow")) {
        map.SetShadow(args[1], boolean(args[2]));
      } else if (args[0].equals("-pausebattle")) {
        map.PauseBattle();
      } else if (args[0].equals("-end")) {
        break;
      }
      index++;
    }

    lastScene = currentScene - 1;
    lastSecretScene = currentSecretScene;
    currentScene = -1;
    currentSecretScene = -1;
    characterDisplay.HideAll();
    map.EndBattle();

    preprocessingFinished = true;
  }

  void ChangeScene() {
    changeScene = true;
    textDisplay.displayText = false;
    dialogueDisplay.HideSpeaker();
  }

  void Run() {
    if (!scenesReadyToRun) {
      return;
    }

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

      dialogueDisplay.oldShowSpeaker = dialogueDisplay.showSpeaker;
      dialogueDisplay.oldSpeaker = dialogueDisplay.speaker;
      dialogueDisplay.SecretSetSpeaker(data.speaker);

      background.SetUnderlyingBackground(data.background);
      data.battleSaver.update(map);

      updateBackground = true;

      input.index = data.index;
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
