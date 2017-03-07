class Rift extends GameObject {

  //properties
  //destination
  private float dx;
  private float dy;


  //public construction
  public Rift(float x, float y) {
    super(x, y);
    dx = x;
    dy = y;
  }  
  
  //display funtion
  public void display(){
   stroke(0);
   strokeWeight(2);
   line(x, y, dx, dy);
  }

  //GETTERS
  public float getDX() {
    return dx;
  }

  public float getDY() {
    return dy;
  }

  //SETTER
  public void setDX(float dx) {
    this.dx = dx;
  }

  public void setDY(float dy) {
    this.dy = dy;
  }
  
}