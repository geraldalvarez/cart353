class UI {

  //font from http://www.dafont.com/chrobot.font
  private PFont novaSolid;
  //color for text and button outline
  private color c;
  
  //public constructor
  public UI() {
    //initialize the font
    novaSolid = loadFont("Chrobot-50.vlw");
    //set font type
    textFont(novaSolid);
    //set the color
    c = color(208, 228, 242);
  }
  
  //function that creates text with big size
  public void h1Text(int x, int y, String text) {
    fill(c);
    textSize(60);
    text(text, x - textWidth(text)/2, y);
  }
  
  //function that creates text with medium size
  public void h2Text(int x, int y, String text) {
    fill(c);
    textSize(25);
    text(text, x- textWidth(text)/2, y);
  }
  
  //function that creates text with small size
  public void h3Text(int x, int y, String text) {
    fill(c);
    textSize(15);
    text(text, x - textWidth(text)/2, y);
  }
  
  //function that create a button with label and returns boolean value when mouse pointer is over the rectangle
  public boolean makeButton(String t, int x, int y, int w, int h) {

    //drawing the rect
    noFill();
    stroke(c);
    strokeWeight(2);
    rect(x, y, w, h, 5);

    fill(c);
    textSize(h*.75);
    text(t, x - (textWidth(t)/2) + (w/2), y + (h*.25) + (h/2));

    return Mechanic.pointRectangleCollision(x, y, w, h, mouseX, mouseY);
  }
}