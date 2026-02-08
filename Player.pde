class Player extends Ball {

  TargetLine targetLine;

  Player(float x, float y) {
    super(-1, x, y);
    c = color(255,255,255);
    targetLine = new TargetLine(position);
  }

  void show() {
    super.show();
    targetLine.show(isInMotion());
  }

  boolean isInMotion(){
    return speed.x >= 0.0001 || speed.y >= 0.0001;
  }

  void hit() {
    float[] angleAndForce = targetLine.getAngleAndForce();
    float angle = angleAndForce[0];
    float force = angleAndForce[1];
    targetLine.fixedDirection = false;
    addForce(new PVector(force*cos(angle+PI), force*sin(angle+PI)));
  }
}
