class Engine {
  float gY;
  float gX;
  float yDumping;
  float xDumping;
  float friction;
  ArrayList<Ball> balls;
  int ballsCount;

  Engine(int howManyBalls) {
    gY = 0.0;
    gX = 0.0;
    yDumping = 1;
    xDumping = 1;
    friction = 0.99;
    balls = new ArrayList();
    ballsCount = howManyBalls;
    for (int i =0; i<howManyBalls; i++) {
      balls.add(new Ball(i, random(0, width), random(0, height)));
    }
  }

  void addObj(Ball b) {
    balls.add(b);
  }

  void step(ArrayList<Hole> holes) {
    for (Ball b : balls) {
      addGravity(b);
      addFriction(b);
      checkAndResolveCollitions(b);
      b.update();
      if(!b.fallenIn)
      checkBounds(b);
      for (Hole h : holes) {
        if (h.touching(b)) {
          b.fallIn();
        }
      }
      b.show();
    }
  }

  void resetGame() {
    for (Ball b : balls) {
      if (b.id == -1)
        continue;
      b.position.set(random(80, width-80), random(80, height-80));
      b.speed.set(0,0);
      b.fallenIn = false;
      b.diameter = 50;
    }
  }

  void addGravity(Ball b) {
    b.accelaration.add(gX, gY);
  }

  void addFriction(Ball b) {
    b.speed.x *= friction;
    b.speed.y *= friction;
    if (abs(b.speed.x) <= 0.08) {
      b.speed.x = 0;
    }
    if (abs(b.speed.y) <= 0.08) {
      b.speed.y = 0;
    }
  }

  void checkAndResolveCollitions(Ball b) {
    for (Ball other : balls) {
      if (b.id == other.id)
        continue;
      float distance = other.position.dist(b.position);
      if ( distance < b.radius + other.radius ) {
        float distanceOfOverlap = b.radius + other.radius - distance;

        float angle_of_collition =  atan((b.position.y-other.position.y)/(b.position.x-other.position.x));
        if (other.position.x > b.position.x) {
          angle_of_collition+=PI;
        }

        float dx = cos(angle_of_collition) * (distanceOfOverlap/2);
        float dy = sin(angle_of_collition) * (distanceOfOverlap/2);
        b.position.add(new PVector(dx, dy));
        other.position.add(new PVector(-dx, -dy));

        float u1n = b.speed.x * cos(angle_of_collition) + b.speed.y * sin(angle_of_collition);
        float u2n = other.speed.x * cos(angle_of_collition) + other.speed.y * sin(angle_of_collition);

        float v1t = (-b.speed.x) * sin(angle_of_collition) + b.speed.y * cos(angle_of_collition);
        float v2t = (-other.speed.x) * sin(angle_of_collition) + other.speed.y * cos(angle_of_collition);

        float v1n = (((b.mass - other.mass)*u1n+2*other.mass*u2n)/(b.mass + other.mass));
        float v2n=  (((other.mass - b.mass)*u2n+2*b.mass*u1n)/(b.mass + other.mass));

        b.speed.x = v1n * cos(angle_of_collition) - v1t*sin(angle_of_collition);
        b.speed.y = v1n * sin(angle_of_collition) + v1t*cos(angle_of_collition);
        other.speed.x = v2n * cos(angle_of_collition) - v2t*sin(angle_of_collition);
        other.speed.y = v2n * sin(angle_of_collition) + v2t*cos(angle_of_collition);
      }
    }
  }

  void checkBounds(Ball b) {
    //Floor bounce
    if (b.position.y+b.radius >= height) {
      b.speed.set(b.speed.x*xDumping, b.speed.y*-yDumping);
      b.position.set(b.position.x, height-b.radius);
    }
    //ceil bounce
    if (b.position.y-b.radius <= 0) {
      b.speed.set(b.speed.x*xDumping, b.speed.y*-yDumping);
      b.position.set(b.position.x, 0+b.radius);
    }

    //wall bounce
    if (b.position.x - b.radius<= 0) {
      b.speed.x *= -xDumping;
      b.position.set(0 + b.radius, b.position.y);
    }
    if (b.position.x + b.radius >= width) {
      b.speed.x *= -xDumping;
      b.position.set(width - b.radius, b.position.y);
    }
  }

  float clacKineEnergy(float x1, float y1, float x2, float y2, float m1, float m2) {
    return m1*(x1*x1+y1*y1)/2 + m2*(x2*x2+y2*y2)/2 ;
  }
}
