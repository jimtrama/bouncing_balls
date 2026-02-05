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
    speed = new PVector(random(-4, 4), random(-4, 4));
    accelaration = new PVector(0, 0);
    mass = 5 * random(2, 4);
    r = mass*5;
    gY = 0.0;
    gX = 0.0;
    yDumping = 1;
    xDumping = 1;
    id = i;
  }

  void addForce(PVector force) {
    accelaration.add(force.div(mass));
  }

  void addGravity() {
    accelaration.add(gX, gY);
  }

  void update(boolean flag) {
    if (flag) {
      pos.y = mouseY;
      pos.x = mouseX;
      return;
    }
    //Collition Resolution
    for (Ball other : others) {

      if (other.pos.dist(pos)  <= r/2 + other.r / 2) {
        float angle_of_collition = 0;


        // if(other.pos.x>pos.x){
        //  angle_of_collition+=PI;
        //  print("bike"+id);
        // }
        float distance = r/2 + other.r / 2 - other.pos.dist(pos);
        float dx = 0; //= cos(angle_of_collition) * distance;
        float dy = 0; //= sin(angle_of_collition) * distance;


        // println(angle_of_collition);
        if (other.pos.x>pos.x && other.pos.y > pos.y ) {
          angle_of_collition =   atan((pos.y-other.pos.y)/(pos.x-other.pos.x)) - PI;
          dx= cos(angle_of_collition) * distance;
          dy= sin(angle_of_collition) * distance;
          pos.add(new PVector(dx, -dy));
          other.pos.add(new PVector(-dx, dy));
          println("tetarto: "+id);
        } else  if (other.pos.x < pos.x  && other.pos.y > pos.y ) {
          angle_of_collition =   atan((pos.y-other.pos.y)/(pos.x-other.pos.x));
          dx= cos(angle_of_collition) * distance;
          dy= sin(angle_of_collition) * distance;
          pos.add(new PVector(dx, dy));
          other.pos.add(new PVector(-dx, -dy));
          println("trito: "+id);
        } else if (other.pos.x > pos.x && other.pos.y  <  pos.y ) {
          angle_of_collition =   atan((pos.y-other.pos.y)/(pos.x-other.pos.x)) +  PI;
          dx= cos(angle_of_collition) * distance;
          dy= sin(angle_of_collition) * distance;
          pos.add(new PVector(dx, dy));
          other.pos.add(new PVector(-dx, -dy));
          println("proto: "+id);
        } else  if (other.pos.x  <  pos.x && other.pos.y < pos.y) {
          angle_of_collition =  -atan((pos.y-other.pos.y)/(pos.x- other.pos.x))  ;
          dx= cos(angle_of_collition) * distance;
          dy= sin(angle_of_collition) * distance;
          pos.add(new PVector(dx, dy));
          other.pos.add(new PVector(-dx, -dy));
          println("deutero: "+id);
        }
        println(angle_of_collition);
        println("------------------");


        // float dxSpead = cos(angle_of_collition) * (((mass - other.mass)*speed.x+2*other.mass*other.speed.x)/(mass + other.mass));
        // float dySpead = sin(angle_of_collition) * (((mass - other.mass)*speed.y+2*other.mass*other.speed.y)/(mass + other.mass));

        // float dxSpeadOther = cos(angle_of_collition) * (((other.mass - mass)*other.speed.x+2*mass*speed.x)/(mass + other.mass));
        // float dySpeadOther = sin(angle_of_collition) * (((other.mass - mass)*other.speed.y+2*mass*speed.y)/(mass + other.mass));
        float u1n = speed.x * cos(angle_of_collition) + speed.y * sin(angle_of_collition);
        float u2n = other.speed.x * cos(angle_of_collition) + other.speed.y * sin(angle_of_collition);

        float v1t = (-speed.x) * sin(angle_of_collition) + speed.y * cos(angle_of_collition);
        float v2t = (-other.speed.x) * sin(angle_of_collition) + other.speed.y * cos(angle_of_collition);

        float v1n = (((mass - other.mass)*u1n+2*other.mass*u2n)/(mass + other.mass));
        float v2n=  (((other.mass - mass)*u2n+2*mass*u1n)/(mass + other.mass));

        speed.x = v1n * cos(angle_of_collition) - v1t*sin(angle_of_collition);
        speed.y = v1n * sin(angle_of_collition) + v1t*cos(angle_of_collition);
        other.speed.x = v2n * cos(angle_of_collition) - v2t*sin(angle_of_collition);
        other.speed.x = v2n * sin(angle_of_collition) + v2t*cos(angle_of_collition);
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

  void show() {
    float c = map((speed.x + speed.y)/2, 0, 10, 50, 0);
    fill(c, 100, 100);
    circle(pos.x, pos.y, r);

    pushMatrix();
    textAlign(CENTER);
    translate(pos.x, pos.y);
    fill(0);
    text(id, 0, 0);
    popMatrix();
  }

  void setOtherBalls(Ball[] o) {
    others = o;
  }
}
