void setup() {
  size(screen.width, screen.height);
  /*var */
  x = 20;
  y = 1;
  q = 1;
  o = 1;
  oo = 1;
  aa = 0;
  z = 1;
  ta = 600;
  tb = 700;
  gameOver = false;
}
void draw() {
  a = x * x / 30;
  background(0, 0, 255);
  fill(255, 0, 255);
  rect(0, 385, 423, 10);
  fill(255, 255, 0);
  ellipse(160, 360 + y, 50, 50);
  if (mousePressed || 360 + y < 361) {
    y -= a * oo * z;
    x += 1.1 * o * q;
  }
  if (mousePressed && 360 + y < 361) {
    q = 0.2;
  } else {
    q = 1;
  }
  if (y < -1) {
    o = -0.8;
  }
  if (x < 0) {
    oo = -1.5;
  }
  if (360 + y > 361) {
    x = 20;
    y = 1;
    o = 1;
    oo = 1;
  }
  if (y < -203) {
    y = -203;

  }
  fill(255, 0, 0);
  triangle(ta - 20, 390, ta, 346, ta + 20, 390);
  ta -= 3;
  if (ta < 0) {
    ta = random(375, 500);
  }
  fill(255, 0, 0);
  triangle(tb - 20, 390, tb, 346, tb + 20, 390);
  tb -= 3;
  if (tb < 0) {
    tb = random(375, 500);
  }
  if (dist(160, 360 + y, ta - 20, 390) < 25 || dist(160, 360 + y, ta, 346) < 25) {
    gameOver = true;
  }
  if (dist(160, 360 + y, tb - 20, 390) < 25 || dist(160, 360 + y, tb, 346) < 25) {
    gameOver = true;
  }
  if (gameOver === true) {
    textSize(100);
    fill(255, 200, 0);
    text("GAME", 10, 170);
    text("OVER", 10, 370);
  }
}