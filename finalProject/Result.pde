class Result {

  //variables that store mouse activities
  private boolean msPressed, msReleased, lockPress;

  //UI objects
  private UI messageText;
  private UI againButton;
  private UI menuButton;

  //public constructor
  public Result() {
    //set the mouse variable
    msPressed = false;
    msReleased = false;
    lockPress = false;
    //instantiate the UI
    messageText = new UI();
    againButton = new UI();
    menuButton = new UI();
  }

  //display the objects
  public void display() {
    //set the message 
    messageText.h1Text(width/2, int(height*.4), gameResult.toString());
    //display the buttons
    displayAgainButton();
    displayMenuButton();
  }

  //manage and display the againButton
  private void displayAgainButton() {

    //holder for text label for button
    String message = "";
    //check which text level to display
    if (gameResult == GameResult.CLEARED) {
      message = "next";
    } else {
      message = "again";
    }

    //check if mouse is over the button
    if (againButton.makeButton(message, int(width/2) - 40, int(height*.44), 80, 30)) {
      //check for the mouse click
      if (msPressed && !msReleased && !lockPress) {

        lockPress = true;

        //change gamestate and gameresult
        gameResult = GameResult.NONE;
        gameState = GameState.GAME;
      }
    }
    //reset lock pressed
    if (!mousePressed) {
      lockPress = false;
    }
  }

  //manage and display the menuButton
  private void displayMenuButton() {

    //check if mouse is over the button
    if (menuButton.makeButton("menu", int(width/2) - 40, int(height*.5), 80, 30)) {
      //check for mouse click
      if (msPressed && !msReleased && !lockPress) {

        lockPress = true;

        //change gamestate and gameresult
        gameResult = GameResult.NONE;
        gameState = GameState.MENU;
      }
    }
    //reset lock pressed
    if (!mousePressed) {
      lockPress = false;
    }
  }

//function that set the value of msPressed and msReleased
  public void setMousePressed(boolean p, boolean r) {
    //set the value
    msPressed = p;
    msReleased = r;
  }
}