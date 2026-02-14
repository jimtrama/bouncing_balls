class TargetLine {
  PVector position;
  PVector lineEnd;
  PVector oldLineEnd;
  boolean fixedDirection;
  float force;
  float angle;

  TargetLine(PVector p) {
    position = p;
    lineEnd = new PVector(0, 0);
    oldLineEnd = new PVector(0,0);
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
      calculateAngle();
      oldLineEnd.set(mouseX,mouseY);
    }
    stroke(0);
  }

  void calculateAngle(){
    angle = atan(( mouseY -position.y)/ (mouseX-position.x ));
    if (mouseX < position.x) {
      angle += PI;
    }
  }

  void drawPower(boolean inMotion) {
    if (inMotion)
      return;

    angle = atan(( lineEnd.y -position.y)/ (lineEnd.x-position.x ));
    if (lineEnd.x < position.x) {
      angle += PI;
    }
    float power = (mouseX-position.x)*cos(angle)+(mouseY-position.y)*sin(angle);
    float lineMag = position.dist(lineEnd);
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    if (power<0) power = 0 ;
    if (abs(power)<=lineMag)
      rect(0, 0, power, 5);
    else
      rect(0, 0, lineMag, 5);
    popMatrix();
    float force = map(abs(power), 0, lineMag, 0, 300);
    angle+=PI;
    this.force = abs(force);
  }

  float [] getAngleAndForce() {
    return new float[]{angle, force};
  }

  void fixDirection() {
    fixedDirection = true;
    lineEnd.set(mouseX, mouseY);
  }

  boolean lineMoved(){
    return oldLineEnd.x != mouseX || oldLineEnd.y != mouseY;
  }
}
