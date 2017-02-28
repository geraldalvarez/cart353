class GameObject {
  protected PVector location;
  protected PVector velocity;
  protected PVector acceleration;

  protected float mass;
  protected int baseSize;
  protected int topSpeed;

  GameObject( float m, float x, float y) {
    mass = m;
    baseSize = 15;
    //set default value for top speed
    topSpeed = 3;
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  //apply/add force to the vector
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

 
  
  //add mass accoding to a
  public void addMass(float a) {
    mass += a;
  }

  //------------GETTERS FUNCTIONS-----------//

  public PVector getLocation() {
    return location;
  }

  public PVector getAcceleration() {
    return acceleration;
  }

  public PVector getVelocity() {
    return velocity;
  }

  public float getMass() {
    return mass;
  }
}