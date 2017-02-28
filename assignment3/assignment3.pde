//create player object
Player player;

//create Hazard array
Hazard[] streams = new Hazard[3];

//create pray array
Pray[] prays = new Pray[17];

//create food array
Food[] foods = new Food[10];

//perlin noise y off
float yoff;

//starting flag
boolean start;

//game runnong flag
boolean inGame;

void setup() {
  size(1000, 800);
  //instantiating player
  player = new Player(5, width/2, height*.35);

  //manually instantiating hazard array
  streams[0] = new Hazard(0, 100, 0.1);
  streams[1] = new Hazard(width/2, height/2, 0.1);
  streams[2] = new Hazard(width-50, height-100, 0.1);

  //instantiating pray array
  for (int p = 0; p < prays.length; p++) {

    if (p >= 0 && p <=7) {
      //instantiating dory type
      prays[p] = new Pray(random(width), random(height), "dory");
    } else if (p >= 8 && p <=12) {
      //star type
      prays[p] = new Pray(random(width), random(height), "star");
    } else if ((p >= 13 && p <=15)) {
      //jelly type
      prays[p] = new Pray(random(width), random(height), "jelly");
    } else {
      //shark type
      prays[p] = new Pray(random(width), random(height), "shark");
    }
  }

  //instantiating food array
  for (int i = 0; i < foods.length; i++) {
    foods[i] = new Food(random(width), random(height));
  }

  //set value for y off
  yoff = 1000.0;

  //set value;
  start = false;
  inGame = false;
}


void draw() {
  background(186, 228, 228);

  //current force 
  PVector current = new PVector(-0.01, 0);

  //loop pray array
  for (int p = 0; p < prays.length; p++) {

    //check collision for player and pray AND inGame is true
    if (prays[p].intersect(player) && inGame) {

      if (player.getMass() > prays[p].getMass()) {
        prays[p].resetLocation();
        player.addMass(prays[p].getMass()/4);//consume one fourth the mass of the pray
      } else {
        player.addMass(-.1);
      }
    }

    prays[p].applyForce(current);
    prays[p].update();
    prays[p].display();
    prays[p].checkEdge();
  }

  //loop food array
  for (int j = 0; j < foods.length; j++) {

    //check collision for player and food AND inGame is true
    if (foods[j].intersect(player) && inGame) {
      foods[j].resetLocation();
      player.addMass(foods[j].getMass());
    }

    //perlin fx
    PVector perlin = new PVector(0, map(noise(yoff), 0, 1, -0.005, 0.005));


    foods[j].applyForce(perlin);
    foods[j].applyForce(current);
    foods[j].update();
    foods[j].display();
    foods[j].checkEdge();
  }

  //set move of player
  player.moveKeyPress();

  //loop streams array
  for (int i = 0; i < streams.length; i++) {

    //update stream
    streams[i].update();
    //display stream
    streams[i].display();

    //check collision for player and stream AND inGame is true
    if (streams[i].intersect(player) && inGame) {
      //Stream drag force
      PVector streamF = streams[i].drag(player);
      player.applyForce(streamF);
    }
  }

  //apply current to player
  player.applyForce(current);

  //update player
  player.update();
  //display player
  player.display();
  //check edges
  player.checkEdges();

  //display wining condition
  textSize(20);
  fill(67, 95, 46);
  text("Current mass: " + nf(player.getMass(), 2, 2) + "/20.0", 15, 25);


  //check game over
  //player won
  if (inGame) {
    if (player.getMass() > 20.0) {
      textSize(50);
      fill(0, 0, 200);
      String  message = "You Survived!";
      text(message, width/2 - textWidth(message)/2, height/2);
    } else if (player.checkLeftEdge() || player.getMass() < 0.0) {
      textSize(50);
      fill(0, 0, 200);
      String  message = "YOU DIED! TRY AGAIN.";
      text(message, width/2 - textWidth(message)/2, height/2);
    }
  }

  if (!start) {
    textSize(50);
    fill(0, 0, 200);
    String  message1 = "Press space bar to start.";
    text(message1, width/2 - textWidth(message1)/2, height/2);

    textSize(25);
    fill(0, 0, 220);
    String  message2 = "Use arrow keys to move";
    text(message2, width/2 - textWidth(message2)/2, height/2 + 30);
  }
}

void keyPressed() {
  //start the game when space bar is pressed
  if (keyCode == 32 && !inGame) {
    start = true;
    inGame = true;
  }
}