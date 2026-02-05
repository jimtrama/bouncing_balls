Ball[] balls;
int l = 2;
void setup() {
  size(500, 500);
  //windowMove(1500,100);
  //fullScreen();
  colorMode(HSB,100);
  balls = new Ball[l];
  for (int i =0; i<l; i++) {
    balls[i] = new Ball(i);
  }
  for (int i = 0; i < balls.length; i++) {
    Ball[] otherBalls = new Ball[balls.length - 1];
    int index = 0 ;
    for (int j = 0; j < balls.length; j++) {
      if (i != j) {
        otherBalls[index] = balls[j];
        index++;
      }
    }
    balls[i].setOtherBalls(otherBalls);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < balls.length; i++) {
    balls[i].update(i == 0);
    balls[i].show();
    // if(frameCount%100==0){
    //     balls[i].gY *= -1;
    // }
  }
  //saveFrame("./out/frame-########.png");
}

void keyPressed() {
  for (int i = 0; i < balls.length; i++) {
    PVector mouseForce = new PVector(balls[i].pos.x-mouseX,balls[i].pos.y-mouseY);
    float distance = balls[i].pos.dist(new PVector(mouseX, mouseY));
    float max_distance = new PVector(0, 0).dist(new PVector(width, height));
    float dist_force = map(distance, 0, max_distance, 1, 0);
    balls[i].addForce(mouseForce.normalize().setMag(dist_force));
  }
}
