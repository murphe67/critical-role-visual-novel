class TextDisplay {
  float xPosition, yPosition, textWidth, textHeight;
  float speaker1XPos, speaker2XPos, speakerYPos, speakerWidth, speakerHeight;

  PFont font;

  String fullString;
  ArrayList<String> displayLines = new ArrayList<String>();
  String currentLine = "";
  int index = 0;

  float charUpdateTimer;
  float cursorTimer;
  float cursorTimeCycle = 700;
  boolean showCursor;

  float textUpdateTime = 35;
  float pauseTime = 0;

  int currentLineSubstringIndex;
  int lineIndex;

  float lineHeight;

  float startTime;

  float defaultStartDelay = 200;
  float speakChangeStartDelay = 600;
  float startDelay = speakChangeStartDelay;

  boolean updated;
  String newString;

  boolean displayText = false;

  PImage arrow;

  boolean dialogueUpdated = false;
  
  boolean previousSpeaker = true;

  TextDisplay() {
    xPosition = width * 0.075;
    yPosition = height * 0.80;
    textWidth = width * 0.8;
    textHeight = height * 0.16;
    lineHeight = textHeight * 0.50;

    speaker1XPos = width * 0.16;
    speaker2XPos = width * 0.60;
    speakerYPos = height * 0.715;
    speakerWidth = width * 0.21;
    speakerHeight = height * 0.09;

    font = createFont("fonts/maragsa display.otf", 40 * widthScaling);
    arrow = loadImage("images/arrow.png");
    arrow.resize(int(width * 0.05), int(width * 0.05));
  }


  void StartText(String string) {
    dialogueUpdated = false;
    startTime = millis();

    newString = string;
    updated = false;
    pauseTime = 0;
    if (newString.length() > 0) {
      displayText = true;
    }
  }

  void Run() {
    println(startDelay);
    UpdateText();
    Display();

    if (TextFinished() && displayText) {
      imageMode(CENTER);
      image(arrow, width * 0.9, height*0.92);
      if (!dialogueUpdated && autoPlay) {
        dialogueDisplay.UpdateAfterDelay();
        dialogueUpdated = true;
      }
    }
  }


  void DisplaySpeaker(String speaker, boolean speaker1, int alpha) {
    textFont(font);
    rectMode(CORNER);
    textAlign(CENTER, TOP);
    textLeading(50);

    fill(0, alpha);
    if (speaker1) {
      text(speaker, speaker1XPos, speakerYPos, speakerWidth, speakerHeight);
    } else {
      text(speaker, speaker2XPos, speakerYPos, speakerWidth, speakerHeight);
    }
  }


  boolean prevCharacterWasPunctuation;
  void UpdateText() {
    if (updated && displayText) {
      if (fullString.length() > 0) {
        int updateAmount = floor((textSpeed * (millis() - charUpdateTimer)) / (textUpdateTime + pauseTime));
        if (updateAmount > 0) {
          pauseTime = 0;
          for (int i=0; i<updateAmount; i++) {
            index++;
            index = min(index, fullString.length() - 1);
            char indexChar = fullString.charAt(index);

            if (indexChar == ' ' && prevCharacterWasPunctuation) {
              pauseTime = 500;
              break;
            }

            if (indexChar == '.' || indexChar == ',' || indexChar == '-' || indexChar == '?' || indexChar == '!') {
              prevCharacterWasPunctuation = true;
            } else {
              prevCharacterWasPunctuation = false;
            }
          }
          UpdateString();
          charUpdateTimer = millis();
        }
      }
      if (millis() > cursorTimer + cursorTimeCycle) {
        cursorTimer = millis();
        showCursor = !showCursor;
      }
    }
  }

  void UpdateString() {
    index = min(index, fullString.length() - 1);
    int spaceIndex = index;

    while (fullString.charAt(spaceIndex) != ' ' && spaceIndex < fullString.length() - 1) {
      spaceIndex++;
    }
    textFont(font);
    if (textWidth(fullString.substring(currentLineSubstringIndex, spaceIndex + 1)) > textWidth) {
      while (fullString.charAt(index) != ' ' && index > 0) {
        index--;
      }
      displayLines.add(fullString.substring(currentLineSubstringIndex, index + 1));

      while (fullString.charAt(index) == ' ' && index < fullString.length() - 1) {
        index++;
      }
      currentLineSubstringIndex = index;

      lineIndex++;
      lineIndex = min(lineIndex, 2);
    }

    currentLine = fullString.substring(currentLineSubstringIndex, index + 1);
  }


  void ClearText() {
    displayText = false;
    currentLine = "";
    lineIndex = 0;
    displayLines = new ArrayList<String>();
  }

  void Display() {
    if (displayText) {
      if (millis() > startTime + startDelay) {
        startDelay = defaultStartDelay;
        if (!updated) {
          updated = true;

          fullString = newString;
          currentLine = fullString.substring(0, 0);
          displayLines = new ArrayList<String>();
          index = 0;
          cursorTimer = millis();

          showCursor = true;
          currentLineSubstringIndex = 0;
          lineIndex = 0;
          charUpdateTimer = millis();
        }
      }
      rectMode(CORNER);
      textAlign(LEFT, TOP);
      fill(0, 255);
      textFont(font);
      String displayString = "";
      for (String s : displayLines) {
        displayString += s + "\n";
      }

      displayString += currentLine;
      text(displayString, xPosition, yPosition, textWidth, textHeight);

      //if (showCursor) {
      //  float cursorPosition = xPosition + textWidth(currentLine) + (10 * widthScaling);
      //  rectMode(CORNER);
      //  rect(cursorPosition, yPosition + (lineHeight * lineIndex), (4 * widthScaling), (40 * widthScaling));
      //}
    }
  }

  boolean TextFinished() {
    if (!displayText) {
      return true;
    }
    if (!updated) {
      return false;
    }
    return index == fullString.length() - 1;
  }
}
