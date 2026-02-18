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
    mass = random(2,3);
    diameter = mass*5;
    radius = diameter/2;
    id = i;
    c = color(50,100,100);//color(random(0,255),100,100);
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
    float speed_color = (speed.x + speed.y)/2;
    float color_value = map(speed_color,0,30,50,255);
    fill(color(color_value,100,100));
    circle(position.x, position.y, diameter);
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
