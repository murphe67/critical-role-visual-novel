class CharacterBust {
  PImage image;
  float xPosition;
  float yPosition;

  boolean showing;
  boolean hiding;

  ArrayList<Float> xPositions;

  float maxHeight;
  float maxHeightFt = 9;
  float characterHeight;

  CharacterBust(String character) {
    maxHeight = height * 0.7;
    image = loadImage("images/characters/" + character + ".png");
    if(image == null){
      image = loadImage("images/characters/matt.png");
    }
    characterHeight = CharacterHeights.Get(character);
    setSize(1);
  }
  
  void setSize(float heightScale){
    float appliedMaxHeightFt = maxHeightFt / heightScale;
    
    image.resize(0, floor(maxHeight * (characterHeight / appliedMaxHeightFt)));

    yPosition = height/2;
    yPosition += (1-(characterHeight/appliedMaxHeightFt)) * (maxHeight/2);
  }
 
  
  void setArt(String artName){
    image = loadImage("images/characters/" + artName + ".png");
    if(image == null){
      image = loadImage("images/characters/matt.png");
    }
    image.resize(0, floor(maxHeight * (characterHeight / maxHeightFt)));
  }

  void SetPosition(float xPosition) {
    xPositions = new ArrayList<Float>();
    xPositions.add(xPosition);
  }

  void AddAnotherPosition(float xPosition) {
    xPositions.add(xPosition);
  }

  void SetPositions(ArrayList<Float> positions) {
    xPositions = (ArrayList<Float>)positions.clone();
  }

  void Display(PGraphics backgroundGraphics) {
    backgroundGraphics.imageMode(CENTER);
    for (Float pos : xPositions) {
      backgroundGraphics.image(image, pos, yPosition);
    }
  }
}
