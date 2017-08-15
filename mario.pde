const red=color(255,0,0);
const green=color(0,255,0);
const purple=color(255,0,255);
const blue=color(0,0,255);
const yellow=color(255,255,0);
const orange=color(255,200,0);
const cyan=color(0,255,255);
const pink=color(255,170,200);

const tw1=2.5;
const tw2=4;
const gravity=9.0;
const speed=4;

var mouse=[];
var click=false;
var timer;
var pl=false;

var mouselength=function(){
   if(mousePressed){
      mouse.push(millis());
   }
   else{
      mouse=[];
   }
   timer=mouse[mouse.length-1]-mouse[0];
   
};
var ball=function(x,y,r){
   this.x=x;
   this.y=y;
   this.sy=this.y;
   this.sy2=this.y;
   this.sy1=this.y;
   this.r=r;
   this.mass=0.15;
   this.y1=6;
   this.y2=this.mass*gravity/10;
};
ball.prototype.draw=function(){
   fill(cyan);
   ellipse(this.x,this.y,this.r,this.r);
}
ball.prototype.jump=function(){
   mouselength();
   if(timer){
      this.mass=0.2-timer/800;
   }
   this.mass=constrain(this.mass,0.1,0.2);
   if(click==true || this.y<this.sy){
      click=false;
      if(this.y>=this.sy){
         this.y1=6*tw1;
         this.mass=0.15;
      }
      this.y1-=this.y2;
   }
   this.y2=this.mass*gravity/10*tw2;
   
   this.y-=this.y1;
   if(pl==true){
      this.sy=this.sy2;
   }
   else{
      this.sy=this.sy1;
   }
   if(pl==true && click==false){
      //this.y=this.sy2;
      //this.y1=0;
   }
   this.y=constrain(this.y,this.r/2,this.sy1);
};
var ground=function(){
   line(0,b.sy1+b.r/2,375,b.sy1+b.r/2);
   fill(green);
   rect(0,b.sy1+b.r/2,375,b.sy1+b.r/2);
};
var enemy=function(x,y){
   this.x=x;
   this.y=y;
   this.r=20;
   this.go=false;
   this.s=speed;
};
enemy.prototype.draw=function(){
   fill(yellow);
   ellipse(this.x,this.y,this.r*2,this.r*2);
   this.x-=this.s;
   if(dist(this.x,this.y,b.x,b.y)<this.r+b.r/2){
      this.go=true;
      if(mousePressed==false){
         if(this.y>b.y){
            b.y1*=-1;
            b.y1+=0.3;
         }
      }
   }
};
var l=0,r=14,lr=[],e,i;
var em=function(){
   if(l==0){
      float ee=random(b.sy-120,b.sy-20);
      e=new enemy(500,ee);
      lr.push(e);
   }
   for(i=lr.length-1;i>=0;i--) {
      e=lr[i];
      if(e.go==true || e.x<0) {
         lr.splice(i,1);
      }
   }
   for(i=0;i<lr.length;i++){
      lr[i].draw();
   }
   l=(l+1)%r;
};
var planks=function(x,y,l){
   this.x=x;
   this.y=y;
   this.l=l;
   this.s=speed;
};
planks.prototype.draw=function(){
   rect(CENTER);
   fill(purple);
   //rect(this.x,this.y,this.l,20);
   line(this.x,this.y,this.x+this.l,this.y);
   this.x-=this.s;
   if(b.x<this.x+this.l && b.x>this.x && b.y<this.y && this.y-b.y<b.r/2 && b.y1<0){
      b.y=this.y-b.r/2;
      if(click==false){
         b.y1=0;
         pl=true;
      }
      else{
         b.sy=b.sy2;
      }
   }
   else{
      pl=false;
   }
};
var p,lp=0,rp=100,pp=[];
var op=function(){
   if(lp==0){
      p=new planks(600,random(b.sy-400,b.sy-100),random(50,2000));
      pp.push(p);
   }
   for(i=0;i<pp.length;i++){
      pp[i].draw();
   }
   lp=(lp+1)%rp;
};
var b;
void setup() {
   size(screen.width, screen.height);
   smooth();
   frameRate(80);
   b=new ball(187,400,36);
}

void draw() {
   background(0,0,255);
   b.draw();
   b.jump();
   op();
   em();
   ground();
   text(pl+""+click,50,50);
}
void mousePressed(){
   click=true;
}