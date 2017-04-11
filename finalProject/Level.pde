
class Level {

  //number of row and col of the matrix map
  private int row;
  private int col;

  //the object goal to the next
  private int goal;

  //JSONObject files
  private JSONObject recordLevel;
  private JSONObject mapLevel;

  //the current position in the matrix 
  private int currentRow, currentCol;
  //the position of the end type node in the matrix
  private int endRow, endCol;
  //the map node matrix
  private Node[][] nodes;

  //public constructor
  public Level() {
  }

  //funtion that extracts and gets the map blueprint and returns it as integer matrix
  public int[][] extractMapLevel(int curLevel) {

    mapLevel = new JSONObject();
    mapLevel = loadJSONObject("level" + curLevel + ".json");
    row = mapLevel.getInt("row");
    col = mapLevel.getInt("col");
    goal = mapLevel.getInt("goal");
    JSONArray arrayMap = mapLevel.getJSONArray("map");
    int[] map = arrayMap.getIntArray();

    int[][] level = new int[row][col];

    int counter = 0;

    for (int r = 0; r < row; r++) {
      for (int c = 0; c < col; c++) {
        level[r][c] = map[counter];
        counter++;
      }
    }

    return level;
  }

  //function that fill the matrix randomly
  public int[][] generateMap(int r, int c) {

    //set row and col
    row = r;
    col = c;
    goal = -1;

    int map[][] = new int[r][c];

    //loop the map matrix and tempMatrix at the same time
    for (int row = 0; row < map.length; row++) {
      for (int col = 0; col < map[row].length; col++) {
        //randomly populating the matrix with value of 0, 1, 2, and 3.
        map[row][col] = int(random(0, 4));
      }
    }

    int x1 = int(random(map.length));
    int y1 = int(random(map[0].length));

    //set the position of the starting node
    map[x1][y1] = 4;

    currentRow = x1;
    currentCol = y1;

    //boolean flag for while loop
    boolean flag = true;

    //while the flag is true
    while (flag) {
      //position of the destination node
      int x2 = int(random(map.length));
      int y2 = int(random(map[0].length));

      //check the contain if it contain 4 -the starting node
      if (map[x2][y2] != 4) {
        //set the value
        map[x2][y2] = 5;

        //set the position of end 
        endRow=x2;
        endCol=y2;

        //set the flag to false
        flag = false;
      }
    }
    return map;
  }

  //funtion that transfers and sets the node matrix
  public Node[][] setMap(int[][] map) {

    //instantiate nodes matrix
    nodes = new Node[row][col];

    //padding offset 
    int paddingX = 50;
    int paddingY = 100;

    //offset between nodes
    float xoffset = (width- (paddingX * 2))/(map[0].length - 1) ;
    float yoffset = (height- (paddingY * 2))/(map.length - 1);

    //size of each node; the width and the height
    int nodeSize = 40;

    //traverse the matrix to extract the ID of each nodes from mapMatrix
    for (int row = 0; row < nodes.length; row++) {
      for (int col = 0; col < nodes[row].length; col++) {

        //calculating the x and y position for each node
        float x = (col * xoffset) + paddingX;
        float y = (row * yoffset) + paddingY;

        //check if the ID coresponds to SUBTRACTION type node
        if (map[row][col] == Type.SUBTRACTION.value) {
          nodes[row][col] = new Node(x, y, nodeSize, nodeSize, Type.SUBTRACTION);
        }

        //check if the ID coresponds to ADDITION type node
        if (map[row][col] == Type.ADDITION.value) {
          nodes[row][col] = new Node(x, y, nodeSize, nodeSize, Type.ADDITION);
        }  

        //check if the ID coresponds to MULTIPLICATION type node
        if (map[row][col] == Type.MULTIPLICATION.value) {
          nodes[row][col] = new Node(x, y, nodeSize, nodeSize, Type.MULTIPLICATION);
        }
        if (map[row][col] == Type.DIVISION.value) {
          nodes[row][col] = new Node(x, y, nodeSize, nodeSize, Type.DIVISION);
        }

        //check if the ID coresponds to ORIGIN type node
        if (map[row][col] == Type.ORIGIN.value) {
          nodes[row][col] = new Node(x, y, nodeSize, nodeSize, Type.ORIGIN);
          nodes[row][col].setActive(true);

          //set the position of currentRow and currentCol
          currentRow = row;
          currentCol = col;
        }

        //check if the ID coresponds to END type node
        if (map[row][col] == Type.END.value) {
          nodes[row][col] = new Node(x, y, nodeSize, nodeSize, Type.END);

          //set the position of endRow and and endCol
          endRow = row;
          endCol = col;
        }
      }
    }

    return nodes;
  }

  //getter function that gets the col size of the matrix
  public int getCol() {
    return col;
  }

  //getter function that gets the goal
  public int getGoal() {
    return goal;
  }


  //getter function that gets the row size of the matrix
  public int getRow() {
    return row;
  }


  //getter function that gets the currentLevel in the recordLevel file
  public int getCurrentLevel() {
    recordLevel = new JSONObject();
    recordLevel = loadJSONObject("recordLevel.json");
    return recordLevel.getInt("current");
  }


  //getter function that gets the currentCol
  public int getCurrentCol() {
    return currentCol;
  }


  //getter function that gets the currentRow
  public int getCurrentRow() {
    return currentRow;
  }


  //getter function that gets the endCol
  public int getEndCol() {
    return endCol;
  }


  //getter function that gets the endRow
  public int getEndRow() {
    return endRow;
  }


  //getter function that gets the max level in the recordLevel file
  public int getMaxLevel() {
    recordLevel = new JSONObject();
    recordLevel = loadJSONObject("recordLevel.json");
    return recordLevel.getInt("max");
  }

  //function that sets the new current level or max level
  public void setRecordLevel(int curLevel, int maxLevel) {
    recordLevel = new JSONObject();
    recordLevel.setInt("current", curLevel);
    recordLevel.setInt("max", maxLevel);
    saveJSONObject(recordLevel, "data/recordLevel.json");
  }

  //function that saves the node matrix into a new JSON file
  public void saveMap(Node nodes[][], int numRow, int numCol, int newGoal) {

    ////-----------------READING THE FILE----------------///
    //load the saved file and extract the max level value
    recordLevel = new JSONObject();
    recordLevel = loadJSONObject("recordLevel.json");


    ///-------------------SAVING THE MAP-----------------///

    //create a save file for the map
    JSONObject storeMap = new JSONObject();

    //set keys and values
    storeMap.setInt("row", numRow);
    storeMap.setInt("col", numCol);
    storeMap.setInt("goal", newGoal);


    int counter = 0; 

    //create a json array
    JSONArray mapLevel = new JSONArray();
    for (int row = 0; row < nodes.length; row++) {
      for (int col = 0; col < nodes[row].length; col++) {
        //store the id of node type in the JSONArray
        mapLevel.setInt(counter, nodes[row][col].getType().value);
        counter++;
      }
    }

    //set the array in the JSONObject
    storeMap.setJSONArray("map", mapLevel);

    //save the file
    saveJSONObject(storeMap, "data/level"+(getMaxLevel()+1)+".json");


    //update the highest level
    recordLevel.setInt("max", getMaxLevel()+1);
    //save it
    saveJSONObject(recordLevel, "data/recordLevel.json");
  }
}