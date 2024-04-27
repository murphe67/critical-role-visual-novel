class DialogueDisplay {
  PImage dialogueBoxTrans;
  PImage dialogueBoxSolid;
  PImage dialogueTag1;
  PImage dialogueTag2;

  String speaker = "";

  boolean oldShowSpeaker;
  String oldSpeaker;

  ArrayList<String> dialogueLines = new ArrayList<String>();

  boolean displayDialogue;

  int speakerNum = 0;
  int oldSpeakerNum = 0;
  
  boolean showSpeaker = false;

  float parseDelay = 1700;
  boolean parseAfterTimer;
  float parseTimer;

  int dialogueTint = 0;

  float lastRefreshed = 0;

  int alpha1 = 0;
  int alpha2 = 0;
  float speakerTime;
  boolean newSpeaker = false;
  
  float appearDelay;
  float defaultAppearDelay = 0;
  float changeSpeakerAppearDelay = 150;
  

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
    newSpeaker = true;

    oldShowSpeaker = showSpeaker;
    oldSpeaker = this.speaker;
    textDisplay.startDelay = textDisplay.speakChangeStartDelay;

    StartDialogue();
    showSpeaker = true;
    this.speaker = speaker;
    oldSpeakerNum = speakerNum;
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
    if(!showSpeaker){
      newSpeaker = true;
    }
    
    textDisplay.startDelay = textDisplay.speakChangeStartDelay;
    
    showSpeaker = true;
    updateBackground = true;
    StartDialogue();
  }

  void Narrate() {
    newSpeaker = true;

    oldShowSpeaker = showSpeaker;
    oldSpeaker = this.speaker;
    if(oldShowSpeaker){
      appearDelay = changeSpeakerAppearDelay;
    } else {
      appearDelay = defaultAppearDelay;
    }
    oldSpeakerNum = speakerNum;
    
    textDisplay.startDelay = textDisplay.speakChangeStartDelay;

    
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
      drawBackground();
      if (millis() - lastRefreshed > 10000) {
        lastRefreshed = millis();
        parser.ParseAfterDelay(1.0);
      } else {
        parser.Parse();
      }
    }
  }

  void Run() {
    if (setupFinished) {
      if (!redrawBackground) {
        imageMode(CORNER);
        tint(255, 255);
        image(dialogueBoxSolid, 0, 0);
      }

      if (newSpeaker) {
        speakerTime = millis();
        newSpeaker = false;
        alpha1 = 0;
        alpha2 = 255;
      }

      float timePassed = max((millis() - speakerTime) - 200, 0);
      if(alpha1 < 255){
        alpha1 = int(300 * (1-exp(-max(0, timePassed - appearDelay)/100.0)));
      }

      if (alpha2 > 0) {
        alpha2 = 255 - int(300 * (1-exp(-timePassed/100.0)));
      } else {
        oldShowSpeaker = false;
      }

      DrawSpeakers();
      textDisplay.Run();

      if (parseAfterTimer) {
        if (millis() > parseDelay + parseTimer) {
          parseAfterTimer = false;
          HandleClick();
        }
      }
    }
  }

  void RunTrans() {
    backgroundGraphics.imageMode(CORNER);
    backgroundGraphics.tint(255, 255);
    backgroundGraphics.image(dialogueBoxTrans, 0, 0);
  }

  void DrawSpeakers() {
    if (showSpeaker) {
      imageMode(CORNER);
      int alpha1_t = max(alpha1, 0);
      tint(255, alpha1_t);
      if (speakerNum == 1) {
        image(dialogueTag1, 0, 0);
      } else {
        image(dialogueTag2, 0, 0);
      }

      textDisplay.DisplaySpeaker(speaker, speakerNum==1, alpha1_t);
    }
    if (oldShowSpeaker && redrawBackground) {
      tint(255, alpha2);
      if (oldSpeakerNum == 1) {
        image(dialogueTag1, 0, 0);
      } else {
        image(dialogueTag2, 0, 0);
      }
      textDisplay.DisplaySpeaker(oldSpeaker, oldSpeakerNum==1, alpha2);
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
