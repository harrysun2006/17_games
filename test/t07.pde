void setup() {
  size(screen.width, screen.height, P3D);
}
var a = 0;
var b = 0;
void draw() {
  background(0, 0, 255);
  lights();
  camera();
  translate(200, 320, 0);
  rotateY(a);
  translate(-70, 0, 0);
  rotateX(b);

  sphere(100);
  a += 0.02;
  b -= 0.2;
  rotateY(-a);
  rotateX(-b);

  translate(-130, -320, 0);
}