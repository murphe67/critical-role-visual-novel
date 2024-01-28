import ddf.minim.*; //<>// //<>// //<>//
//import com.hamoid.*;

boolean globalSkipText = false;
boolean autoPlay = false;

int displayRate = 3;
int imageIndex = 1;

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

float textSpeed = 2.4;
float newTextSpeed = 2.5;
float transitionSpeed = 1.1;

float displaySpeed = 20;
float prevFrameTime;

String folderToRead = "CR_C1_E1";

PGraphics backgroundGraphics;
PGraphics backupGraphics;
boolean redrawBackground;
boolean backgroundReady;
boolean updateBackground;

float backgroundTint = 0;
float defaultTintDelta = 4;
float backgroundTintDelta = 1.5;

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
  
  parser = new Parser();
  input = new Input();
  CharacterHeights.Initialise();
  characterDisplay = new CharacterDisplay();
  textDisplay = new TextDisplay();
  dialogueDisplay = new DialogueDisplay();
  background = new Background();
  //music = new Music();
  map = new BattleMap();
  end = new End();
  scene = new Scene();

  backupGraphics = createGraphics(width, height);
  backgroundGraphics = createGraphics(width, height);

  input.Begin();

  drawBackground();

  backgroundGraphics.beginDraw();
  backgroundGraphics.background(0);
  backgroundGraphics.endDraw();

  prevFrameTime = millis();
}

void draw() {
  if(!endFlag){
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
      setupFinished = false;
      backgroundTintDelta = defaultTintDelta;
      redrawBackground = false;
      if (displayParse) {
        parser.Parse();
        displayParse = false;
      }
    }
    
    if(backgroundReady){
      redrawBackground = true;
      backgroundReady = false;
      prevFrameTime = millis();
    }
  } else {
    end.Run();
  }
}

void checkBackground() {
    if(updateBackground){
      updateBackground = false;
      drawBackground();
    }
}

void drawBackground() {
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
