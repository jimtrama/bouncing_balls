class Ball {

  PVector position;
  PVector speed;
  PVector accelaration;
  float step;
  float radius;
  float diameter;
  Ball[] others;
  int id;
  float mass;
  color c;


  Ball(int i,float x,float y) {
    position = new PVector(x,y);
    speed = new PVector(0,0);
    accelaration = new PVector(0, 0);
    mass = 20;
    diameter = mass*5;
    radius = diameter/2;
    id = i;
    c = color(0,0,0);//color(random(0,255),100,100);
  }

  void addForce(PVector force) {
    accelaration.add(force.div(mass));
  }


  void update() {

    for (Ball other : others) {
      float distance = other.position.dist(position);
      if ( distance < radius + other.radius ) {
        float distanceOfOverlap = radius + other.radius - distance;

        float angle_of_collition =  atan((position.y-other.position.y)/(position.x-other.position.x));
        if (other.position.x > position.x) {
          angle_of_collition+=PI;
        }

        float dx = cos(angle_of_collition) * (distanceOfOverlap/2);
        float dy = sin(angle_of_collition) * (distanceOfOverlap/2);
        position.add(new PVector(dx, dy));
        other.position.add(new PVector(-dx, -dy));

        float u1n = speed.x * cos(angle_of_collition) + speed.y * sin(angle_of_collition);
        float u2n = other.speed.x * cos(angle_of_collition) + other.speed.y * sin(angle_of_collition);

        float v1t = (-speed.x) * sin(angle_of_collition) + speed.y * cos(angle_of_collition);
        float v2t = (-other.speed.x) * sin(angle_of_collition) + other.speed.y * cos(angle_of_collition);

        float v1n = (((mass - other.mass)*u1n+2*other.mass*u2n)/(mass + other.mass));
        float v2n=  (((other.mass - mass)*u2n+2*mass*u1n)/(mass + other.mass));

        speed.x = v1n * cos(angle_of_collition) - v1t*sin(angle_of_collition);
        speed.y = v1n * sin(angle_of_collition) + v1t*cos(angle_of_collition);
        other.speed.x = v2n * cos(angle_of_collition) - v2t*sin(angle_of_collition);
        other.speed.y = v2n * sin(angle_of_collition) + v2t*cos(angle_of_collition);
      }
    }
    speed.add(accelaration);
    position.add(speed);
    accelaration.set(0, 0);
  }

  float clacKineEnergy(float x1,float y1,float x2,float y2,float m1,float m2){
    return m1*(x1*x1+y1*y1)/2 + m2*(x2*x2+y2*y2)/2 ;
  }

  void show() {
    float c = map(abs(speed.x + speed.y)/2, 0, 10, 50, 0);
    fill(c);
    circle(position.x, position.y, diameter);
    // pushMatrix();
    // textAlign(CENTER);
    // translate(pos.x, pos.y);
    // fill(0);
    // text(id, 0, 0);
    // popMatrix();
  }

  void setOtherBalls(Ball[] o) {
    others = o;
  }
  void clearOtherBalls() {
    others = new Ball[0];
  }
}
