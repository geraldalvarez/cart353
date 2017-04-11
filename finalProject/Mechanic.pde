static class Mechanic {

  //function that checks if the mouse pointer is on the node and returns a boolean value
  static public boolean pointCircleCollision(Node node, int xMouse, int yMouse) {
    return dist(node.getX(), node.getY(), xMouse, yMouse) < node.getW()/2;
  }  
  
  //function that checks if the mouse pointer is on the rect and return a boolean value{
   static public boolean pointRectangleCollision(int rectx, int recty, int rectw, int recth, int msx, int msy){
     return (msx >= rectx && msx <= rectx + rectw) && (msy >= recty && msy <= recty + recth);
  }

  //function that verifies if the current position is dead end.
  static public boolean isDeadEnd(Node[][] nodes, int currentRow, int currentCol) {
    int inactiveNodes = 0;

    //check the surronding of the position in the matrix; hence, it checks 8 elements(cases).
    for (int i = 0; i < 8; i++) {
      if (isNodeActive(nodes, i, currentRow, currentCol)) {
        inactiveNodes++;
      }
    }
    return inactiveNodes == 8;
  }

  //function that checks a specific cell or element in the matrix if it is active and returns the result. 
  static private boolean isNodeActive(Node[][] nodeMap, int casePos, int row, int col) {

    boolean activeNode = true;

    //try-catch statement to prevent Index out of bound error.
    try {

      //top-left corner
      if (casePos == 0 && !nodeMap[row-1][col-1].isActive()) {
        activeNode = false;
      }
      //top
      if (casePos == 1 && !nodeMap[row][col-1].isActive()) {
        activeNode = false;
      }
      //top-right corner
      if (casePos == 2 && !nodeMap[row+1][col-1].isActive()) {
        activeNode = false;
      }
      //right
      if (casePos == 3 && !nodeMap[row+1][col].isActive()) {
        activeNode = false;
      }
      //right-bottom corner
      if (casePos == 4 && !nodeMap[row+1][col+1].isActive()) {
        activeNode = false;
      }
      //bottom
      if (casePos == 5 && !nodeMap[row][col+1].isActive()) {
        activeNode = false;
      }
      //bottom-left corner
      if (casePos == 6 && !nodeMap[row-1][col+1].isActive()) {
        activeNode = false;
      }
      //left
      if (casePos == 7 && !nodeMap[row-1][col].isActive()) {
        activeNode = false;
      }
    }
    catch(IndexOutOfBoundsException e) {
      //println("out of bound");
    }

    return activeNode;
  }


  //function that validates the players move.
  static public boolean isMovePossible(int row, int col, int prow, int pcol) {
    //check if the user's move is within one step from the current position (neighbor of the current position)
    return (abs(col - pcol) == 1 && abs(row - prow) == 0) ||
      (abs(col - pcol) == 0 && abs(row - prow) == 1) ||
      (abs(col - pcol) == 1 && abs(row - prow) == 1);
  }


  //function that checks if the player reached the end position
  static public boolean hasReachedEnd(int currentRow, int currentCol, int endRow, int endCol) {
    return currentRow == endRow && currentCol == endCol;
  }

  //function that verifies if the player achieved the objective.
  static public boolean isGoalAchieved(int goal, int currentEnergy) {

    //check if the objective is achieved.
    return goal == currentEnergy;
  }
  
  //function that determines if the level is the last
  static public boolean isLastLevel(int curLevel, int maxLevel){
   return  curLevel == maxLevel;
  }


  //function that manages the energy calculation
  static public int  calculateEnergy(Node nodes, int currentEnergy, int row, int col) {

    int calculatedEnergy = currentEnergy;

    //check which type is in the current position in the nodes matrix
    if (nodes.getType() == Type.SUBTRACTION) {
      //subtracts a value 
      calculatedEnergy -= Modifier.SUBTRACTION.value;
    }
    if (nodes.getType() == Type.ADDITION) {
      //adds  a value
      calculatedEnergy += Modifier.ADDITION.value;
    }
    if (nodes.getType() == Type.DIVISION) {
      //divides the value by 2
      calculatedEnergy /= Modifier.DIVISION.value;
    }
    if (nodes.getType() == Type.MULTIPLICATION) {
      //multiple the value by 2
      calculatedEnergy *= Modifier.MULTIPLICATION.value;
    }
    
    println(calculatedEnergy);
    return calculatedEnergy;
  }
}