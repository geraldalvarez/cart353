Game game;

String state;

boolean playing;

void setup() {
  size(500, 500);
  background(0);

  //
  game = new Game();
  //
  state = "menu";
  //
  playing = false;
}

void draw() {
  background(255);

  if (state == "menu") {
    displayMenu();
  } else if (state == "game") {
    game.update();
    game.display();
  } else if (state == "result") {
    displayResult();
  }
}


//-------------EVENT HANDLERS----------------//
void mousePressed() {
  game.setMousePressed(true, false);
}

void mouseReleased() {
  game.setMousePressed(false, true);
}

void keyPressed() {
  if(key == 32 && !playing){
   state = "game";
   playing = true;
  }
}

//------------display screens---------------//
//menu screen
public void displayMenu() {
  //Title 
  textSize(50);
  fill(0, 0, 200);
  String  message1 = "Conflux";
  text(message1, width/2 - textWidth(message1)/2, height/2);

  //Message flag
  textSize(20);
  fill(0, 0, 200);
  String  message2 = "play";
  text(message2, width/2 - textWidth(message2)/2, height/2 + 60);
}

//result screen
public void displayResult() {
  textSize(50);
  fill(0, 0, 200);
  String  message1 = game.getResult();
  text(message1, width/2 - textWidth(message1)/2, height/2);
}