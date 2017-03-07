class Conflux extends GameObject {


  //public construction
  public Conflux(float x, float y, float w, float h, int numType) {
    super(x, y);
    type = getType(numType);
    this.w = w;
    this.h = h;
    this.active = false;
    this.c = color(232, 147, 60);
  }
  
  //public dummy constructor
  public Conflux(){
    super(0,0);
  }

  void display() {
    //check if active
    if (super.isActive()) {
      strokeWeight(3);
      stroke(super.getColor());
    } else {
      strokeWeight(1);
      stroke(0);
    }

    fill(getFillColor(type));

    //draw ellipse
    ellipse(x, y, w, h);

    //TEMP text
    fill(0);
    if (type == "sub") text("s", x + 5, y - 5);
    if (type == "add") text("a", x+ 5, y- 5);
    if (type == "mult") text("m", x+ 5, y- 5);
    if (type == "div") text("d", x+ 5, y- 5);
  }
  
  
  //check square point collision
  //public boolean overConflux(int xm, int ym) {    
  //  return ym > y && ym < y + h &&
  //    xm > x && xm < x + w;
  //}
  
  //check circle-point collision
  public boolean overConflux(float mx, float my){
    float r = w/2;
    return dist(x,y,mx,my) < r;
  }

  //type of conflux
  public String getType(int num) {

    String type = "";

    if (num == 0) type = "sub";
    if (num == 1) type = "add";
    if (num == 2) type = "mult";
    if (num == 3) type = "div";
    if (num == 4) type = "origin";
    if (num == 5) type = "end";

    return type;
  }

  public color getFillColor(String type) {

    color c = color(255);

    if (type == "sub") c = color(221, 140, 150);
    if (type == "add") c = color(6, 53, 100);
    if (type == "mult") c = color(95, 74, 122);
    if (type == "div") c = color(217, 93, 122);
    if (type == "origin") c = color(232, 222, 180);
    if (type == "end") c = color(232, 174, 46);

    return c;
  }
 
}