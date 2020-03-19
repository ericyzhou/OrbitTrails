import java.util.Random;

int degrees = 0;
int particleCount = 500;
int width = 2000;
int height = 800;
int cameraY = 200;

ArrayList<Particle> particles = new ArrayList();
Random rand;
CenterMass centerMass = new CenterMass();

void setup() {
  size(2000, 800, P3D);
  for (int i = 0; i < particleCount; i++) {
    int randomRadius = new Random().nextInt(400 - 200 + 1) + 200;
    int randomTilt = new Random().nextInt(45 - 0 + 1) + 0;
    int randomRotate = (int) (360 * Math.random());
    particles.add(new Particle(randomRadius, randomTilt, randomRotate));
  }
}

void draw() {
  background(10);
  camera(1000, cameraY, 1000, 1000, 400, 0, 0, 1, 0);
  centerMass.display();
  for (int i = particles.size() - 1; i >= 0; i--) {
    particles.get(i).display();
    particles.get(i).move();
  }
}

class CenterMass {
  float xpos;
  float ypos;
  float zpos;
  
  CenterMass() {
    this.xpos = width / 2;
    this.ypos = height / 2;
    this.zpos = 0;
  }
  
  void display() {
    noStroke();
    lights();
    translate(this.xpos, this.ypos, this.zpos);
    fill(color(50, 50, 50));
    sphereDetail(30);
    sphere(100);
  }
}


class Particle {
  float xpos;
  float ypos;
  float zpos;
  float radius;
  float thetaAngle; // tilt
  float phiAngle; // rotation
  ArrayList<Trail> trails;
  
  Particle() {
    this.xpos = 0;
    this.ypos = 0;
    this.zpos = 0;
    this.radius = 200;
    this.thetaAngle = 0;
    this.phiAngle = 0;
    this.trails = new ArrayList();
  }
  
  Particle(float radius, float thetaAngle, float phiAngle) {
    this.xpos = radius * sin(thetaAngle * (float) Math.PI / 180) * sin(phiAngle * (float) Math.PI / 180);
    this.ypos = radius * cos(phiAngle * (float) Math.PI / 180);
    this.zpos = radius * cos(thetaAngle * (float) Math.PI / 180) * sin(phiAngle * (float) Math.PI / 180);
    this.radius = radius;
    this.thetaAngle = thetaAngle * (float) Math.PI / 180;
    this.phiAngle = phiAngle * (float) Math.PI / 180;
    this.trails = new ArrayList();
  }
  
  void display() {
    pushMatrix();
    noStroke();
    lights();
    translate(this.xpos, this.ypos, this.zpos);
    fill(color(255, 255, 255));
    sphereDetail(3);
    sphere(3);
    popMatrix();
    //this.trails.add(new Trail(this.xpos, this.ypos, this.zpos));
    //for (int i = 0; i < this.trails.size(); i++) {
    //  this.trails.get(i).display();
    //  if (trails.get(i).age > 100) {
    //    this.trails.remove(i);
    //  }
    //}
  }
  
  void move() {
    this.xpos = this.radius * cos(this.thetaAngle) * sin(this.phiAngle);
    this.ypos = this.radius * sin(this.thetaAngle) * sin(this.phiAngle);
    this.zpos = this.radius * cos(this.phiAngle);
    this.phiAngle = this.phiAngle + ((float) Math.PI / 180);
  }
}


class Trail {
  float xpos;
  float ypos;
  float zpos;
  int age;
  
  Trail(float xpos, float ypos, float zpos) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.zpos = zpos;
    this.age = 0;
  }
  
  void display() {
    pushMatrix();
    noStroke();
    lights();
    translate(this.xpos, this.ypos, this.zpos);
    fill(color(255, 255, 255));
    sphereDetail(3);
    sphere(1);
    popMatrix();
    this.age = this.age + 1;
  }  
}
