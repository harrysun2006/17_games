noStroke();
var xp = 0;
var bullet = function(x, y, a) {
  this.owner = null;
  this.x = x;
  this.y = y;
  this.a = a;
  this.s = 8;
  this.xs = this.s * sin(this.a);
  this.ys = this.s * cos(this.a);
};
bullet.prototype.run = function() {
  this.x += this.xs;
  this.y -= this.ys;
};
bullet.prototype.gone = function() {
  return this.x < -1200 || this.x > 1200 ||
    this.y < -1200 || this.y > 1200;
};
bullet.prototype.draw = function() {
  this.run();
  if (this.owner !== big) {
    translate(mx, my);
  }
  if (this.owner === big) {
    fill(0, 0, 255);
  } else {
    fill(255, 0, 0);
  }
  translate(this.x, this.y);
  rotate(this.a);
  ellipse(0, 0, this.owner.size + 40, this.owner.size + 40);
  rotate(-this.a);
  if (this.owner !== big) {
    translate(-mx, -my);
  }
  translate(-this.x, -this.y);
};
var tank = function(x, y, size) {
  //if(this==big){
  this.x = x;
  this.y = y;
  /*  }else{this.x=random(-300,300);
  this.y=random(-300,300);*/
  this.size = size;
  this.bi = 0;
  this.bb = [];
  this.a = 0;
  this.h = this.size + 52;
};
var o = 0;
tank.prototype.draw = function() {
  if (mouseX > screen.width / 2) {
    o = PI;
  } else {
    o = 0;
  }
  if (this == big) {
    this.a = o + atan((mouseY - this.y) / (mouseX - this.x));
  } else {
    if (screen.width / 2 > this.x + mx) {
      var an = PI;
    } else {
      an = 0;
    }
    this.a = an + atan((screen.height / 2 - this.y - my) / (screen.width / 2 - this.x - mx));
  }


  translate(this.x, this.y);

  if (this !== big) {
    translate(mx, my);
  }
  rotate(this.a);
  fill(160, 160, 160);
  rect(-50 - this.size, -25 - this.size / 2, 48 + this.size, 48 + this.size);
  if (this === big) {
    fill(10, 130, 245);
  } else {
    fill(255, 0, 0);
  }
  ellipse(0, 0, 52 + this.size, 52 + this.size);
  rotate(-this.a);
  fill(0, 255, 0);
  rect(-(52 + this.size) / 2, (52 + this.size) / 2, this.h, 5);
  if (this !== big) {
    translate(-mx, -my);
  }
  translate(-this.x, -this.y);
};
tank.prototype.shoot = function() {
  var i, b;
  if (this === big) {
    this.vb = 10;
  } else {
    this.vb = 200;
  }
  if (this.bi === 0) {
    if (this === big) {
      b = new bullet(this.x, this.y, this.a + 3 * PI / 2);
    } else {
      b = new bullet(this.x, this.y, this.a + 3 * PI / 2);
    }

    b.owner = this;
    this.bb.push(b);
  }
  this.bi = (this.bi + 1) % this.vb;
  for (i = this.bb.length - 1; i >= 0; i--) {
    b = this.bb[i];
    if (b.gone()) {
      this.bb.splice(i, 1);
    }
  }
  for (i = 0; i < this.bb.length; i++) {
    this.bb[i].draw();
  }

  if (this !== big) {
    for (i = 0; i < big.bb.length; i++) {
      if (dist(big.bb[i].x, big.bb[i].y, this.x + mx, this.y + my) < 50) {
        this.h -= 0.4;
      }
    }
  }
  if (this === big) {
    for (i = 0; i < en.bb.length; i++) {
      if (dist(en.bb[i].x + mx, en.bb[i].y + my, this.x, this.y) < (en.size + 50) / 2 + 17) {
        this.h -= 0.7;
      }
    }
  }
  if (this === big) {
    for (i = 0; i < e.bb.length; i++) {
      if (dist(e.bb[i].x + mx, e.bb[i].y + my, this.x, this.y) < (e.size + 50) / 2 + 17) {
        this.h -= 0.7;
      }
    }
  }
  if (this === big) {
    for (i = 0; i < ee.bb.length; i++) {
      if (dist(ee.bb[i].x + mx, ee.bb[i].y + my, this.x, this.y) < (ee.size + 50) / 2 + 17) {
        this.h -= 0.7;
      }
    }
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
  var yy = 3 * sin(angle);
  var xx = 3 * cos(angle);
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
  if (big.h > 0) {
    fill(0, 0, 255);
    ellipse(-mx / 20, -my / 20, 6, 6);
  }
  if (en.h > 0) {
    fill(255, 0, 0);
    ellipse(en.x / 20, en.y / 20, 6, 6);
  }
  if (e.h > 0) {
    fill(255, 0, 0);
    ellipse(e.x / 20, e.y / 20, 6, 6);
  }
  if (ee.h > 0) {
    fill(255, 0, 0);
    ellipse(ee.x / 20, ee.y / 20, 6, 6);
  }
  translate(-70, -75);
};
var square = function(x, y, a) {
  this.x = x;
  this.y = y;
  this.a = a;
  this.n = [];
  this.ri = 0;
  this.re = 1;
  this.h = 160;
};
square.prototype.draw = function() {
  translate(this.x, this.y);
  translate(mx, my);
  rotate(this.a);
  fill(255, 255, 0);
  rect(-20, -20, 40, 40);
  fill(0, 255, 0);
  rect(-20, -30, this.h / 4, 5);
  rotate(-this.a);
  translate(-mx, -my);
  translate(-this.x, -this.y);
};
square.prototype.hit = function() {};
square.prototype.dead = function() {
  return this.h <= 0;
};
square.prototype.make = function() {
  var s = new square(random(-800, 600), random(-800, 700), random(PI));
  this.n.push(s);
  this.ri = (this.ri + 1) % this.re;

  for (i = this.n.length - 1; i >= 0; i--) {
    s = this.n[i];
    if (s.dead()) {
      this.n.splice(i, 1);
      xp += 100;
    }
  }
  for (i = 0; i < this.n.length; i++) {
    this.n[i].draw();
  }

  for (i = 0; i < this.n.length; i++) {
    for (ii = 0; ii < big.bb.length; ii++) {
      if (dist(this.n[i].x + mx, this.n[i].y + my, big.bb[ii].x, big.bb[ii].y) < (big.size + 50) / 2 + 25) {
        this.n[i].h -= 160;
      }
    }
  }
  for (i = 0; i < this.n.length; i++) {
    for (ii = 0; ii < en.bb.length; ii++) {
      if (dist(this.n[i].x + mx, this.n[i].y + my, en.bb[ii].x, en.bb[ii].y) < (en.size + 50) / 2 + 25) {
        this.n[i].h -= 160;
      }
    }
  }
};
var stop = function() {
  fill(0, 255, 0);
  rect(10, 530, 80, 60);
  textSize(25);
  fill(0, 0, 255);
  text("STOP", 15, 565);
};
var field = function(tankSize, bulSpeed, reload) {};

var big;
var squ;
var en;
var e;
var ee;
void setup() {
  size(screen.width, screen.height);
  big = new tank(187, 333, -20);
  en = new tank(-400, -500, 28);
  e = new tank(187, -400, 28);
  ee = new tank(0, 600, 28);
  squ = new square(187, 50, PI / 10);
}
void draw() {
  background(255);
  grid();
  fill(10, 100, 255);
  if (big.h > 0) {
    big.shoot();
    big.draw();
  } else {}
  if (en.h > 0) {
    en.shoot();
    en.draw();
  }
  if (e.h > 0) {
    e.shoot();
    e.draw();
  }
  if (ee.h > 0) {
    ee.shoot();
    ee.draw();
  }

  //squ.make();

  textSize(40);
  text(xp, 120, 50);
}