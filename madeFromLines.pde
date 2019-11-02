
// Configuration ////////////////////////
String yourPicture = "house.jpg";
int lineLength = 4;
int lineWeight = 1;
int lineAlpha = 220;
int linesPerPixel = 4;
int gridSize = 3;
int contrast = 2;
boolean inColor = false;
/////////////////////////////////////////

PImage img;
PImage preview;
Strokes strokes;
boolean isReady;

void setup() {
  size(1000, 600);
  imageMode(CENTER);

  img = loadImage(yourPicture);
  preview = createPreview(img);

  setupUi();

  strokes = new Strokes();
  strokes.preparePicture(preview, contrast);
  strokes.apply(gridSize, lineLength, linesPerPixel, lineWeight, lineAlpha, inColor);

  isReady = true;
}

void draw() {
  background(255);
  image(strokes.canvas, width/2, height/2);

  // Background for controls
  noStroke();
  fill(0, 0, 0, 180);
  rect(0, 0, 180, 280);
}
