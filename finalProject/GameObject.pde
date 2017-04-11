
class GameObject {

  //Properties
  protected PVector gameObject;
  protected float w;
  protected float h;
  protected int rowPos;
  protected int colPos;
  protected Type type;
  protected boolean active;

  //color
  protected color c;

  //public constructor
  public GameObject(float x, float y) {
    gameObject = new PVector(x, y);
    c = color(255);
  }

////---------------GETTER FUNCTION---------------//
  public boolean isActive() {
    return active;
  }

  public color getColor() {
    return c;
  }

  public Type getType() {
    return type;
  }

  public float getX() {
    return gameObject.x;
  }

  public float getY() {
    return gameObject.y;
  }

  public float getW() {
    return w;
  }

  public float getH() {
    return h;
  }


////----------------------SETTER FUNCTION-------------------///
  public void setActive(boolean active) {
    this.active = active;
  }

  public void setColor(color c) {
    this.c = c;
  }

  public void setType(Type type) {
    this.type = type;
  }

  public void setX(float x) {

    this.gameObject.x = x;
  }
  public void setY(float y) {

    this.gameObject.y = y;
  }

  public void setW(float w) {
    this.w = w;
  }

  public void setH(float h) {
    this.h = h;
  }

  public void setRowPos(int row) {
    rowPos = row;
  }

  public void setColPos(int col) {
    colPos = col;
  }
}