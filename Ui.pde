import controlP5.*;
import java.awt.Desktop;

ControlP5 cp5;

void setupUi() {
  cp5 = new ControlP5(this);

  cp5.addButton("load_image")
    .setPosition(10, 10)
    .setSize(100, 19);

  cp5.addButton("save_image")
    .setPosition(10, 35)
    .setSize(100, 19);

  cp5.addSlider("lineLength")
    .setPosition(10, 70)
    .setSize(100, 19)
    .setNumberOfTickMarks(10)
    .setValue(4)
    .setRange(1, 10);

  cp5.addSlider("lineWeight")
    .setPosition(10, 105)
    .setSize(100, 19)
    .setNumberOfTickMarks(20)
    .setValue(1)
    .setRange(1, 20);

  cp5.addSlider("lineAlpha")
    .setPosition(10, 140)
    .setSize(100, 19)
    .setNumberOfTickMarks(20)
    .setValue(255)
    .setRange(1, 255);

  cp5.addSlider("gridSize")
    .setPosition(10, 175)
    .setSize(100, 19)
    .setNumberOfTickMarks(20)
    .setValue(3)
    .setRange(1, 20);

  cp5.addSlider("linesPerPixel")
    .setPosition(10, 210)
    .setSize(100, 19)
    .setNumberOfTickMarks(20)
    .setValue(4)
    .setRange(1, 20);

  cp5.addRadioButton("toggleColor")
    .setPosition(10, 245)
    .setSize(40, 20)
    .setColorLabel(color(255))
    .setItemsPerRow(5)
    .setSpacingColumn(50)
    .addItem("in color", 1);
}

public void controlEvent(ControlEvent theEvent) {
  println("on change " + theEvent.toString());

  if (isReady) {
    strokes.apply(gridSize, lineLength, linesPerPixel, lineWeight, lineAlpha, inColor);
  }
}

void toggleColor(int a) {
  println("a radio Button event: "+a);
  inColor = !inColor;
}

public void load_image(int value) {
  println("load image " + value);
  selectInput("Select a file to process:", "fileSelected");
}

public void save_image(int value) {
  println("save image + " + value);
  
  int factor = img.width / preview.width;
  
  Strokes strokes = new Strokes();
  strokes.preparePicture(img, contrast);
  strokes.apply(gridSize * factor, lineLength * factor, linesPerPixel, lineWeight * factor, lineAlpha, inColor);
  strokes.canvas.save("out.png");
  
  try {
    Desktop.getDesktop().open(new File(sketchPath(""), "out.png"));
  } catch(Exception e) {
    println(e);
  } 
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    img = loadImage(selection.getAbsolutePath());
    preview = createPreview(img);
    strokes.preparePicture(preview, contrast);
    strokes.apply(gridSize, lineLength, linesPerPixel, lineWeight, lineAlpha, inColor);
  }
}

PImage createPreview(PImage img) {

  PImage preview = img.copy();
  if (img.width > img.height)
    preview.resize(width, 0);
  else 
    preview.resize(0, height);

  return preview;
}
