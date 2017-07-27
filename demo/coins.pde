var tt = 0;

void setup() {
  size(screen.width, screen.height);
  var i, cc = [];
  for (i = 1; i <= 120; i++) cc[i] = 0.05;
  for (i = 1; i <= 120; i++) {
    if (i % 2 == 0) cc[i] = 0.1;
  }
  for (i = 1; i <= 120; i++) {
    if (i % 3 == 0) cc[i] = 0.2;
  }
  for (i = 1; i <= 120; i++) {
    if (i % 4 == 0) cc[i] = 0.5;
  }
  for (i = 1; i <= 120; i++) {
    if (i % 5 == 0) cc[i] = 1;
  }
  for (i = 1; i <= 120; i++) {
    tt += cc[i];
  }
  println("tt=" + tt.toFixed(2));
}

void draw() {
  background(0, 0, 255);
  fill(255, 255, 0);
  textSize(72);
  text(tt, 100, 100);
}