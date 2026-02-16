class Ball {

  PVector position;
  PVector speed;
  PVector accelaration;
  float radius;
  float diameter;
  int id;
  float mass;
  color c;
  boolean fallenIn;

  Ball(int i,float x,float y) {
    position = new PVector(x,y);
    speed = new PVector(0,0);
    accelaration = new PVector(0, 0);
    mass = 10;
    diameter = mass*5;
    radius = diameter/2;
    id = i;
    c = color(100,20,50);//color(random(0,255),100,100);
    fallenIn = false;
  }

  void addForce(PVector force) {
    accelaration.add(force.div(mass));
  }

  void update() {
    if(fallenIn){
      return;
    }
    speed.add(accelaration);
    position.add(speed);
    accelaration.set(0, 0);
  }

  void show() {
    fill(c);
    circle(position.x, position.y, diameter);
    pushMatrix();
    textAlign(CENTER);
    translate(position.x, position.y);
    fill(255);
    textSize(20);
    text(id, 0, 0);
    popMatrix();
  }

  boolean isInMotion() {
    return !(speed.x == 0 && speed.y == 0);
  }

  void fallIn(){
    fallenIn = true;
  }

  Ball copy(){
    return new Ball(id,position.x,position.y);
  }
}
