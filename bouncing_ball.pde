Engine engine;
Player player;
void setup() {
  size(1000, 500);
  //windowMove(1500,100);
  //fullScreen();
  colorMode(HSB,100);
  engine = new Engine(5);
  player = new Player(100, height/2);
  engine.addObj(player);
}

void draw() {
  background(0);
  engine.step();
  //saveFrame("./out/frame-########.png");
}

void keyPressed() {
  //   for (int i = 0; i < balls.length; i++) {
  //     PVector mouseForce = new PVector(balls[i].pos.x-mouseX,balls[i].pos.y-mouseY);
  //     float distance = balls[i].pos.dist(new PVector(mouseX, mouseY));
  //     float max_distance = new PVector(0, 0).dist(new PVector(width, height));
  //     float dist_force = map(distance, 0, max_distance, 1, 0);
  //     balls[i].addForce(mouseForce.normalize().setMag(dist_force));
  //   }
}

void mousePressed() {
  if (player.fixedDirection)
    player.hit();
  else
    player.fixDirection();
}

