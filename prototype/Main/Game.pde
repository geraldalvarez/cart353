class Game { //<>//
  //level
  private Level level;
  //current level
  private int currLvl;

  //conflux array
  private Conflux[][] nodes;
  //rift array
  private Rift[] lines;

  //maximum number lines in level 
  private int numOfLines;
  private int lineIndex;

  //game's initial energy and goal energy
  private int currEnergy;
  private int minGoalEnergy;
  private int maxGoalEnergy;

  //cuurent player's energy position x and y
  private float enX;
  private float enY;

  //boolean flag for mouse pressed and mouse release
  private boolean mpressed;
  private boolean mreleased;
  
  //boolean flag for single click
  private boolean lockBtn;

  //boolean flag to indicate the game is over
  private boolean gameOver;
  
  //string variable to know either won or lost
  private String result;

  //public constructor
  public Game() {

    //set mouse pressed and release value
    mpressed = false;
    mreleased = false;

    lockBtn = true;
    gameOver = false;
    
    result = "";

    //set the level
    currLvl = 2;

    //invoke setup
    setupGame();
  }

  //update function
  public void update() {
    createLine();
    
  }

  //display function
  void display() {
    displayObjects();
    displayScore();
  }//end of function


  //display game visual
  public void displayObjects() {

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

  public void createLine() {

    int x = mouseX;
    int y = mouseY;

    //set the next position of energy, and get the x and y location 
    float dEnX = copyNode(x, y).getX();
    float dEnY = copyNode(x, y).getY();


    //check mouse pointer collides with any nodes and the node is not taken
    if (mouseOverNodes(x, y) && !copyNode(x, y).isActive()) {


      //check if the mouse is pressed and lockBtn is true
      if (mpressed && !mreleased && lockBtn) {

        //check if the current move is possible
        if (isMovePossible(x, y, int(enX), int(enY))) {
          println("It is possible");

          //lock the click
          lockBtn= false;

          //set the next x and y for lines array
          lines[lineIndex].setDX(dEnX);
          lines[lineIndex].setDY(dEnY);

          //activate the current node
          setActiveNode(x, y, true);  

          //calculate energy
          calculateEnergy(x , y);

          //increment index position
          lineIndex++;

          //prevent indexoutofbounds
          if (lineIndex < lines.length) {
            //instantiating the next line in the array
            lines[lineIndex] = new Rift(dEnX, dEnY);
            //set the dx and dy position temporary
            lines[lineIndex].setDX(dEnX);
            lines[lineIndex].setDY(dEnY);
          }

          //pass the new location of energy
          enX = dEnX;
          enY = dEnY;
          
          //check game over state
          checkGameOver(x, y);
        } else {
          println("Distance is to far");
        }
      }
    } else {
      //set back the origin position of energy
      lines[lineIndex].setDX(enX);
      lines[lineIndex].setDY(enY);
    }


    //invert clicked lock
    if (!mousePressed) {
      lockBtn = true;
    }
  }

  public void calculateEnergy(int x, int y) {
    
    Conflux tempNode = copyNode(x, y);

    if (tempNode.getType() == "add") {
      currEnergy++;
    }

    if (tempNode.getType() == "sub") {
      currEnergy--;
    }
    
    if(tempNode.getType() == "mult"){
     currEnergy*=2; 
    }
    
      if(tempNode.getType() == "div"){
     currEnergy/=2; 
    }
  }

  //function that determines game over state
  public void checkGameOver(int x, int y){
   
    if(isDeadEndZone()){
      
    }else{
      
    }
    
    
    if(isAtEndGoal(x, y)){
      //set gameOver to true
      gameOver = true;
      //set message result
      result = "Level Cleared!";
      
      println("Level Completed");
    }else{
      
    }
  }

  //check if unable to progress further
  public boolean isDeadEndZone() {

    //try catch statement   
    try {
    }
    catch(IndexOutOfBoundsException e) {
      return false;
    }

    return false;
  }

  //function that checks if the user reached the goal 
  public boolean isAtEndGoal(int x, int y) {
    
    Conflux tempNode = copyNode(x, y);

    //check if the energy requirement is meet.
    return (currEnergy >= minGoalEnergy && currEnergy <= maxGoalEnergy) && tempNode.getType() == "end";
  }

  //determines if next move is possible
  public boolean isMovePossible(int xCurr, int yCurr, int xPrev, int yPrev) {

    //temp nodes to get col and row
    Conflux currNode = copyNode(xCurr, yCurr);
    Conflux prevNode = copyNode(xPrev, yPrev);

    //cuurent position in the matrix
    int col = getColPos(currNode);
    int row = getRowPos(currNode);

    //previous position in the matrix
    int pcol = getColPos(prevNode);
    int prow = getRowPos(prevNode);

    //check the move if it is within one step forward (neighbor of the current position)
    return (abs(col - pcol) == 1 && abs(row - prow) == 0) ||
      (abs(col - pcol) == 0 && abs(row - prow) == 1) ||
      (abs(col - pcol) == 1 && abs(row - prow) == 1);
  }

  //function that gets the col index of a node in the matrix
  public int getColPos(Conflux n) {

    int colPos  = -1;

    for (int row = 0; row < nodes.length; row++) {
      for (int col = 0; col < nodes[row].length; col++) {
        if (nodes[row][col].getX() == n.getX() && nodes[row][col].getY() == n.getY()) {
          colPos = col;
        }
      }
    }

    return colPos;
  }

  //function that gets the row index of a node in the matrix
  public int getRowPos(Conflux n) {

    int rowPos  = -1;

    for (int row = 0; row < nodes.length; row++) {
      for (int col = 0; col < nodes[row].length; col++) {
        if (nodes[row][col].getX() == n.getX() && nodes[row][col].getY() == n.getY()) {
          rowPos = row;
        }
      }
    }

    return rowPos;
  }

  //
  public void setActiveNode(int mx, int my, boolean b) {
    //loops through the matrix
    for (int row = 0; row < nodes.length; row++) {
      for (int col = 0; col < nodes[row].length; col++) {
        if (nodes[row][col].overConflux(mx, my)) {
          nodes[row][col].setActive(b);
        }
      }
    }
  }

  public Conflux copyNode(int mx, int my) {
    Conflux nodeTemp = new Conflux();
    //loops through the matrix
    for (int row = 0; row < nodes.length; row++) {
      for (int col = 0; col < nodes[row].length; col++) {
        if (nodes[row][col].overConflux(mx, my)) {
          nodeTemp = nodes[row][col];
        }
      }
    }  
    return nodeTemp;
  }

  public boolean mouseOverNodes(int mx, int my) {
    boolean flag = false;

    //loops through the matrix
    for (int row = 0; row < nodes.length; row++) {
      for (int col = 0; col < nodes[row].length; col++) {
        if (nodes[row][col].overConflux(mx, my)) {
          flag = true;
        }
      }
    }
    return flag;
  }

  //setup  the game
  public void setupGame() {
    //set the level maps
    setLevelMap();
  }

  //set level map layout
  public void setLevelMap() {

    level = new Level(currLvl);

    //temp matrix holder
    int[][] matrix = level.getLevel();

    //set the size of 2d array
    nodes = new Conflux[matrix.length][matrix[0].length];

    //space between object
    float xoffset = width/matrix[0].length;
    float yoffset = height/matrix.length;

    //set max num of lines
    numOfLines = matrix.length * matrix[0].length;

    //create the lines
    lines = new Rift[numOfLines];


    //set current energy
    currEnergy = 1;
    //set goal energy
    minGoalEnergy = 8;
    maxGoalEnergy = 10;

    //conflux size
    int size = 20;

    //loop to map the level matrix to conflux matrix
    for (int row = 0; row < nodes.length; row++) {
      for (int col = 0; col < nodes[row].length; col++) { 

        //instantiate the object at [row][col] index
        nodes[row][col] = new Conflux((col * xoffset) + xoffset/2, (row * yoffset) + yoffset/2, size, size, matrix[row][col]);

        //activate the origin type node
        if (nodes[row][col].getType() == "origin") {
          //set value to true
          nodes[row][col].setActive(true);

          //set the energy starting position
          enX = (col * xoffset) + xoffset/2;
          enY = (row * yoffset) + yoffset/2;

          //instantiating the first line
          lines[0] = new Rift(enX, enY);
          //set current index for line
          lineIndex = 0;
        }
      }
    }
  }


  //display the current energy and level goal
  public void displayScore() {
    //energy text display
    textSize(15);
    fill(0);
    String  message1 = "Energy: ";
    text(message1 +""+ currEnergy, width*.1, 30);

    //goal text displau
    String  message2 = "min: ";
    text(message2 +""+ minGoalEnergy, width*.6, 30);

    //goal text displau
    String  message3 = "max: ";
    text(message3 +""+ maxGoalEnergy, width*.8, 30);
  }

  //---------------Getter and Setter-------------------//
  
  public String getResult(){
    
   return result; 
  }
  
  public void setMousePressed(boolean p, boolean r) {
    mpressed = p;
    mreleased = r;
  }
}