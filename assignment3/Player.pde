class Player extends GameObject {
  //Pufferfish by Catalina Montes from the Noun Project
  private PImage player;


  Player(float m, float x, float y) {
    super(m, x, y);

    //set top speed
    topSpeed = 10;

    //load image
    player = loadImage("player.png");
  }

  //update velocity --> location 
  public void update() {

    //add acceleration to velocity
    velocity.add(acceleration);

    //limit top speed of velocity
    velocity.limit(topSpeed);

    //update location
    location.add(velocity);
  }

  //display image 
  public void display() {
    imageMode(CORNER);
    image(player, location.x, location.y);
  }

  //handle and set key board input for player movement
  public void moveKeyPress() {

    if (keyPressed && keyCode == UP) {
      acceleration = new PVector(0, -0.1);
    } else if (keyPressed && keyCode == RIGHT) {
      acceleration = new PVector(0.1, 0);
    } else if (keyPressed && keyCode == DOWN) {
      acceleration = new PVector(0, 0.1);
    } else if (keyPressed && keyCode == LEFT) {
      acceleration = new PVector(-0.1, 0);
    } else {
      acceleration = new PVector(0, 0);
    }
  }

  //function that check edge
  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x += -1;
    } 

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    } else if (location.y + player.height< 0) {
      velocity.y *= -1;
      location.y =  -player.height;
    }
  }

  //check if player touches the left edge
  public boolean checkLeftEdge() {
    return location.x + player.width < 0;
  }

  //-----------------GETTERS FUNCTION--------------//
  public int getW() {
    return player.width;
  }

  public int getH() {
    return player.height;
  }
}