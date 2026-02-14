class Player extends Ball {

  TargetLine targetLine;

  Player(float x, float y) {
    super(-1, x, y);
    c = color(255, 255, 255);
    targetLine = new TargetLine(position);
  }

  void show() {
    super.show();
    targetLine.show(isInMotion());
  }

  boolean isInMotion() {
    return !(speed.x == 0 && speed.y == 0);
  }

  void reset() {
    fallenIn = false;
    position.set(100, height/2);
    speed.set(0, 0);
    diameter = 50;
  }

  void hit(boolean first) {
    if (first) return;
    float[] angleAndForce = targetLine.getAngleAndForce();
    float angle = angleAndForce[0];
    float force = angleAndForce[1];
    targetLine.fixedDirection = false;
    println(force);
    println(angle);
    addForce(new PVector(force*cos(angle+PI), force*sin(angle+PI)));
  }
}

