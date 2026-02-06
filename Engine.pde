class Engine {
  float gY;
  float gX;
  float yDumping;
  float xDumping;
  ArrayList<Ball> balls;

  Engine(int howManyBalls) {
    gY = 0.0;
    gX = 0.0;
    yDumping = 1;
    xDumping = 1;
    balls = new ArrayList();

    for (int i =0; i<howManyBalls; i++) {
      balls.add(new Ball(i));
    }
    for (int i = 0; i < balls.size(); i++) {
      Ball[] otherBalls = new Ball[balls.size() - 1];
      int index = 0 ;
      for (int j = 0; j < balls.size(); j++) {
        if (i != j) {
          otherBalls[index] = balls.get(j);
          index++;
        }
      }
      balls.get(i).setOtherBalls(otherBalls);
    }
  }

  void addObj(Ball b) {
    balls.add(b);
  }

  void step() {
    for (Ball b : balls) {
      addGravity(b);
      b.update();
      checkBounds(b);
      b.show();
    }
  }

  void addGravity(Ball b) {
    b.accelaration.add(gX, gY);
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
}
