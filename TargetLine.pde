class TargetLine {
  PVector position;
  PVector lineEnd;
  boolean fixedDirection;
  float force;
  float angle;

  TargetLine(PVector p) {
    position = p;
    lineEnd = new PVector(0, 0);
    fixedDirection = false;
    force = 0;
    angle = 0;
  }

  void show(boolean inMotion) {
    if (inMotion)
      return;
    stroke(255);
    if (fixedDirection) {
      line(position.x, position.y, lineEnd.x, lineEnd.y);
      drawPower(inMotion);
    } else {
      line(position.x, position.y, mouseX, mouseY);
    }
    stroke(0);
  }

  void drawPower(boolean inMotion) {
    if (inMotion)
      return;

    angle = atan(( lineEnd.y -position.y)/ (lineEnd.x-position.x ));
    if (lineEnd.x > position.x) {
      angle += PI;
    }
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    float power = (mouseX-position.x)*cos(angle)+(mouseY-position.y)*sin(angle);
    float lineMag = position.dist(lineEnd);
    if (abs(power)<=lineMag)
      rect(0, 0, power, 5);
    else
      rect(0, 0, -lineMag, 5);
    popMatrix();
    float force = map(power, 0, lineMag, 0, 300);
    this.force = abs(force);
  }

  float [] getAngleAndForce() {
    return new float[]{angle, force};
  }

  void fixDirection() {
    fixedDirection = true;
    lineEnd.set(mouseX, mouseY);
  }
}
