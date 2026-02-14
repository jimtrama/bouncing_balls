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
    
    if(fallenIn && diameter<=0){
      position.set(width*2,height*2);
      return;
    }
    if(fallenIn ){
      return;
    }
    speed.add(accelaration);
    position.add(speed);
    accelaration.set(0, 0);
  }

  void show() {
    //float c = map(abs(speed.x + speed.y)/2, 0, 10, 50, 0);
    fill(c);
    circle(position.x, position.y, diameter);
    if(fallenIn && diameter >=0){
      diameter-= 0.9;
    }
    // pushMatrix();
    // textAlign(CENTER);
    // translate(pos.x, pos.y);
    // fill(0);
    // text(id, 0, 0);
    // popMatrix();
  }

  void fallIn(){
    fallenIn = true;
  }

  Ball copy(){
    return new Ball(id,position.x,position.y);
  }
}
