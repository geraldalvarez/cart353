class Hazard {
  //Image: waves by Jacqueline Fernandes from the Noun Project
  private PImage wave;

  //position
  private float x, y;

  //num of step x
  private float steps;

  //coefficient of drag  
  private float c;

   Hazard(float x, float y, float c) {

    //passing values
    this.x = x;
    this.y = y;
    this.c = c;

    //set value for top speed
    steps = 2; 
    
    //load image
    wave = loadImage("wave.png");
  }

  //update steps
  public void update() {
    //check left boundary 
    if (x+(wave.width) < 0) {
      //reposition x position
      x = width +  wave.width + random(100);
    } else {
      //update x position 
      x -= steps;
    }
  }

  //display image
  public void display() {
    imageMode(CORNER);
    image(wave, x, y);
  }

    //check collision between two images/rectangles
  public boolean intersect(Player p){
     PVector player = p.getLocation();
    return player.x < x + wave.width &&
            player.x + p.getW() > x &&
            player.y < y + wave.height &&
            player.y + p.getH() > y;
  }

  //apply drag force on GameObject object
  public PVector drag(GameObject obj) {
    
    //creating physic of drag force
    float area = obj.getMass() * 16 * 0.1;
    float speed = obj.getVelocity().mag();
    float dragMagnitude = c * speed * speed * area;

    //get a copy of velocity 
    PVector dragForce = obj.getVelocity().get();
    //invert direction
    dragForce.mult(-1);
    dragForce.normalize();
    dragForce.mult(dragMagnitude);

    return dragForce;
  }
}