class Hole{
    PVector position;
    float diameter;
    float radius;

    Hole(float x,float y){
        position = new PVector(x,y);
        diameter = 100;
        radius = diameter / 2;
    }

    void show(){
        fill(100,100,200);
        circle(position.x,position.y,diameter);
    }

    boolean touching(Ball b){
        float distance = position.dist(b.position);
        return distance <= radius ;
    }
}