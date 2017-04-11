
class Line extends GameObject {

  //properties
  //destination
  private float nextX;
  private float nextY;

  //public construction
  public Line(float x, float y) {
    super(x, y);
    //temporary set the next point to the x and y
    nextX = x ;
    nextY = y;
  }  

  //display funtion
  public void display() {
    stroke(255);
    strokeWeight(3);
    line(gameObject.x, gameObject.y, nextX, nextY);
  }
  
  //display function
  public void display(int strokeSize, color c) {
    stroke(c);
    strokeWeight(strokeSize);
    line(gameObject.x, gameObject.y, nextX, nextY);
  }
  //getter funtion that gets the next point of x
  public float getNextX() {
    return nextX;
  }

  //getter funtion that gets the next point of y
  public float getNextY() {
    return nextY;
  }

  //setter function that sets the next point of x
  public void setNextX(float dx) {
    this.nextX = dx;
  }

  //setter function that sets the next point of y
  public void setNextY(float dy) {
    this.nextY = dy;
  }
}