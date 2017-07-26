var red=color(255,0,0);
var blue=color(0,0,255);
var white=color(255,255,255);
var grey=color(192,192,192);
var dark=color(128,128,128);
var none=color(white,0);
var zoom=1;
var ww=screen.width;
var hh=screen.height;

void trace() {
   var ss=[];
   var pp=arguments || [];
   var i;
   for(i=0; i<pp.length; i++) {
      ss.push(typeof(pp[i])=="number" ? pp[i].toFixed(2) : pp[i]);      
   }
   println.apply(this,ss);
}

var Stage=function(w,h) {
   this.w=w;
   this.h=h;
   var i,j,m=[];
   for(i=0;i<h;i++) {
      m[i]=[];
      for(j=0;j<w;j++) m[i][j]=0;
   }
   this.map=m;
   this.objs=[];
};


var Tank=function(stage,x,y,g) {
   this.stage=stage;
   this.g=g; // group
   this.a=0; // angle
   this.x=x; // location
   this.y=y;
   this.w=30; // size
   this.h=50;
   this.va=PI/36; // angle speed
   this.vv=3; // lineal speed
   this.vx=0;
   this.vy=0;
   this.ta=0;
   this.tx=x;
   this.ty=y;
   this.vb=20;
   this.bi=0;
   this.bb=[];
};

Tank.prototype.head=function(mx,my) {
   this.tx=zoom*mx;
   this.ty=zoom*my;
};

Tank.prototype.shoot=function() {
   var bb=this.bb;
   var i,b;
   if(this.bi==0) {
      b=new Bullet(this.x,this.y,this.a);
      b.owner=this;
      bb.push(b);
   }
   this.bi=(this.bi+1)%this.vb;
   for(i=bb.length-1;i>=0;i--) {
      b=bb[i];
      if(b.gone()) {
         bb.splice(i,1);
      }
   }
   //trace(bb.length);
   for(i=0;i<bb.length;i++) {
      bb[i].draw();
   }
};

Tank.prototype.move=function() {
   if(this.y==this.ty) {
      if(this.tx>=this.x) {
         this.ta=PI/2;
      } else {
         this.ta=-PI/2;
      }
   } else {
      aa=atan((this.tx-this.x)/(this.y-this.ty));
      sx=(this.tx>=this.x);
      sy=(this.ty>=this.y);
      if(sy) {
         this.ta=PI+aa;
      } else if(sx) {
         this.ta=aa;
      } else {
         this.ta=2*PI+aa;
      }
   }
   this.vx=this.vv*sin(this.a);
   this.vy=this.vv*cos(this.a);
   //trace(this.ta*180/PI);

   //this.a+=this.va;
   if(this.a>this.ta) {
      this.a=this.ta;
   }
   this.a=this.ta;
   if(abs(this.x-this.tx)>abs(this.vx)) {
      this.x+=this.vx;
   }
   if(abs(this.y-this.ty)>abs(this.vy)) {
      this.y-=this.vy;
   }
   this.shoot();
};

Tank.prototype.frame=function() {
   stroke(grey);
   strokeWeight(1);
   fill(none);
   rect(-this.w/2,-this.h/2,this.w,this.h);
   noStroke();
}

Tank.prototype.draw=function() {
   this.move();
   translate(this.x,this.y);
   //trace(cx,cy,this.ta,this.a);
   //this.frame();
   fill(dark);
   rotate(this.a);
   rect(-8,-25,16,22);
   fill(this.g==1?blue:red);
   ellipse(0,10,30,30);
   rotate(-this.a);
   translate(-this.x,-this.y);
};

var Bullet=function(x,y,a) {
   this.owner=null;
   this.x=x;
   this.y=y;
   this.a=a;
   this.p=15;
   this.vv=5;
   this.vx=this.vv*sin(this.a);
   this.vy=this.vv*cos(this.a);
};

Bullet.prototype.fly=function(){
   this.x+=this.vx;
   this.y-=this.vy;
};

Bullet.prototype.gone=function(){
   return this.x<0 || this.x>ww
      || this.y<0 || this.y>hh
      || this.p<=0;
};

Bullet.prototype.draw=function(){
   this.fly();
   var g=this.owner.g;
   translate(this.x,this.y);
   rotate(this.a);
   stroke(g==1?red:blue);
   strokeWeight(this.p);
   line(0,20,0,20);
   noStroke();
   rotate(-this.a);
   translate(-this.x,-this.y);
};

var stage,tank1,tank2;

void setup() {
   size(screen.width, screen.height);
   smooth();
   //size(4800,3200);
   stage=new Stage(4800,4800);
   tank1=new Tank(stage,200,200,1);
   tank2=new Tank(stage,250,250,2);
}

void draw() {
   background(white);
   scale(1.0/zoom,1.0/zoom);
   if(mousePressed) {
      tank1.head(mouseX,mouseY);
   }
   tank1.draw();
   tank2.draw();
}
