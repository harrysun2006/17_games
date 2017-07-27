var bullet = function(x, y, a) {
  this.owner = null;
  this.x = x;
  this.y = y;
  this.a = a;
  this.s = 10;
  this.xs = this.s * sin(this.a);
  this.ys = this.s * cos(this.a);
};
bullet.prototype.run = function() {
  this.x += this.xs;
  this.y -= this.ys;
};
bullet.prototype.gone = function() {
  return this.x < 0 || this.x > screen.width ||
    this.y < 0 || this.y > screen.height;
};
bullet.prototype.draw = function() {
  this.run();
  translate(this.x, this.y);
  rotate(this.a);
  ellipse(0, 0, this.owner.size + 40, this.owner.size + 40);
  rotate(-this.a);
  translate(-this.x, -this.y);
};

var tank = function(size) {
  this.x = screen.width / 2;
  this.y = screen.height / 2;
  this.size = size;
  this.vb = 1;
  this.bi = 0;
  this.bb = [];
  this.a = 0;
};
var o = 0;
tank.prototype.draw = function() {
  translate(this.x, this.y);
  rotate(this.a);
  fill(160, 160, 160);

  rect(-50 - this.size, -25 - this.size / 2, 48 + this.size, 48 + this.size);
  rect(-20 - this.size, -35 - this.size, 48 + this.size, 48 + this.size);
  fill(10, 130, 245);

  ellipse(0, 0, 52 + this.size, 52 + this.size);
  rotate(-this.a);
  translate(-this.x, -this.y);
  this.a += PI / 90;
};
tank.prototype.shoot = function() {
  var bb = this.bb;
  var i, b;
  if (this.bi === 0) {
    b = new bullet(this.x, this.y, this.a + 3 * PI / 2);
    b.owner = this;
    bb.push(b);
    b = new bullet(this.x, this.y, this.a + PI / 2);
    b.owner = this;
    bb.push(b);
    b = new bullet(this.x, this.y, this.a + 2 * PI / 2);
    b.owner = this;
    bb.push(b);
    b = new bullet(this.x, this.y, this.a);
    b.owner = this;
    bb.push(b);
  }
  this.bi = (this.bi + 1) % this.vb;
  for (i = bb.length - 1; i >= 0; i--) {
    b = bb[i];
    if (b.gone()) {
      bb.splice(i, 1);
    }
  }
  for (i = 0; i < bb.length; i++) {
    bb[i].draw();
  }
};
var grid = function() {
  stroke(200, 200, 200);
  for (i = -1000; i <= 1000; i += 25) {
    line(i, -1000, i, 1000);
  }
  for (ii = -1000; ii <= 1000; ii += 25) {
    line(-1000, ii, 1000, ii);
  }
};
var square = function(x, y, a) {
  this.x = x;
  this.y = y;
  this.a = a;
  this.n = [];
  this.ri = 0;
  this.re = 3;
  this.h = 180;
};
square.prototype.draw = function() {
  translate(this.x, this.y);
  rotate(this.a);
  fill(255, 255, 0);
  rect(-9, -9, 18, 18);
  fill(0, 255, 0);
  rect(-9, -15, this.h / 10, 4);
  rotate(-this.a);
  translate(-this.x, -this.y);
};
square.prototype.hit = function() {};
square.prototype.dead = function() {
  return this.h <= 0;
};
square.prototype.make = function() {
  if (this.ri === 0) {
    var s = new square(random(330), random(610), random(PI));
    this.n.push(s);
  }
  this.ri = (this.ri + 1) % this.re;

  for (i = this.n.length - 1; i >= 0; i--) {
    s = this.n[i];
    if (s.dead()) {
      this.n.splice(i, 1);
    }
  }
  for (i = 0; i < this.n.length; i++) {
    this.n[i].draw();
  }

  for (i = 0; i < this.n.length; i++) {
    for (ii = 0; ii < bigBallShooter.bb.length; ii++) {
      if (dist(this.n[i].x, this.n[i].y, bigBallShooter.bb[ii].x, bigBallShooter.bb[ii].y) < (bigBallShooter.size + 50) / 2 + 12) {
        this.n[i].h -= 200;
      }
    }
  }
};
var bigBallShooter;
var sq;
void setup() {
  size(screen.width, screen.height);
  bigBallShooter = new tank(-20);
  sq = new square();
}
void draw() {
  background(255);
  grid();
  fill(0, 200, 255);
  bigBallShooter.shoot();
  bigBallShooter.draw();
  sq.make();
}