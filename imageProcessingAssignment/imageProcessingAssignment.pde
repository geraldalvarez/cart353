/**************************
*Image Processing Asignment
*Course: Cart 353
*Gerald Alvarez
*************************/


//declare remix objects
Remix remix;

//mouse right button counter
int mouseRightCtr;

//flag for mouse left button
boolean leftBtnPressed;

//save file number saved counter
int saved;

void setup() {
  size(720, 450);

  //instantiating remix object
  remix = new Remix("planet.jpg", "tree.jpg");

  //assign value to mouseCtr
  mouseRightCtr = 0;
  
  //assign value to leftBtnPressed
  leftBtnPressed = false;
  
  //assign value to saved 
  saved = 0;
}

void draw() {
  //display remix
  remix.display(mouseRightCtr, leftBtnPressed);
}


//event handler for mousepressed
void mousePressed() {

  //check if left mouse button is pressed
  if (mouseButton == LEFT) {

    //check the tint max cases
    if (mouseRightCtr < 4) {
      mouseRightCtr++;
    } else {
      //reset value
      mouseRightCtr = 0;
    }
  } else {
    //else
    //check right mouse button is pressed
    if (mouseButton == RIGHT) {
      leftBtnPressed = ! leftBtnPressed;
    }
  }
}

//event handler for keypressed
void keyPressed() {

  //space bar is pressed
  if (key == 32) {
    //create a screen print of the running sketch
    save("save"+saved);
    println("Screen Shot");
  }
}