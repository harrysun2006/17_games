//include
var pause = false;

void setup() {
  // window.alert("Hello World!!!");
  size(screen.width, screen.height);
  smooth();
  dd = 0;
  mx = screen.width;
  my = screen.height;
  cx = mx / 2;
  cy = my / 2;
  xx = cx;
  yy = cy;
}

void draw() {
  if (mousePressed && mouseX <= 100 && mouseY <= 100) {
    pause = !pause;
  }
  if (pause) return;
  if (mouseX > cx + 50) {
    dd = 2;
  } else if (mouseX < cx - 50) {
    dd = -2;
  } else {
    dd = 0;
  }
  xx += dd;
  if (xx > mx) {
    xx = 0;
  } else if (xx < 0) {
    xx = mx;
  }
  yy = cy + 20 * sin((xx - cx) / 10);
  background(0, 0, 255);
  fill(255, 255, 0);
  ellipse(xx, yy, 30, 30);
}