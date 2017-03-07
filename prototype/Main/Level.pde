class Level {

  private int currLvl;

  //public constructor
  public Level(int level) {

    //set level
    currLvl = level;
  }

  public int[][] getLevel() {

//    if (num == 0) type = "sub";
//    if (num == 1) type = "add";
//    if (num == 2) type = "mult";
//    if (num == 3) type = "div";
//    if (num == 4) type = "origin";
//    if (num == 5) type = "end";

    int[][] level = new int[1][1];

    switch(currLvl) {

    case 1: 
      //level one 
      int[][] tempLvl1 = {
        {4, 0, 0}, 
        {1, 1, 1}, 
        {0, 0, 5}
      };
      level = tempLvl1;
      break;

    case 2:
      //level two
      int[][] tempLvl2 = {
        {0, 1, 0, 0}, 
        {1, 3, 1, 2}, 
        {0, 1, 4, 5}
      };
      level = tempLvl2;
      break;

    default:
      println("Invalid Input");
      break;
    }

    return level;
  }
}