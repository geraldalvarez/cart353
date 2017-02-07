import processing.video.*;
import java.util.Random;

//declare capture video
Capture video;

//declare walker 
Walker walker;

void setup() {
  size(640, 480);

  //instantiate video capture and start
  video = new Capture(this, width, height);
  video.start();

  //instantiate walker
  walker = new Walker();

}

//event listiner for video capture
void captureEvent(Capture video) {
  video.read();
}

void draw() {

  //load pixel
  loadPixels();
  video.loadPixels();

  //x offset
  float xoff = 0.0;

  //loops the screen pixel
  for (int x = 0; x < video.width; x++) {

    //y offset
    float yoff = 0.0;

    //set noise detail of perlin noise
    noiseDetail(6, 0.4);

    for (int y = 0; y < video.height; y++) {

      // Calculate the 1D location from a 2D grid
      int loc = x + y * video.width;

      // Get the red, green, blue values from a pixel
      float r = red (video.pixels[loc]);
      float g = green(video.pixels[loc]);
      float b = blue (video.pixels[loc]);
      
      //noise colors
      float r2 = map(noise(xoff, yoff), 0, 1, 0, 255);
      float g2 = map(noise(xoff+5, yoff), 0, 1, 0, 255);
      float b2 = map(noise(xoff, yoff+5), 0, 1, 0, 255);

      // Calculate an amount to change brightness based on proximity to the walker
      float d = dist(x, y, walker.getX(), walker.getY());
      float adjustbrightness = map(d, 0, 150, 4, 0);
      
      //adjusting brightness 
      //make the other circle dark
      r *= adjustbrightness;
      g *= adjustbrightness;
      b *= adjustbrightness;

      // Constrain RGB to make sure they are within 0–255 color range
      r = constrain(r, 0, 255);
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);
      
      //percentage of cross fade
      float fade = 0.5;
      
      //mixing colors
      float r3 = fade*r+(1.0-fade)*r2;
      float g3 = fade*g+(1.0-fade)*g2;
      float b3 = fade*b+(1.0-fade)*b2;

      // Make a new color and set pixel in the window
      pixels[loc] = color(r3, g3, b3);
      
      //update yoff
      yoff+=0.01;
    }
    //update xoff
    xoff += 0.01;
  }
  
  //update pixels
  updatePixels();

  //update walker step
  walker.step();
}