//enum class that holds the types of nodes and its ID. 
public enum Type {
  SUBTRACTION(0), ADDITION(1), MULTIPLICATION(2), DIVISION(3), ORIGIN(4), END(5); 

  private int value;

  private Type(int v) {
    value = v;
  }
}

//enum class that holds the value of type's properties.
public enum Modifier {
  SUBTRACTION(1), ADDITION(1), MULTIPLICATION(2), DIVISION(2), ORIGIN(0), END(0); 

  private int value;

  private Modifier(int v) {
    value = v;
  }
}

//enum class that categorizes the different states of the application
public enum GameState {
  MENU, GAME, RESULT, OPTION, EDITOR;
}

//enum class that identifies ways of ending a game.
public enum GameResult {
  NONE, DEADEND, CLEARED, FAILED, GAMEOVER;
}