class Player extends Ball {

  boolean fixedDirection;
  boolean inMotion;
  PVector lineEnd;
  float force;
  float angle;

  Player(float x, float y) {
    super(-1, x, y);
    c = color(255);
    fixedDirection = false;
    lineEnd = new PVector(0, 0);
    force = 0;
    angle = 0;
  }

  void show() {
    super.show();
    stroke(255);
    if (fixedDirection && !inMotion) {
      line(position.x, position.y, lineEnd.x, lineEnd.y);
      drawPower();
    } else if(!inMotion) {
      line(position.x, position.y, mouseX, mouseY);
    }
    stroke(0);
  }

  void drawPower() {
    angle = atan((position.y - lineEnd.y )/ (position.x - lineEnd.x));
    if (lineEnd.x > position.x) {
      angle += PI;
    }
    if (!inMotion) {
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
      float force = map(power, 0, lineMag, 0, 100);
      this.force = abs(force);
    }
  }

  void fixDirection() {
    fixedDirection = true;
    lineEnd.set(mouseX, mouseY);
  }

  void hit() {
    fixedDirection = false;
    inMotion = true;
    addForce(new PVector(force*cos(angle+PI), force*sin(angle+PI)));
  }
}
