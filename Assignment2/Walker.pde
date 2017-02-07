class Walker {
  private float x, y;
  private float sd;
  private Random generator;

  public Walker() {
    x = width/2;
    y = height/2;
    //standard deviation 
    sd = 5;
    generator = new Random();
  }
  
  //function that calculate steps for walker
  public void step(){
  
    //map step using gaussian method
    float xdir = (float)generator.nextGaussian() * sd;
    float ydir = (float)generator.nextGaussian() * sd;
    
    //update x and y 
    x += xdir;
    y += ydir;
    
    //constrain
    x = constrain(x , 0, width-1);
    y = constrain(y, 0, height - 1);
  }
   
   //function that display the walker
  public void display(){
    noStroke();
    fill(100);
    ellipse(x,y,10,10);
  }
  
  //function that get x
  public float getX(){
    return x;
    
  }
  
  //function that get y
  public float getY(){
    return y;
    
  }
  
}