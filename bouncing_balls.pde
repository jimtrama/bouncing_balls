Engine engine;


void setup() {
  size(1500, 800);
  windowMove(2300, 100);
  //fullScreen();
  colorMode(HSB,100);
  engine = new Engine(3000);
  engine.intiBalls();
}

void draw() {
  background(0);
  engine.update();
  engine.show();
  for(Ball b :engine.getBalls()){
    //b.addForce(new PVector(mouseX - width/2,mouseY-height/2).normalize());
  }
}


void mousePressed() {
  //engine.hit(10,PI);
}


