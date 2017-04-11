//game state of the game
GameState gameState;
//game result state
GameResult gameResult;

//game screens
Menu menu;
Game game;
Result result;
Option option;
Editor editor;


//setup funtion
void setup() {
  size(600, 700);  
  
  //set the initial state of the game
  gameState = GameState.MENU;
  gameResult = GameResult.NONE;

//instantiate the screens
  menu = new Menu();
  game = new Game();
  result = new Result();
  option = new Option();
  editor = new Editor(); 
}

//draw function
void draw() {
  background(26,31,43);
  
  ////checking which state to draw the screen
  if (gameState == GameState.MENU) {
    menu.display();
  }
  if (gameState == GameState.GAME) {
    game.display();
    game.update();
  }
  if (gameState == GameState.RESULT) {
    result.display();
  }
  if (gameState == GameState.OPTION) {
    option.display();
  }
  if (gameState == GameState.EDITOR) {
    editor.display();
    editor.update();
  }
}

//event handler for mouse pressed
public void mousePressed() {
  
  ////check which state to set
  if (gameState == GameState.MENU) {
    menu.setMousePressed(true, false);
  }
  if (gameState == GameState.GAME) {
    game.setMousePressed(true, false);
  }
  if (gameState == GameState.RESULT) {
    result.setMousePressed(true, false);
  }
  if (gameState == GameState.OPTION) {
    option.setMousePressed(true, false);
  }
  if (gameState == GameState.EDITOR) {
    editor.setMousePressed(true, false);
  }
}

//event listener for mouse released
public void mouseReleased() {
  
  ////check which state to set
  if (gameState == GameState.MENU) {
    menu.setMousePressed(false, true);
  }
  if (gameState == GameState.GAME) {
    game.setMousePressed(false, true);
    game.setMouseDragged(false);
  }
  if (gameState == GameState.RESULT) {
    result.setMousePressed(false, true);
  }
  if (gameState == GameState.OPTION) {
    option.setMousePressed(false, true);
  }
  if (gameState == GameState.EDITOR) {
    editor.setMousePressed(false, true);
    editor.setMouseDragged(false);
  }
}

//event listener for mouse dragged 
public void mouseDragged() {
  
  ////check which state to set
  if (gameState == GameState.GAME) {
    game.setMouseDragged(true);
  }
  if (gameState == GameState.EDITOR) {
    editor.setMouseDragged(true);
  }
}