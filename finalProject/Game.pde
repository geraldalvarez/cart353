
class Game {

  //declare the level object
  Level level;

  //holder for current level
  int curLevel;

  //holder for max level
  int maxLevel;

  //declare the matrix node as known as game map
  Node[][] nodes;

  //holder for the starting and current position
  int currentRow, currentCol;

  //holder for the end position
  int endRow, endCol;

  //flag for mouse pressed and released
  boolean msPressed, msReleased, msDragged;

  ///action of dragging boolean
  boolean dragging;

  //flag to lock mousePressed
  boolean lockPress;

  //declare a line array
  Line[] lines;

  //counter for the number of instantiated line object
  int lineCounter;

  //temporary line
  Line tempLine;

  //the goal energy
  int goal;

  //the current energy
  int currentEnergy;

  //UI objects
  private UI levelText;
  private UI resetButton;
  private UI menuButton;
  private UI optionButton;


  //public constructor
  public Game() {


    //initialize the boolean variables
    msPressed = false;
    msReleased = false;
    msDragged = false;
    lockPress = false;
    dragging = false;

    initializeGame() ;

    println("goal "+goal);
    println("level "+curLevel);
    println("max level "+maxLevel);

    levelText = new UI();
    resetButton = new UI();
    menuButton = new UI();
    optionButton  = new UI();
  }

  private void initializeGame() {
    setGameLevel();
    setGameMap();
    setGameLines();
  }

  //display funtion
  public void display() {

    //display UIs
    levelText.h2Text(width/2, 40, "Lv. "+curLevel);
    displayResetButton();
    displayMenuButton();
    displayOptionButton();
    displayGoalBar();

    //display nodes and lines
    displayGameObject();
  }

  //update function
  public void update() {
    //check player's move every cycle
    checkPlayerMove();
    //check for game over situation
    checkGameOver();
  }

  //function that display nodes and lines
  private void displayGameObject() {
    if (tempLine != null) {
      //display the temporary node
      tempLine.display();
    }

    //display the lines
    for (int i = 0; i < lines.length; i++) {
      if (lines[i] != null) {
        lines[i].display();
      }
    }

    //display the nodes
    for (int row = 0; row < nodes.length; row++) {
      for (int col = 0; col < nodes[row].length; col++) {
        nodes[row][col].display();
      }
    }
  }

  //function that 
  private void displayGoalBar() {
    
    //parameters for the bar
    int x = 60;
    int y = 50;
    int w = 480;
    int h = 8;

    color c = color(255);
    
    //change the color of the bar when currentEnergy is negative or over the goal objective
    if (currentEnergy < 0 || currentEnergy > goal) {
      c = color(255, 100, 100);
    }
  
    noFill();
    stroke(c);
    rect(x, y, w, h, 5);
    
    //lines for the meter gauge
    Line[] xLines = new Line[goal];
    for (int i = 0; i < xLines.length; i++) {

      float xoffset = (w/goal);
      xLines[i] = new Line(x + xoffset + (xoffset * i), y);
      xLines[i].setNextX(x + xoffset + (xoffset*i));
      xLines[i].setNextY(y+h);
      xLines[i].display(1, c);
    }

    float gauge = 0;
    //constrain the gauge
    if (currentEnergy >= 0 && currentEnergy <= goal) {
      gauge = map(currentEnergy, 0, goal, 0, w);
    } 

    //the fill of the bar or gauge
    fill(c);
    rect(x, y, gauge, h, 5);
  }

  //function that handles and displays the menu button
  private void displayMenuButton() {
    if (menuButton.makeButton("  m", 10, 10, 20, 20)) {
      if (msPressed && !msReleased && !lockPress) {
        lockPress = true;
        gameState = GameState.MENU;
      }
    }

    if (!mousePressed) {
      lockPress = false;
    }
  }

  //function that handles and displays the option button
  private void displayOptionButton() {
    if (optionButton.makeButton("  o", width - 30, 10, 20, 20)) {
      if (msPressed && !msReleased && !lockPress) {
        lockPress = true;
        gameState = GameState.OPTION;
      }
    }

    if (!mousePressed) {
      lockPress = false;
    }
  }

  //function that handles and displays reset the button
  private void displayResetButton() {
    if (resetButton.makeButton(" reset", int(width*.50) - 30, height- 55, 60, 30)) {
      if (msPressed && !msReleased && !lockPress) {
        lockPress = true;
        initializeGame();
      }
    }

    if (!mousePressed) {
      lockPress = false;
    }
  }

  //function that handles player's moves
  private void checkPlayerMove() {

    //temporary line
    tempLine = new Line(nodes[currentRow][currentCol].getX(), nodes[currentRow][currentCol].getY());

    //loop the matrix to catch any activity from the the user
    for (int row = 0; row < nodes.length; row++) {
      for (int col = 0; col < nodes[row].length; col++) {
        //check for lockPress
        if (!lockPress) {
          //check for mouse dragged
          if (msDragged) {

            //check if the mouse pointer is on the current node.
            if (Mechanic.pointCircleCollision(nodes[row][col], mouseX, mouseY)) {
              dragging = true;
            }

            //check is the dragging is true
            if (dragging) {

              //set the next point (x and y position) 
              tempLine.setNextX(mouseX);
              tempLine.setNextY(mouseY);


              //check if mouse pointer is over a node AND
              //the player's move is possible AND
              //the node is not active
              if (Mechanic.pointCircleCollision(nodes[row][col], mouseX, mouseY) &&
                Mechanic.isMovePossible(row, col, currentRow, currentCol) &&
                !nodes[row][col].isActive()) {

                //add a line to the line array
                addLine(row, col);     

                //calcute the current energy
                currentEnergy = Mechanic.calculateEnergy(nodes[row][col], currentEnergy, row, col);

                //unable dragging
                dragging =false;
              }
            }
          } else {
            //set the dragging to false
            dragging = false;
          }

          //check mousePressed = true and mouseReleased = false AND dragging = false
          if (msPressed && !msReleased && !dragging) {

            //check if mouse pointer is over a node AND
            //the player's move is possible AND
            //the node is not active
            if (Mechanic.pointCircleCollision(nodes[row][col], mouseX, mouseY) &&
              Mechanic.isMovePossible(row, col, currentRow, currentCol) &&
              !nodes[row][col].isActive()) {

              //add a line to the line array
              addLine(row, col);

              //calcute the current energy
              currentEnergy = Mechanic.calculateEnergy(nodes[row][col], currentEnergy, row, col);

              //disable click
              lockPress = true;
            }
          }
        }

        //if mouse is not pressed
        if (!mousePressed) {
          //set the lock press to false;
          lockPress = false;
        }
      }//end inner loop
    }//end outer loop
  }

  //function that adds a line object in the array in the right index.
  private void addLine(int row, int col) {
    //instantiate a new line and set the next point
    lines[lineCounter] = new Line(nodes[currentRow][currentCol].getX(), nodes[currentRow][currentCol].getY());
    lines[lineCounter].setNextX(nodes[row][col].getX());
    lines[lineCounter].setNextY(nodes[row][col].getY());
    lineCounter++;

    //update currentRow and currentCol
    currentRow = row;
    currentCol = col;   

    //activating the node
    nodes[row][col].setActive(true);
  }

  //set the general variables for the game
  private void setGameLevel() {
    //instantiate level
    level = new Level();
    //set current level
    curLevel = level.getCurrentLevel();
    //set max level
    maxLevel = level.getMaxLevel();

    //set the starting energy
    currentEnergy = 0;
  }

  //set everything related to node matrix 
  private void setGameMap() {

    //get the map blueprint
    nodes = level.setMap(level.extractMapLevel(curLevel));

    //set the current row
    currentRow = level.getCurrentRow();
    //set the current col
    currentCol = level.getCurrentCol();
    //set the end row
    endRow = level.getEndRow();
    //set the end col
    endCol = level.getEndCol();

    //set the goal 
    goal = level.getGoal();
  }

  //set everything related to line object
  private void setGameLines() {

    //instantiate line array
    lines = new Line[nodes.length*nodes[0].length];
    //initialize the counter
    lineCounter = 0;
  }

  //function that checks the possible situation for game over
  private void checkGameOver() {

    //check if the goal is achieved
    if (Mechanic.hasReachedEnd(currentRow, currentCol, endRow, endCol)) {
      //check if the objective is achieved
      if (Mechanic.isGoalAchieved(goal, currentEnergy)) {
        //check if it is the last level
        if (Mechanic.isLastLevel(curLevel, maxLevel)) {
          //update and save new record
          level.setRecordLevel(1, maxLevel);

          initializeGame();

          //change game state and game result
          gameResult = GameResult.GAMEOVER;
          gameState = GameState.RESULT;
        } else {
          initializeGame();

          //update and save new record
          level.setRecordLevel(curLevel+1, maxLevel);

          //change game state and game result
          gameResult = GameResult.CLEARED;
          gameState = GameState.RESULT;
        }
      } else {
        initializeGame();
        //change game state and game result
        gameResult = GameResult.FAILED;
        gameState = GameState.RESULT;
      }
    }

    //check dead end
    if (Mechanic.isDeadEnd(nodes, currentRow, currentCol)) {
      initializeGame();
      //change game state and game result
      gameResult = GameResult.DEADEND;
      gameState = GameState.RESULT;
    }
  }

  //function that determines if the mouse is pressed or released
  public void setMousePressed(boolean p, boolean r) {
    msPressed = p;
    msReleased = r;
  }

  //function that determines if the mouse is dragged
  public void setMouseDragged(boolean d) {
    msDragged = d;
  }
}