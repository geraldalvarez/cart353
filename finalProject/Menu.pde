class Menu {

  //level - map blueprint
  private Level level;

  //UI texts and object
  private UI titleText;
  private UI playButton;
  private UI optionButton;
  private UI currLevelText; 
  private UI maxLevelText;

  //boolean variables for mouse activities
  private boolean msPressed, msReleased, lockPress; 

  //public constructir
  public Menu() {

    //instantiate objects
    level = new Level();
    titleText = new UI();
    playButton = new UI();
    optionButton = new UI();
    currLevelText = new UI();
    maxLevelText = new UI();
    
    //set default a value
    msPressed = false;
    msReleased = false;
    lockPress = false;
  }

  //function that displays the objects
  public void display() {
    titleText.h1Text(width/2, int(height*.4), "CONFLUX");
    currLevelText.h3Text(width/2, int(height*.6), "current level - " + level.getCurrentLevel());
    maxLevelText.h3Text(width/2, int(height*.63), "max level - " + level.getMaxLevel());

    displayPlayButton();
    displayOptionButton();
  }
  
  //function that handles and displays playBUtton
  private void displayPlayButton() {
    if (playButton.makeButton("play", int(width/2) - 40, int(height*.44), 80, 30)) {
      if (msPressed && !msReleased && !lockPress) {
        gameState = GameState.GAME;
        lockPress = true;
      }
    }
    if (!mousePressed) {
      lockPress = false;
    }
  }

  //funtion that handles and displays optionButton
  private void displayOptionButton() {
    if (optionButton.makeButton("option", int(width/2) - 40, int(height*.50), 80, 30)) {
      if (msPressed && !msReleased && !lockPress) {
        gameState = GameState.OPTION;
        lockPress = true;
      }
    }

    if (!mousePressed) {
      lockPress = false;
    }
  }

  //function that determines if the mouse is pressed or released
  public void setMousePressed(boolean p, boolean r) {
    msPressed = p;
    msReleased = r;
  }
}