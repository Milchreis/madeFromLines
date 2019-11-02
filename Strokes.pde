import milchreis.imageprocessing.*;
import milchreis.imageprocessing.utils.*;

class Strokes {

  PGraphics canvas;
  PImage pixelized;

  void preparePicture(PImage img, int contrast) {
    pixelized = LUT.apply(img, LUT.loadLut(LUT.STYLE.CONTRAST_STRONG));

    for (int i=0; i<contrast; i++) {
      pixelized = LUT.apply(pixelized, LUT.loadLut(LUT.STYLE.CONTRAST_STRONG));
    }

    pixelized.loadPixels();
    background(255, 255, 255);

    canvas = createGraphics(img.width, img.height);
    canvas.beginDraw();
    canvas.background(255);
    canvas.endDraw();
  }

  void apply(int gridSize, int lineLength, int linesPerPixel, int lineWeight, int lineAlpha, boolean inColor) {
    canvas.beginDraw();
    canvas.background(255);

    for (int x=0; x < pixelized.width; x += gridSize) {
      for (int y=0; y < pixelized.height; y += gridSize) {

        int pixel = getGrey(pixelized.get(x, y));
        int numberOfStrokes = (int) map(pixel, 255, 0, 0, linesPerPixel);

        if (inColor) {
          canvas.stroke(pixelized.get(x, y), lineAlpha);
        } else {
          canvas.stroke(0, 0, 0, lineAlpha);
        }
      
        canvas.strokeWeight(lineWeight);

        for (int i=0; i<numberOfStrokes; i++) {
          canvas.pushMatrix(); 
          canvas.translate(x + random(-gridSize/2), y + random(gridSize/2)); 
          canvas.rotate(random(0, TWO_PI)); 
          canvas.line(-lineLength, 0, lineLength, 0); 
          canvas.popMatrix();
        }
      }
    }
    canvas.endDraw();
  }

  int getGrey(color pixel) {
    int c = pixel;
    int r=(c&0x00FF0000)>>16;
    int g=(c&0x0000FF00)>>8;
    int b=(c&0x000000FF);
    return (r+b+g)/3;
  }
}
