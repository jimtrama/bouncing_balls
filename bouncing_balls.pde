Engine engine;
Player player;
ArrayList<Hole> holes;
void setup() {
  size(1000, 500);
  windowMove(2000,100);
  //fullScreen();
  //colorMode(HSB,100);
  holes = new ArrayList();
  engine = new Engine(5);
  player = new Player(100, height/2);
  holes.add(new Hole(0,0));
  holes.add(new Hole(width,0));
  holes.add(new Hole(0,height));
  holes.add(new Hole(width,height));

  engine.addObj(player);
}

void draw() {
  background(0);
  engine.step(holes);
  for(Hole h:holes){
    h.show();
  }
  //saveFrame("./out/frame-########.png");
}


void mousePressed() {
  if (player.targetLine.fixedDirection)
    player.hit();
  else
    player.targetLine.fixDirection();
}

