class Pray extends GameObject {

  //Jellyfish by Leonardo Schneider from the Noun Project
  //Starfish by Elena Rimeikaite from the Noun Project
  //Fish by Roselin Christina.S from the Noun Project
  //Shark by Iconic from the Noun Project
  private PImage prayImg;

  //type of pray
  String type;

  Pray(float x, float y, String type) {
    super(0.0, x, y);

    //assign type value
    this.type = type;


    //cases if statement to determine which image to load 
    //and set values to topSpeed and mass 
    if (type == "dory") {
      prayImg = loadImage("dory.png");
      topSpeed = 2;
      mass = 2.0;
    }
    if (type == "star") {
      prayImg = loadImage("star.png");
      topSpeed = 1;
      mass = 5.0;
    }
    if (type == "jelly") {
      prayImg = loadImage("jelly.png");
      topSpeed = 3;
      mass = 10.0;
    }
    if (type == "shark") {
      prayImg = loadImage("shark.png");
      topSpeed = 5;
      mass = 18.0;
    }
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

  //check edge
  public void checkEdge() {

    if (location.x + 100 < 0) {
      resetLocation();
    }
  }

  //display image
  public void display() {
    imageMode(CENTER);
    image(prayImg, location.x, location.y);
  }

  //reset location when eaten or reached the edge
  public void resetLocation() {
    location = new  PVector(width + (random(50)), random(height));
  }

  //check collision between two images/rectangles
  public boolean intersect(Player p) {
    PVector player = p.getLocation();
    return player.x < location.x + prayImg.width &&
      player.x + p.getW() > location.x &&
      player.y < location.y + prayImg.height &&
      player.y + p.getH() > location.y;
  }
}