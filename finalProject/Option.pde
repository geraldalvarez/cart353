class Option {

  //variables that store mouse activities
  private boolean msPressed, msReleased, lockPress;

  //UI objects
  private UI titleText;
  private UI menuButton;

  //public constructor
  public Option() { 
    //set the initial value 
    msPressed = false;
    msReleased = false;
    lockPress = false;

    //instantiate the UI objecy
    titleText = new UI();
    menuButton = new UI();
  }
  
  //function that displays the objects
  public void display() {
    //display the text
    titleText.h2Text(width/2, int(height*.1), "  Need Help?");
    //display the menu button
    displayMenuButton();
  }
  
  //function that handles and display the button
  private void displayMenuButton() {
    //check if mouse is over the button
    if (menuButton.makeButton(" menu", width/2 - 30, height-80, 60, 30)) {
      //check for mouse activity
      if (msPressed && !msReleased && !lockPress) {
        lockPress = true;
        
        //change gamestate
        gameState = GameState.MENU;
      }
    }

    if (!mousePressed) {
      lockPress = false;
    }
  }

//function that sets msPressed and msReleased
  public void setMousePressed(boolean p, boolean r) {
    //set boolean value to msPressed and msReleased
    msPressed = p;
    msReleased = r;
  }
}