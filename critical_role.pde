import processing.pdf.*; //<>// //<>// //<>//

import ddf.minim.*;
//import com.hamoid.*;

boolean globalSkipText = true;
boolean autoPlay = false;

int minScreenshot = 87;

TextDisplay textDisplay;
Input input;

CharacterDisplay characterDisplay;
DialogueDisplay dialogueDisplay;
Parser parser;
Background background;
Music music;
BattleMap map;
End end;
Scene scene;
BaseColor baseColor;
GraphicSize graphicSize;

boolean screenshot;
int screenshotIndex = 0;

float textSpeed = 2.2;
float newTextSpeed = 2.5;
float transitionSpeed = 1.1;

float displaySpeed = 20;
float prevFrameTime;

String folderToRead = "CR_C1_E7";

PGraphics backgroundGraphics;
PGraphics backupGraphics;


boolean redrawBackground;
boolean backgroundReady;
boolean updateBackground;

float backgroundTint = 0;
float defaultTintDelta = 4;
float backgroundTintDelta = 4;

float widthScaling;
float heightScaling;

boolean displayParse = false;

float backgroundCheckTime;

boolean endFlag = false;

boolean setupFinished = false;

void setup() {
  fullScreen(P2D);
  //size(1800, 1000);
  //size(2700, 1500);
  widthScaling = width/1800.0;
  heightScaling = height/1000.0;
  background(0);

  backupGraphics = createGraphics(width, height);
  backgroundGraphics = createGraphics(width, height);

  parser = new Parser();
  input = new Input();
  CharacterHeights.Initialise();
  BaseWidths.Initialise();
  TokenOffset.Initialise();
  baseColor = new BaseColor();
  graphicSize = new GraphicSize();
  characterDisplay = new CharacterDisplay();
  textDisplay = new TextDisplay();
  dialogueDisplay = new DialogueDisplay();
  background = new Background();
  //music = new Music();
  map = new BattleMap();
  end = new End();
  scene = new Scene();

  if (!globalSkipText) {
    thread("preprocess");
  } else {
    preprocess();
  }
}

void preprocess() {
  scene.Initialise();
}

boolean preprocessingFinished = false;
boolean secondPreprocessFinished = false;

void draw() {
  if (!preprocessingFinished) {
    background(0);
    if (scene.maxIndex != 0) {
      rectMode(CORNER);
      fill(255);
      rect(width*0.2, height *0.4, width *0.6, height *0.2);
      fill(0);
      rect(width*0.22, height *0.42, (width * 0.56) * (scene.index / float(scene.lines.length)), height * 0.16);
    }
  } else {
    if (globalSkipText) {
      exit();
    } else {
      if (!secondPreprocessFinished) {
        input.Begin();

        backgroundGraphics.beginDraw();
        backgroundGraphics.background(0);
        backgroundGraphics.endDraw();

        scene.scenesReadyToRun = true;

        prevFrameTime = millis();
        secondPreprocessFinished = true;
      }


      if (!endFlag) {
        checkBackground();
        //println(frameRate);

        if (redrawBackground) {
          float update = backgroundTintDelta * ((millis() - prevFrameTime) * 60 / 1000);
          prevFrameTime = millis();
          backgroundTint += update;

          imageMode(CORNER);
          tint(255, 255);
          image(backupGraphics, 0, 0);

          tint(255, backgroundTint);
          image(backgroundGraphics, 0, 0);
        }

        dialogueDisplay.Run();
        parser.Run();

        if (backgroundTint > 255) {
          setupFinished = true;
          backgroundTintDelta = defaultTintDelta;
          redrawBackground = false;
          if (displayParse) {
            parser.Parse();
            displayParse = false;
          }
        }

        if (backgroundReady) {
          redrawBackground = true;
          backgroundReady = false;
          prevFrameTime = millis();
        }
      } else {
        end.Run();
      }
    }
  }
}

void checkBackground() {
  if (updateBackground) {
    updateBackground = false;
    drawBackground();
  }
}

void drawBackground() {
  if(!globalSkipText){
    backupGraphics.beginDraw();
    backupGraphics.image(backgroundGraphics, 0, 0);
    backupGraphics.endDraw();
  
  
    backgroundTint = 0;
    backgroundGraphics = createGraphics(width, height);
  
    backgroundGraphics.beginDraw();
    background.DrawBackground();
    map.DrawMap();
    characterDisplay.Run();
    dialogueDisplay.RunTrans();
    scene.Run();
    backgroundGraphics.endDraw();
  
    backgroundReady = true;
  
  } else {

    if (screenshot && screenshotIndex >= minScreenshot) {
      backupGraphics.beginDraw();
      backupGraphics.image(backgroundGraphics, 0, 0);
      backupGraphics.endDraw();
    
    
      backgroundTint = 0;
      backgroundGraphics = createGraphics(width, height);
    
      backgroundGraphics.beginDraw();
      background.DrawBackground();
      map.DrawMap();
      characterDisplay.Run();
      dialogueDisplay.RunTrans();
      scene.Run();
      backgroundGraphics.endDraw();
    
      backgroundReady = true;
  
      background(255);
      tint(255, 255);
      image(backgroundGraphics, 0, 0);
  
      saveFrame("rendered_battle/" + screenshotIndex + ".png");
      screenshotIndex++;
  
      screenshot = false;
    } else{
      screenshotIndex++;
    }
  }
}


void mouseReleased() {
  input.HandleClick();
  dialogueDisplay.HandleClick();
}

void keyReleased() {
  if (keyCode == LEFT) {
    scene.Previous();
  } else if (keyCode == RIGHT) {
    scene.Next();
  }
  if (key == 'a') {
    scene.SkipBackward();
  } else if (key == 'd') {
    scene.SkipForward();
  }
  if (key == ' ') {
    input.HandleClick();
    dialogueDisplay.HandleClick();
  }
}
