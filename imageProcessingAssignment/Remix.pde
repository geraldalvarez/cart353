class Remix {

  //Properties
  //counters
  float fadeCtr = 0;
  int tintCtr = 0;

  //declare the two images
  PImage img1;
  PImage img2;
  PImage img3;
  PImage img4;

  //public constructor
  Remix(String n1, String n2) {
    //load images
    img1 = loadImage(n1);
    img2 = loadImage(n2); 
    img3 = createImage(img1.width, img1.height, RGB);
    img4 = createImage(img1.width, img1.height, RGB);
  }

  //display function
  void display(int t, boolean negative) {      

    //invoke crossfade function
    crossfadeImage();

    //invoke tintImage function
    tintImage(t);

    //invoke negativeImage Function
    negativeImage(negative);
  }

  //crossfade effect function
  void crossfadeImage() {

    //crossfade images using mouseY
    fadeCtr = map(mouseY, 0, height, 0.0, 1.0);

    //load pixels
    img3.loadPixels();

    //checking both image's pixels
    img1.loadPixels();
    img2.loadPixels();

    //loop the images
    for (int x = 0; x < img1.width; x++ ) {
      for (int y = 0; y < img1.height; y++ ) {

        //calculating 1D pixel's location
        int loc = x + y* img1.width;
        // Two colors
        color c0 = img1.pixels[loc];
        color c1 = img2.pixels[loc];

        // Separate out r,g,b components
        float r0 = red(c0); 
        float g0 = green(c0); 
        float b0 = blue(c0);
        float r1 = red(c1); 
        float g1 = green(c1); 
        float b1 = blue(c1);

        // Combine each image's color
        float r = fadeCtr*r0+(1.0-fadeCtr)*r1;
        float g = fadeCtr*g0+(1.0-fadeCtr)*g1;
        float b = fadeCtr*b0+(1.0-fadeCtr)*b1;

        // Set the new color
        img3.pixels[loc] = color(r, g, b);
      }
    }

    //update pixels
    img3.updatePixels();
    image(img3, 0, 0);
  }

  //tint effects function
  void tintImage(int t) {
    switch(t) {
    case 0:
      tint(255);//original state
      break;

    case 1:
      tint(173);//darker state
      break;

    case 2:
      tint(0, 0, 255, 100);//blue tint with transparacy
      break;

    case 3:
      tint(0, 255, 0, 100); //green tint with transparacy
      break;

    case 4:
      tint(255, 0, 0, 100);//red tint with transparacy
      println("case 4");
      break;

    default: 
      println("Error");
      break;
    }
  }

  //negative effect function
  void negativeImage(boolean isNegative) {

    //check if the tint ctr is 1
    if (isNegative) {

    //load img4 holder
    img4.loadPixels();

    for (int x = 1; x < img3.width; x++) {
      for (int y = 0; y < img3.height; y++) {

        //get 1D location and get pixel color
        int loc = x + y * img3.width;
        color pix = img3.pixels[loc];

        //get 1D -1 position location and get pixel color
        int leftLoc = (x -1) + y * img3.width;
        color leftPix = img3.pixels[leftLoc];


        //get the different brightness value of a pixel's neighbor
        float diff = abs(brightness(pix) - brightness(leftPix));

        //assign value 
        img4.pixels[loc] = color(diff);
      }
    }

    //update pixel
    img4.updatePixels();
    image(img4, 0, 0);
    }
  }
}