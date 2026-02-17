Engine engine;
Engine ghostEngine;
Player player;
Player ghostPlayer;
ArrayList<Hole> holes;
boolean mouse_Moved = false;
boolean firstTime = true;

void setup() {
  size(1000, 500);
  windowMove(2300, 100);
  //fullScreen();
  //colorMode(HSB,100);
  holes = new ArrayList();
  engine = new Engine(5);
  ghostEngine = new Engine(5);
  engine.intiBalls();
  player = new Player(100, height/2);
  holes.add(new Hole(0, 0));
  holes.add(new Hole(width, 0));
  holes.add(new Hole(0, height));
  holes.add(new Hole(width, height));
  holes.add(new Hole(width/2, 0));
  holes.add(new Hole(width/2, height));

  engine.addObj(player);
}

void draw() {
  background(0);
  for (Hole h : holes) {
    h.show();
  }
  engine.update(holes);
  engine.show();

  if (!engine.ballsAreInMotion()) {
    if (!mouse_Moved && firstTime) {
      ArrayList<Ball> balls = engine.getBalls();
      ghostEngine.setBalls(balls);
      println(player.position.dist(new PVector(mouseX, mouseY)));
      if (player.targetLine.fixedDirection)
        ghostEngine.hit(-player.targetLine.force, player.targetLine.angle + PI);
      else
        ghostEngine.hit(player.position.dist(new PVector(mouseX, mouseY)), player.targetLine.angle + PI);
      firstTime = false;
    }
    ghostEngine.update(holes);

    if (mouse_Moved) {
      ghostEngine.tragectories.clear();
      mouse_Moved = false;
      firstTime = true;
    }

    for (int i =0; i < ghostEngine.tragectories.size(); i++ ) {
      //if (i<1050) {
      stroke(255);
      point(ghostEngine.tragectories.get(i).x, ghostEngine.tragectories.get(i).y);
      stroke(0);
      //}
    }
  }

  if (player.fallenIn) {
    player.reset();
  }
}


void mousePressed() {
  if (player.targetLine.fixedDirection)
    player.hit();
  else
    player.targetLine.fixDirection();
}

void mouseMoved() {
  mouse_Moved = true;
}

