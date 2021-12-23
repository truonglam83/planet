Planet sun;
float m =0.0;
PImage sunTexture;
PImage[] textures = new PImage[1];
ArrayList<Particle> particles;
void setup(){
  size(640, 480, P3D);
  particles = new ArrayList<Particle>();
  for(int i = 0; i < 500; i++){
    particles.add(new Particle()); 
  }
   size(600, 600, P3D);
   sunTexture = loadImage("sun.jpg");
   sun = new Planet(50, 0, 0, sunTexture);
   sun.spawnMoons(4, 1);
}

void draw(){
  background(0);
  noStroke();
  fill(230);
  translate(width / 2, height / 2);
  lights();
  rotateX(map(mouseY, 0, height, -PI / 3, PI / 3));
  rotateZ(map(mouseX, 0, height, -PI / 16, PI / 16));
  for(Particle p: particles){
    p.display();
    p.update();
  }
  pushMatrix();
  rotateY(radians(m));
  textSize(30);
  textAlign(CENTER); 
  text("Nguyen Truong Lam - 18520970", 0,250);
  popMatrix();
  m += 0.25;
}

class Particle {
 
  float xRadius, zRadius;
  float angle;
  float angleSpeed;
  float tiltAngle;
  float rotXSpeed, rotYSpeed;
  float size;
  
  Particle(){
    xRadius = 300 + randomGaussian() * 40;
    zRadius = 150 + randomGaussian() * 20;
    angle = random(TWO_PI);
    angleSpeed = random(PI / 500, PI / 250);
    tiltAngle = randomGaussian() * PI / 32;
    rotXSpeed = random(-PI / 32, PI / 32);
    rotYSpeed = random(-PI / 32, PI / 32);
    size = map(pow(random(1), 3), 0, 1, 1, 5);
  }
  
  void display(){
    pushMatrix();
    rotateZ(tiltAngle);
    translate(xRadius * cos(angle), 0, zRadius * sin(angle));
    rotateX(rotXSpeed * frameCount);
    rotateY(rotYSpeed * frameCount);
    box(size);
    popMatrix();
    sun.show();
  }
  
  void update(){
    angle -= angleSpeed;
    if(angle < 0){
      angle += TWO_PI;
    }
  }
}
