class Food extends GameObject {

  //Bacteria by Maxim Kulikov from the Noun Project
  private PImage foodImg;
  
   Food(float x, float y) {
    super(0.3, x, y);
    
    //set top speed
    topSpeed = 4;
    
    //load image
    foodImg = loadImage("food.png");
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
  
  //check if object meets the edge
  public void checkEdge() {
    if (location.x+15 < 0) {
      resetLocation();
    }
  }

  //display an ellipse
  public void display() {
    imageMode(CORNER);
   image(foodImg, location.x, location.y);
  }
  
   //reset location when eaten or reached the edge
  public void resetLocation() {
    location = new  PVector(width + (random(20)), random(height));
  }

  
  //check collision between two images/rectangles
  public boolean intersect(Player p){
     PVector player = p.getLocation();
    return player.x < location.x + foodImg.width &&
            player.x + p.getW() > location.x &&
            player.y < location.y + foodImg.height &&
            player.y + p.getH() > location.y;
  }
}