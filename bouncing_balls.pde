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
void draw() {
  background(0);
  for (Hole h : holes) {
    h.show();
  }
  engine.update(holes);
  engine.show();
  if (player.isInMotion() || player.targetLine.lineMoved()) {
    ghostEngine.tragectories.clear();
    flag = false;
  }
  if (!player.targetLine.lineMoved()) {
    if (!flag) {
      ArrayList<Ball> balls = engine.getBalls();
      ghostEngine.setBalls(balls);
      ghostEngine.addObj(ghostPlayer);
      ghostPlayer.position.x = player.position.x;
      ghostPlayer.position.y = player.position.y;
      ghostPlayer.targetLine.force = 299;
      ghostPlayer.targetLine.angle = player.targetLine.angle;
      ghostPlayer.hit(flag);
    }
    flag = true;
  }
  ghostEngine.update(holes);
  for (PVector p : ghostEngine.tragectories) {
    stroke(255);
    point(p.x, p.y);
    stroke(0);
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
    player.hit(false);
  else
    player.targetLine.fixDirection();
}

