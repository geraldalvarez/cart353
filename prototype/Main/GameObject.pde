class GameObject {

  //Properties
  protected float x;
  protected float y;
  protected float w;
  protected float h;
  protected String type;
  protected boolean active;

  //color
  protected color c;

  //public constructor
  public GameObject(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public boolean isActive(){
    return active;
  }

  public color getColor(){
   return c; 
  }

  public String getType() {
    return type;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }
  
  public float getW(){
    return w;
  }
  
  public float getH(){
    return h; 
  }
  
  //---------------------------------Setters----------------------------------
  
  public void setActive(boolean active){
   this.active = active; 
  }

  public void setColor(color c) {
    this.c = c;
  }

  public void setType(String type) {
    this.type = type;
  }
  
  public void setX(int x){
    this.x = x; 
  }
  
    public void setY(int y){
    this.y = y; 
  }
  
  public void setW(int w){
   this.w = w; 
  }
  
  public void setH(int h){
   this.h = h; 
  }

}