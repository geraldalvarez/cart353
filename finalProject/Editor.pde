class Editor {

  //declare the level object
  Level level;

  //holder for max level
  int newMaxLevel;

  //declare the matrix node as known as game map
  Node[][] nodes;

  //holder for the starting and current position
  int currentRow, currentCol;

  //position of the ORIGIN type of node
  int originRow, originCol;

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

  //the current energy
  int currentEnergy;

  //size of the matrix
  int row, col;

  UI maxLevelText;
  UI rowText, colText;
  UI rowPlusButton, rowMinusButton, colPlusButton, colMinusButton;
  UI saveButton, refreshButton;
  UI energyText;


  //public constructor
  public Editor() {

    //default and minimun size of the matrix
    row = 3;
    col = 3;

    //initialize the boolean variables
    msPressed = false;
    msReleased = false;
    msDragged = false;
    lockPress = false;
    dragging = false;

    //initialize the UI
    setUI();

    //initialize the editor
    initializeEditor(row, col);
  }

  public void initializeEditor(int r, int c) {
    setGameLevel();
    setGameMap(r, c);
    setGameLines();
  }

  public void display() {

    displayRefresh();
    displayMaxLevel();
    displayRow();
    displayCol();
    displaySave();
    displayEnergy();

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

  public void update() {
    //check player's move every cycle
    checkPlayerMove();
  }

  private void displayRow() {
    rowText.h3Text(int(width*.2), 45, "row : "+ row);

    if (rowPlusButton.makeButton("+", int(width*.27), 30, 20, 20)) {
      if (msPressed && !msReleased && !lockPress) {

        if (row < 10)
          row++;

        lockPress = true;
      }
    }

    if (rowMinusButton.makeButton("-", int(width*.1), 30, 20, 20)) {
      if (msPressed && !msReleased && !lockPress) {

        if (row > 3)
          row--;

        lockPress = true;
      }
    }

    if (!mousePressed) {
      lockPress = false;
    }
  }

  private void displayCol() {
    colText.h3Text(int(width*.8), 45, "col : "+ col);

    if (colPlusButton.makeButton("+", int(width*.87), 30, 20, 20)) {
      if (msPressed && !msReleased && !lockPress) {

        if (col < 10)
          col++;

        lockPress = true;
      }
    }

    if (colMinusButton.makeButton("-", int(width*.7), 30, 20, 20)) {
      if (msPressed && !msReleased && !lockPress) {

        if (col > 3)
          col--;

        lockPress = true;
      }
    }

    if (!mousePressed) {
      lockPress = false;
    }
  }

  private void displayMaxLevel() {
    maxLevelText.h2Text(width/2, 50, "Level " + newMaxLevel);
  }
  
  private void displayEnergy(){
   energyText.h2Text(width/2, height - 30, "new goal:  " + currentEnergy); 
  }

  private void displaySave() {
    if (saveButton.makeButton("save", int(width*.20) - 30, height- 55, 60, 30)) {
      if (msPressed && !msReleased && !lockPress) {
        lockPress = true;
        //save the map
        saveLevelMap();
        //reset the game
        initializeEditor(row, col);
      }
    }

    if (!mousePressed) {
      lockPress = false;
    }
  }


  //function that reset the editor
  private void displayRefresh() {
    if (refreshButton.makeButton("reset", int(width*.80) - 30, height- 55, 60, 30)) {
      if (msPressed && !msReleased && !lockPress) {
        lockPress = true;
        initializeEditor(row, col);
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

    //instantiate new line and set the next point 
    lines[lineCounter] = new Line(nodes[currentRow][currentCol].getX(), nodes[currentRow][currentCol].getY());
    lines[lineCounter].setNextX(nodes[row][col].getX());
    lines[lineCounter].setNextY(nodes[row][col].getY());

    //update counter
    lineCounter++;

    //update current row and col
    currentRow = row;
    currentCol = col;

    //activating the node
    nodes[row][col].setActive(true);
  }

  void setUI() {
    maxLevelText = new UI();
    rowText = new UI();
    colText = new UI();
    rowPlusButton = new UI();
    rowMinusButton = new UI();
    colPlusButton = new UI();
    colMinusButton = new UI();
    saveButton = new UI();
    refreshButton = new UI();
    energyText = new UI();
  }

  //function that sets the level class related
  private void setGameLevel() {
    //instantiate level
    level = new Level();
    //set max level 
    newMaxLevel = level.getMaxLevel() + 1;
    //set the starting energy
    currentEnergy = 0;
  }

  //function that sets the game map
  private void setGameMap(int r, int c) {
    nodes = level.setMap(level.generateMap(r, c));
    currentRow = level.getCurrentRow();
    currentCol = level.getCurrentCol();
    originRow = currentRow;
    originCol = currentCol;
    endRow = level.getEndRow();
    endCol = level.getEndCol();
  }

  //function that initializes the line array.
  private void setGameLines() {

    //initialize the size of line array
    lines = new Line[nodes.length*nodes[0].length];
    //initialize the counter
    lineCounter = 0;
  }

  //function that save the map in the file
  private void saveLevelMap() {
    //check if the current position meets the end position 
    if (Mechanic.hasReachedEnd(currentRow, currentCol, endRow, endCol)) {
      println("saved");
      level.saveMap(nodes, row, col, currentEnergy);
      level.setRecordLevel(level.getCurrentLevel(), newMaxLevel);
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