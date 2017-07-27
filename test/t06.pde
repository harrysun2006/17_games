void setup() {
  size(screen.width, screen.height, P3D);
}
var a = 0;
void draw() {
  background(0, 0, 255);
  stroke(0);
  lights();
  camera();
  translate(200, 100, 0);
  rotateY(a);
  sphere(100);
  translate(0, 200, 0);
  rotateX(-PI / 6);
  rotateY(PI / 9);
  stroke(255, 255, 0);
  box(80);
  a += PI / 500;
}