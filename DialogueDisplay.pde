class DialogueDisplay {
  PImage dialogueBoxTrans;
  PImage dialogueBoxSolid;
  PImage dialogueTag1;
  PImage dialogueTag2;

  String speaker = "";

  ArrayList<String> dialogueLines = new ArrayList<String>();

  boolean displayDialogue;

  int speakerNum = 0;
  boolean showSpeaker = true;

  float parseDelay = 1700;
  boolean parseAfterTimer;
  float parseTimer;

  int dialogueTint = 0;

  DialogueDisplay() {
    dialogueBoxTrans = loadImage("images/dialogue box.png");
    dialogueBoxTrans.resize(width, height);

    dialogueBoxSolid = loadImage("images/dialogue box rect.png");
    dialogueBoxSolid.resize(width, height);

    dialogueTag1 = loadImage("images/dialogue tag.png");
    dialogueTag1.resize(width, height);

    dialogueTag2 = loadImage("images/dialogue tag 2.png");
    dialogueTag2.resize(width, height);

    parseDelay = 1700 / newTextSpeed;
  }

  void SetSpeaker(String speaker) {
    StartDialogue();
    showSpeaker = true;
    this.speaker = speaker;
    if (speakerNum != 1) {
      speakerNum = 1;
    } else {
      speakerNum = 2;
    }
    updateBackground = true;
  }

  void SecretSetSpeaker(String speaker) {
    this.speaker = speaker;
  }

  void RerevealSpeaker() {
    showSpeaker = true;
    updateBackground = true;
  }

  void Narrate() {
    StartDialogue();
    showSpeaker = false;
    updateBackground = true;
  }

  void HideSpeaker() {
    showSpeaker = false;
    updateBackground = true;
  }

  void AddDialogueLine(String dialogueLine) {
    dialogueLines.add(dialogueLine);
  }

  void StartDialogue() {
    if (!globalSkipText) {
      displayDialogue = true;
      if (dialogueLines.size() > 0) {
        textDisplay.StartText(dialogueLines.get(0));
        dialogueLines.remove(0);
      }
    } else {
      parser.ParseAfterDelay(1000);
    }
  }

  void Run() {
    if (!redrawBackground && setupFinished) {
      imageMode(CORNER);
      tint(255, 255);
      image(dialogueBoxSolid, 0, 0);
    }

    textDisplay.Run();

    if (parseAfterTimer) {
      if (millis() > parseDelay + parseTimer) {
        parseAfterTimer = false;
        HandleClick();
      }
    }
  }

  void RunTrans() {
    backgroundGraphics.imageMode(CORNER);
    backgroundGraphics.tint(255, 255);
    backgroundGraphics.image(dialogueBoxTrans, 0, 0);
    
    DrawSpeakers();
  }

  void DrawSpeakers() {
    if (showSpeaker) {
      imageMode(CORNER);
      tint(255, 255);
      if (speakerNum == 1) {
        backgroundGraphics.image(dialogueTag1, 0, 0);
      } else {
        backgroundGraphics.image(dialogueTag2, 0, 0);
      }

      textDisplay.DisplaySpeaker(speakerNum);
    }
  }

  void HandleClick() {
    if (displayDialogue) {
      if (textDisplay.TextFinished()) {
        if (dialogueLines.size() > 0) {
          textDisplay.StartText(dialogueLines.get(0));
          dialogueLines.remove(0);
        } else {
          displayDialogue = false;
          parser.Parse();
        }
      } else {
        if (textDisplay.updated) {
          while (!textDisplay.TextFinished()) {
            textDisplay.index++;
            textDisplay.UpdateString();
          }
        }
      }
    }
  }


  void UpdateAfterDelay() {
    parseAfterTimer = true;
    parseTimer = millis();
  }
}
