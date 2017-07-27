var go = false;
var bullet = function(x, y, a) {
  this.owner = null;
  this.x = x;
  this.y = y;
  this.a = a;
  this.s = 6;
  this.xs = this.s * sin(this.a);
  this.ys = this.s * cos(this.a);
};
bullet.prototype.run = function() {
  this.x += this.xs;
  this.y -= this.ys;
};
bullet.prototype.gone = function() {
  return this.x < -1000 || this.x > 1000 ||
    this.y < -1000 || this.y > 1000;
};
bullet.prototype.draw = function() {
  this.run();
  if (this.owner === bigBallShooter) {
    fill(0, 160, 255);
  } else {
    fill(255, 0, 0);
  }
  translate(this.x, this.y);
  rotate(this.a);
  ellipse(0, 0, this.owner.size + 40, this.owner.size + 40);
  rotate(-this.a);
  translate(-this.x, -this.y);
};

var tank = function(x, y, size) {
  this.x = x;
  this.y = y;
  this.size = size;
  this.p = 4096;
  this.bi = 0;
  this.bb = [];
  this.a = 0;
  this.h = 3200;
  this.vb = 64;
  this.da = 5;
};
var o = 0;
tank.prototype.draw = function() {
  if (mouseX > this.x) {
    o = PI;
  } else {
    o = 0;
  }
  this.a = o + atan((mouseY - this.y) / (mouseX - this.x));
  translate(this.x, this.y);
  rotate(this.a);
  fill(160, 160, 160);
  rect(-50 - this.size, -25 - this.size / 2, 48 + this.size, 48 + this.size);
  fill(10, 130, 245);
  ellipse(0, 0, 52 + this.size, 52 + this.size);
  rotate(-this.a);
  fill(0, 255, 100);
  rect(-15, 15, this.h / 100, 5);
  translate(-this.x, -this.y);
};
tank.prototype.shoot = function() {
  this.vb = sqrt(this.p);
  var bb = this.bb;
  var i, b;
  if (this.bi === 0) {
    b = new bullet(this.x, this.y, this.a + 3 * PI / 2);
    b.owner = this;
    bb.push(b);
  }
  this.bi = (this.bi + 1) % round(this.vb);
  for (i = bb.length - 1; i >= 0; i--) {
    b = bb[i];
    if (b.gone()) {
      bb.splice(i, 1);
    }
  }
  fill(0, 255, 0);
  textSize(21);
  text("Reload=" + (65 - round(this.vb)) + "  Damage=" + this.da, 120, 30);
  for (i = 0; i < bb.length; i++) {
    bb[i].draw();
  }
  for (i = 0; i < s1.n.length; i++) {
    if (dist(s1.n[i].x + mx, s1.n[i].y + my, this.x, this.y) < 30) {
      this.h -= 330;
      s1.n[i].h -= 120;
    }
  }
  if (this.h <= 0 || go === true) {
    go = true;
  }
  if (this.h < 3200) {
    this.h += 1;
  }
};
var mx = screen.width / 2;
var my = screen.height / 2;
var grid = function() {
  stroke(200, 200, 200);
  translate(mx, my);
  for (i = -1000; i <= 1000; i += 25) {
    line(i, -1000, i, 1000);
  }
  for (ii = -1000; ii <= 1000; ii += 25) {
    line(-1000, ii, 1000, ii);
  }
  if (mouseX > screen.width / 2) {
    var o = PI;
  } else {
    o = 0;
  }
  var angle = o + atan((mouseY - screen.height / 2) / (mouseX - screen.width / 2));
  var yy = sin(angle);
  var xx = cos(angle);
  if (mx > -810 && mx < 1200) {
    mx += xx;
  } else if (mx < -810) {
    mx += 3;
  } else {
    mx -= 3;
  }
  if (my < 1300 && my > -660) {
    my += yy;
  } else if (my < -660) {
    my += 3;
  } else {
    my -= 3;
  }
  translate(-mx, -my);
  fill(230);
  rect(10, 10, 100, 100);
  translate(70, 75);
  fill(0);
  ellipse(-mx / 20, -my / 20, 8, 8);
  translate(-70, -75);
};
var square = function(x, y, a) {
  this.x = x;
  this.y = y;
  this.a = a;
  this.n = [];
  this.ri = 0;
  this.re = 6;
  this.h = 256;
};
square.prototype.draw = function() {
  translate(this.x, this.y);
  translate(mx, my);
  rotate(this.a);
  fill(255, 255, 0);
  rect(-16, -16, 32, 32);
  fill(0, 255, 0);
  rect(-16, -25, this.h / 8, 4);
  rotate(-this.a);
  translate(-mx, -my);
  translate(-this.x, -this.y);
};
square.prototype.dead = function() {
  return this.h <= 0;
};
square.prototype.make = function() {
  if (this.ri === 0) {
    var s = new square(random(-500, 500), random(-700, 700), random(-PI / 12, PI / 12));
    this.n.push(s);
  }
  this.ri = (this.ri + 1) % this.re;

  for (i = this.n.length - 1; i >= 0; i--) {
    s = this.n[i];
    if (s.dead()) {
      this.n.splice(i, 1);
      bigBallShooter.da += 1;
      if (bigBallShooter.p > 49) {
        bigBallShooter.p /= 1.03
      }
    }
  }
  for (i = 0; i < this.n.length; i++) {
    this.n[i].draw();
  }
  for (i = 0; i < this.n.length; i++) {
    for (ii = 0; ii < bigBallShooter.bb.length; ii++) {
      if (dist(this.n[i].x + mx, this.n[i].y + my, bigBallShooter.bb[ii].x, bigBallShooter.bb[ii].y) < (bigBallShooter.size + 50) / 2 + 12) {
        this.n[i].h -= bigBallShooter.da;
      }
    }
  }
  for (i = 0; i < this.n.length; i++) {
    for (ii = 0; ii < t1.n.length; ii++) {
      if (dist(this.n[i].x, this.n[i].y, t1.n[ii].x, t1.n[ii].y) < 30) {
        this.n[i].h -= 100;
      }
    }
  }
};
var tri = function(x, y) {
  this.x = x;
  this.y = y;
  this.ri = 0;
  this.n = [];
  this.s = 1.6;
  this.re = 390;
};
tri.prototype.kill = function() {
  if (screen.width / 2 > this.x + mx) {
    var s = PI;
  } else {
    s = 0;
  }
  this.a = 3 * PI / 2 + s + atan((screen.height / 2 - (this.y + my)) / (screen.width / 2 - (this.x + mx)));
  this.xs = this.s * sin(this.a);
  this.ys = this.s * cos(this.a);
  this.x += this.xs;
  this.y -= this.ys;
};
tri.prototype.draw = function() {
  this.kill();
  translate(this.x, this.y);
  translate(mx, my);
  rotate(this.a);
  fill(255, 0, 0);
  triangle(-12, +9, +0, -12, +12, +9);
  rotate(-this.a);
  translate(-mx, -my);
  translate(-this.x, -this.y);
};
tri.prototype.hits = function() {
  for (ii = 0; ii < bigBallShooter.bb.length; ii++) {
    if (dist(this.x + mx, this.y + my, bigBallShooter.bb[ii].x, bigBallShooter.bb[ii].y) < (bigBallShooter.size + 50) / 2) {
      var a = true;
    } else {
      a = false;
    }
  }
  return a;
};
tri.prototype.make = function() {
  if (this.ri === 0) {
    var t = new tri(random(350), random(610));
    this.n.push(t);
  }
  this.ri = (this.ri + 1) % this.re;
  for (i = this.n.length - 1; i >= 0; i--) {
    t = this.n[i];
    if (t.hits()) {
      bigBallShooter.da += 1;
      bigBallShooter.p /= 1.05;
      this.n.splice(i, 1);
    }
  }
  for (i = 0; i < this.n.length; i++) {
    this.n[i].draw();
    if (dist(this.n[i].x + mx, this.n[i].y + my, bigBallShooter.x, bigBallShooter.y) < 17) {
      bigBallShooter.h -= 1000;
      this.n.splice(i, 1);
    }
  }
};
var enemy = function(s, d, v) {
  this.s = s;
  this.d = d;
  this.v = v;
  this.x = 187;
  this.y = 50;
  this.a = 0;
  this.bi = 0;
  this.r = 20;
  this.h = 1000;
  this.hh = 1000 / this.s;
  this.bb = [];
};
enemy.prototype.draw = function() {
  if (bigBallShooter.x > this.x) {
    var oo = PI;
  } else {
    oo = 0;
  }
  this.a = oo + atan((bigBallShooter.y - this.y) / (bigBallShooter.x - this.x));
  translate(this.x, this.y);
  rotate(this.a);
  fill(160, 160, 160);
  rect(-this.s, -this.s / 2, this.s, this.s);
  fill(255, 0, 0);
  ellipse(0, 0, this.s, this.s);
  rotate(-this.a);
  fill(0, 255, 0);
  rect(-this.s / 2, this.s / 2, this.h / this.hh, 7);
  translate(-this.x, -this.y);
};
enemy.prototype.shoot = function() {
  var eb = this.bb;
  var e, i;
  if (this.bi === 0) {
    e = new bullet(this.x, this.y, this.a + 3 * PI / 2);
    e.owner = this;
    eb.push(e);
  }
  this.bi = (this.bi + 1) % this.r;
  for (i = eb.length - 1; i >= 0; i--) {
    e = eb[i];
    if (e.gone()) {
      eb.splice(i, 1);
    }
  }
  for (i = 0; i < eb.length; i++) {
    eb[i].draw();
  }
  println(eb[0].x, eb[0].y);
  /*fill(0,255,0);
  textSize(21);
  text("Reload="+(65-round(this.vb))+"  Damage="+this.da,120,30);
  for(i=0;i<s1.n.length;i++){
     if(dist(s1.n[i].x+mx,s1.n[i].y+my,this.x,this.y)<30){
        this.h-=330;
        s1.n[i].h-=120;
     }
  }
  if(this.h<=0 || go===true){
     go=true;
  }
  if(this.h<3200){
     this.h+=2.2;
  }*/
};
var bigBallShooter;
var s1;
var t1;
var en;
void setup() {
  size(screen.width, screen.height);
  bigBallShooter = new tank(187.5, 333.5, -16);
  en = new enemy(50, 10, 2.6);
  s1 = new square();
  t1 = new tri(200, 200, 1);
}
void draw() {
  background(250);
  if (go === false) {
    grid();
    fill(10, 100, 255);
    bigBallShooter.shoot();
    bigBallShooter.draw();
    en.shoot();
    en.draw();
    s1.make();
    t1.make();
  } else if (go === true) {
    background(0);
    textSize(100);
    fill(255, 0, 250);
    text("GAME", 10, 170);
    text("OVER", 10, 370);
    if (mousePressed) {}
  }
}