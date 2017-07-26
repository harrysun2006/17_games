var mx,my;
var a=PI/4;
var t=90;
var x=300;
var y=120;
var w=80;
var h=120;
var sx=2;
var sy=2;
var blue=color(0,0,255,t);

void trace() {
   var ss=[];
   var pp=arguments || [];
   var i;
   for(i=0; i<pp.length; i++) {
      ss.push(typeof(pp[i])=="number" ? pp[i].toFixed(2) : pp[i]);      
   }
   println.apply(this,ss);
}

void setup() {
   size(screen.width, screen.height);
   mx=screen.width;
   my=screen.height;
}

void draw0() {
   fill(255,0,0,t);
   rect(x,y,w,h);
}

void draw1(a) {
   fill(255,255,0,t);
   rotate(a);
   var x1=x+w/2;
   var y1=y+h/2;
   var b=atan(y1*1.0/x1);
   var c=a-b;
   var d=sqrt(x1*x1+y1*y1);
   var x2=d*cos(c)-w/2;
   var y2=-d*sin(c)-h/2;
   trace(b*180/PI,c*180/PI,d,x2,y2);
   rect(x2,y2,w,h);
   rotate(-a);
}

void draw2(a) {
   var x1=x+w/2;
   var y1=y+h/2;
   translate(x1,y1);
   rotate(a);
   rect(-w/2,-h/2,w,h);
   rotate(-a);
   translate(-x1,-y1);
}

void draw3() {
   fill(blue);
   rect(x-10,y-10,w+20,h+20);
}

void draw(){
   background(255,255,255);
   scale(1.0/sx,1.0/sy);
   stroke(200,200,200);
   line(x+w/2,0,x+w/2,sy*my);
   line(0,y+h/2,sx*mx,y+h/2);
   stroke(0,0,0);
   draw0();
   draw1(PI/6);
   //draw1(PI/4);
   //draw1(PI/3);
   draw2(PI/2);
   draw1(2*PI/3);
   //draw1(PI);
   draw2(4*PI/3);
   //draw1(5*PI/3);
   draw3();
}
