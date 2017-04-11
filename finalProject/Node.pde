class Node extends GameObject {

  //PImage 
  private PImage image1, image2;


  //public construction
  public Node(float x, float y, float w, float h, Type aType) {
    super(x, y);
    this.type = aType;
    this.w = w;
    this.h = h;
    this.active = false;

    //set a default color
    this.c = color(255);
    
    //set the images
    setImages();
  }

  //function that display the objects
  public void display() {
    noStroke();
    fill(getFillColor(type));

    //draw ellipse
    ellipse(gameObject.x, gameObject.y, w, h);

    if (active) {
      image(image2, gameObject.x-(w/2), gameObject.y - (h/2));
    } else {
      image(image1, gameObject.x-(w/2), gameObject.y - (h/2));
    }
  }

  //funtion that sets the color according to the type of nodes
  private color getFillColor(Type type) {

    color c = color(255);

    if (type == Type.SUBTRACTION) c = color(255, 161, 201);
    if (type == Type.ADDITION) c = color(255, 127, 150);
    if (type == Type.MULTIPLICATION) c = color(151,128, 227);
    if (type == Type.DIVISION) c = color(78, 109, 210);
    if (type == Type.ORIGIN || type == Type.END) c = color(148, 213, 224);

    return c;
  }

  //function that instantiates and sets the kind of image for the node
  private void setImages() {

    image1 = new PImage();
    image2 = new PImage();

    if (type == Type.SUBTRACTION) {
      image1 = loadImage("img0.png");
      image2 = loadImage("img5.png");
    }
    if (type == Type.ADDITION) {
      image1 = loadImage("img1.png");
      image2 = loadImage("img6.png");
    }
    if (type == Type.MULTIPLICATION) {
      image1 = loadImage("img2.png");
      image2 = loadImage("img7.png");
    }
    if (type == Type.DIVISION) {
      image1 = loadImage("img3.png");
      image2 = loadImage("img8.png");
    }
    if (type == Type.ORIGIN || type == Type.END) {
      image1 = loadImage("img4.png");
      image2 = loadImage("img9.png");
    }

    image1.resize(int(w), int(h));
    image2.resize(int(w), int(h));
  }
}