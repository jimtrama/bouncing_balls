Engine engine;
Engine ghostEngine;
Player player;
Player ghostPlayer;
ArrayList<Hole> holes;
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
  ghostPlayer = new Player(100, height/2);
  holes.add(new Hole(0, 0));
  holes.add(new Hole(width, 0));
  holes.add(new Hole(0, height));
  holes.add(new Hole(width, height));
  holes.add(new Hole(width/2, 0));
  holes.add(new Hole(width/2, height));

  engine.addObj(player);
  ghostEngine.addObj(ghostPlayer);
}
boolean flag = false;
boolean mouse_Moved = false;
void draw() {
  background(0);
  for (Hole h : holes) {
    h.show();
  }
  engine.update(holes);
  engine.show();

  if (!engine.ballsAreInMotion()) {


    if (!mouse_Moved) {
      if (!flag) {
        ArrayList<Ball> balls = engine.getBalls();
        ghostEngine.setBalls(balls);
        ghostPlayer.targetLine.force = 299;
        ghostPlayer.targetLine.angle = player.targetLine.angle + PI;
        println(player.position.dist(player.targetLine.lineEnd));
        ghostEngine.hit(player.position.dist(new PVector(mouseX,mouseY)), player.targetLine.angle + PI);
      }
      flag = true;
    }
    ghostEngine.update(holes);

    if (mouse_Moved) {

      ghostEngine.tragectories.clear();
      flag = false;
      mouse_Moved = false;
    }

    for (int i =0; i < ghostEngine.tragectories.size(); i++ ) {
      if (i<150) {
        stroke(255);
        point(ghostEngine.tragectories.get(i).x, ghostEngine.tragectories.get(i).y);
        stroke(0);
      }
    }
  }


  if (player.fallenIn) {
    //engine.resetGame();
    player.reset();
  }
  if (ghostPlayer.fallenIn) {
    //engine.resetGame();
    ghostPlayer.reset();
  }
  //saveFrame("./out/frame-########.png");
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
