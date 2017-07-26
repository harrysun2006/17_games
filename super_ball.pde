void setup() {
   size(screen.width, screen.height);
   noStroke();
}
var x=20;
var y=1;
var q=1;
var o=1;
var oo=1;
var aa=0;
var z=1;
var ta=300;
var tb=400;

void draw() {
   var a=x*x/30;
   background(0,0,255);
   fill(255,0,255);
   rect(0,385,423,10);
   fill(255,255,0);
   ellipse(160,360+y,50,50);
   if(mousePressed || 360+y<361){
      y-=a*oo*z;
      x+=1.1*o*q;
   }
   if(mouseIsPressed && 360+y<361){
      q=0.2;
   }else{q=1;}
   if(y<-1){
      o=-1;
   }
   if(x<0){
      oo=-1;
   }
   if(360+y>361){
      x=20;
      y=1;
      o=1;
      oo=1;
   }
   if(y<-300){
      y=-300;
      q=3;
   }
   fill(255,0,0);
   triangle(ta-20,390,ta,346,ta+20,390);
   ta-=3;
   if(ta<0){
      ta=random(375,500);
   } 
   fill(255,0,0);
   triangle(tb-20,390,tb,346,tb+20,390);
   tb-=3;
   if(tb<0){
      tb=random(375,500);
   }
   if( dist(160,360+y,ta-20,390)<25 || dist(160,360+y,ta,346)<25){
      textSize(100);
      fill(255,0,250);
      text("GAME",10,170);
      text("OVER",10,370);
   }
   if( dist(160,360+y,tb-20,390)<25 || dist(160,360+y,tb,346)<25){
      textSize(100);
      fill(255,0,250);
      text("GAME",10,170);
      text("OVER",10,370);
   }
   
};
