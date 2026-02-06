class Ball {

  PVector pos;
  PVector speed;
  PVector accelaration;
  float step;
  float r;
  float gY;
  float gX;
  float yDumping;
  float xDumping;
  Ball[] others;
  int id;
  float mass;

  Ball(int i) {
    pos = new PVector(random(0, width), random(0, height));
    speed = new PVector(random(-5, 5), random(-5, 5));
    accelaration = new PVector(0, 0);
    mass = 5 * random(1, 5);
    r = mass*5;
    gY = 0.1;
    gX = 0.0;
    yDumping = 0.5;
    xDumping = 1;
    id = i;
  }

  void addForce(PVector force) {
    accelaration.add(force.div(mass));
  }

  void addGravity() {
    accelaration.add(gX, gY);
  }

  void update() {

    for (Ball other : others) {

      if (other.pos.dist(pos)  < r/2 + other.r / 2) {
        float angle_of_collition =  atan((pos.y-other.pos.y)/(pos.x-other.pos.x));
        float distance = r/2 + other.r / 2 - other.pos.dist(pos);

        if (other.pos.x > pos.x) {
          angle_of_collition+=PI;
        }

        float dx = cos(angle_of_collition) * (distance/2);
        float dy = sin(angle_of_collition) * (distance/2);
        pos.add(new PVector(dx, dy));
        other.pos.add(new PVector(-dx, -dy));

        println("k before: "+clacKineEnergy(speed.x,speed.y,other.speed.x,other.speed.y,mass,other.mass));

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
        println("k after: "+clacKineEnergy(speed.x,speed.y,other.speed.x,other.speed.y,mass,other.mass));
      }
    }
    addGravity();
    speed.add(accelaration);
    pos.add(speed);

    accelaration.set(0, 0);

    //Floor bounce
    if (pos.y+r/2 >= height) {
      speed.set(speed.x*xDumping, speed.y*-yDumping);
      pos.set(pos.x, height-r/2);
    }
    //ceil bounce
    if (pos.y-r/2 <= 0) {
      speed.set(speed.x*xDumping, speed.y*-yDumping);
      pos.set(pos.x, 0+r/2);
    }

    //wall bounce
    if (pos.x - r/2 <= 0) {
      speed.x *= -xDumping;
      pos.set(0 + r/2, pos.y);
    }
    if (pos.x + r/2 >= width) {
      speed.x *= -xDumping;
      pos.set(width - r/2, pos.y);
    }
  }

  float clacKineEnergy(float x1,float y1,float x2,float y2,float m1,float m2){
    return m1*(x1*x1+y1*y1)/2 + m2*(x2*x2+y2*y2)/2 ;
  }

  void show() {
    float c = map(abs(speed.x + speed.y)/2, 0, 10, 50, 0);
    fill(c, 100, 100);
    circle(pos.x, pos.y, r);
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
}
