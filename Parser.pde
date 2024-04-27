class Parser {

  float parseTimer;
  boolean parseAfterTimer = false;
  float parseDelay;

  float unblockTimer;
  boolean unblockAfterTimer = false;
  float unblockDelay;

  ArrayList<String> showHideStrings;

  boolean blockParsing;

  boolean justNarrated = false;

  Parser() {
    showHideStrings = new ArrayList<String>();
    showHideStrings.add("-show");
    showHideStrings.add("-hide");
    showHideStrings.add("-showanother");
  }

  void Run() {
    if (parseAfterTimer) {
      if (millis() > parseTimer + parseDelay) {
        parseAfterTimer = false;
        Parse();
      }
    }
    if (unblockAfterTimer) {
      if (millis() > unblockTimer + unblockDelay) {
        unblockAfterTimer = false;
        blockParsing = false;
      }
    }
  }

  void ParseAfterDelay(float delay) {
    parseAfterTimer = true;
    parseDelay = delay;
    parseTimer = millis();
  }

  void UnblockAfterDelay(float delay) {
    unblockAfterTimer = true;
    unblockTimer = millis();
    unblockDelay = delay;
  }

  void Parse() {
    if (!blockParsing) {
      String line = input.PopLine();
      if (line == null) {
        exit();
      } else {
        String args[] = split(line, " ");
        if (args[0].equals("-show")) {
          float index = 0;
          if (args.length == 3) {
            index = float(args[2]);
          }
          characterDisplay.Show(args[1], index);


          String nextLine = input.PeakLine();
          String args2[] = split(nextLine, " ");
          if (!(showHideStrings.contains(args2[0]))) {
            characterDisplay.Transition();
          }
          Parse();
        } else if (args[0].equals("-slowshow")) {
          float index = 0;
          if (args.length == 3) {
            index = float(args[2]);
          }
          backgroundTintDelta = 5;
          characterDisplay.Show(args[1], index);
          characterDisplay.Transition();

          Parse();
        } else if (args[0].equals("-showanother")) {
          float index = 0;
          if (args.length == 3) {
            index = float(args[2]);
          }
          characterDisplay.ShowAnother(args[1], index);

          String nextLine = input.PeakLine();
          String args2[] = split(nextLine, " ");
          if (!(showHideStrings.contains(args2[0]))) {
            characterDisplay.Transition();
          }
          Parse();
        } else if (args[0].equals("-hide")) {
          characterDisplay.Hide(args[1]);

          String nextLine = input.PeakLine();
          String args2[] = split(nextLine, " ");
          if (!(showHideStrings.contains(args2[0]))) {
            characterDisplay.Transition();
          }
          Parse();
        } else if (args[0].equals("-refresh")) {
          characterDisplay.Refresh(args[1]);
          Parse();
        } else if (args[0].equals("-speak")) {

          justNarrated = false;
          textDisplay.ClearText();
          String speaker = "";
          for (int i=1; i<args.length; i++) {
            speaker += args[i] + " ";
          }
          while (input.PeakLine() != null && input.PeakLine().charAt(0) != '-') {
            String speakLine = input.PopLine();
            dialogueDisplay.AddDialogueLine(speakLine);
          }

          dialogueDisplay.SetSpeaker(speaker);
        } else if (args[0].equals("-narrate")) {
          justNarrated = true;
          textDisplay.ClearText();
          while (input.PeakLine() != null && input.PeakLine().charAt(0) != '-') {
            String speakLine = input.PopLine();
            dialogueDisplay.AddDialogueLine(speakLine);
          }

          dialogueDisplay.Narrate();
        } else if (args[0].equals("-clear")) {
          textDisplay.ClearText();
          Parse();
        } else if (args[0].equals("-cleartext")) {
          textDisplay.ClearText();
        } else if (args[0].equals("-wait")) {
          ParseAfterDelay(int(args[1]) * 1000);
        } else if (args[0].equals("-continue")) {
          if (justNarrated) {
            textDisplay.ClearText();
          }
          justNarrated = false;
          while (input.PeakLine() != null && input.PeakLine().charAt(0) != '-') {
            String speakLine = input.PopLine();
            dialogueDisplay.AddDialogueLine(speakLine);
          }
          dialogueDisplay.RerevealSpeaker();
        } else if (args[0].equals("-background")) {
          background.SetBackground(args[1]);
        } else if (args[0].equals("-slowbackground")) {
          background.SetSlowBackground(args[1]);
          Parse();
        } else if (args[0].equals("-music")) {
          //music.PlayMusic(args[1]);
          Parse();
        } else if (args[0].equals("-musicpause")) {
          //music.Pause();
          Parse();
        } else if (args[0].equals("-musicunpause")) {
          //music.Unpause();
          Parse();
        } else if (args[0].equals("-setbattle")) {
          background.SetUnderlyingBackground("parchment");
          map.SetBattleMap(args[1], int(args[2]), int(args[3]));
          Parse();
        } else if (args[0].equals("-updatebattle")) {
          map.UpdateBattle();
          Parse();
        } else if (args[0].equals("-endbattle")) {
          map.EndBattle();
          Parse();
        } else if (args[0].equals("-end")) {
          end.StartEnd();
        } else if (args[0].equals("-scene")) {
          scene.UpdateSceneNumber();
          Parse();
        } else if (args[0].equals("-displaywait")) {
          displayParse = true;
        } else if (args[0].equals("-changeart")) {
          characterDisplay.changeArt(args[1], args[2]);
          Parse();
        } else if (args[0].equals("-setheightscale")) {
          characterDisplay.scaleHeights(float(args[1]));
          Parse();
        } else if (args[0].equals("-addtoken")) {
          map.AddToken(args[1], args[2], args[3], float(args[4]), float(args[5]));
          Parse();
        } else if (args[0].equals("-addgraphicon")) {
          map.AddGraphicOn(args[1], args[2], args[3], args[4], args[5], args[6]);
          Parse();
        } else if (args[0].equals("-removegraphic")) {
          map.RemoveGraphic(args[1]);
          Parse();
        } else if (args[0].equals("-removeallgraphics")) {
          map.RemoveAllGraphics();
          Parse();
        } else if (args[0].equals("-removetoken")) {
          map.RemoveToken(args[1]);
          Parse();
        } else if (args[0].equals("-movetoken")) {
          String colorBase = args[1];
          if (args.length == 5) {
            colorBase = args[4];
          }
          map.MoveToken(args[1], float(args[2]), float(args[3]), colorBase);
          Parse();
        } else if (args[0].equals("-refreshtoken")) {
          map.RefreshToken(args[1]);
          Parse();
        } else if (args[0].equals("-addgraphic")) {
          map.AddGraphic(args[1], args[2], args[3], args[4], args[5], float(args[6]), float(args[7]));
          Parse();
        } else if (args[0].equals("-setprone")) {
          map.SetProne(args[1], boolean(args[2]));
          Parse();
        } else if (args[0].equals("-setshadow")) {
          map.SetShadow(args[1], boolean(args[2]));
          Parse();
        } else if (args[0].equals("-pausebattle")) {
          map.PauseBattle();
          Parse();
        } else {
          println("unknown command "+ args[0]);
        }
      }
    }
  }
}
