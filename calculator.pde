const yellow1=color(255,200,0);
const cyan1=color(0,255,200);
const pink1=color(255,120,255);
const blue1=color(100,100,255);
const green1=color(160,255,160);

var cs=1;
var numbers=[];
var symbols=[];
var row=0;
var clicked=false;

var context={
   text:"", 
   value:""
};

var Button=function(x,y,w,h,t,v,id,r,g,b,f){
   this.x=x;
   this.y=y;
   this.w=w;
   this.h=h;
   this.t=t;
   this.v=v;
   this.id=id;
   this.r=r;
   this.g=g;
   this.b=b;
   this.f=f;
   this.pressed=false;
   this.df=function(cc) {cc.text+=this.t;};
};

Button.prototype.in=function(x,y) {
   return x<=this.x+this.w/2 && x>=this.x-this.w/2 && y<=this.y+this.h/2 && y>=this.y-this.h/2;
};

Button.prototype.onClick=function(cc) {
   if(this.f) this.f(cc);
   else this.df(cc);
};

Button.prototype.draw=function(){
   rectMode(CENTER);
   textAlign(CENTER,CENTER);
   textSize(min(this.w,this.h)/1.5);
   if(this.id<28 && this.id>22){
      textSize(22);
   }
   if(this.pressed){
      fill(255);
   }
   else{
      fill(this.r,this.g,this.b);
   }
   rect(this.x,this.y,this.w,this.h);
   fill(0);
   text(this.t,this.x,this.y);
};

var play=function(cc){
   textAlign(LEFT,LEFT);
   textSize(28);
   text(cc.text,20,68);
   //text(tet,30,120);
   line(0,180,375,180);
   textSize(20);
   text("ANS="+cc.value,20,210);
   
   if(row+cc.text.length>=22){
      cc.text+="\n";
      row-=22;
   }
};

var keys1=function(){
   var ii,i,button;
   var page=numbers;
   var pp=function(p){return function(cc){cs=p;}};
   var ac=function(cc){cc.text="";cc.value="";};
   var eq=function(cc){if(cc.text!==""){cc.value=eval(cc.text).toFixed(10);}};
   page.push(new Button(36,380,60,40,"•",".",18,100,100,255));
   page.push(new Button(110,380,50,50,"AC","",0,255,180,180,ac));
   page.push(new Button(200,375,100,48,"Shift","",16,255,255,100,pp(1)));
   page.push(new Button(300,380,84,56,"=","=",17,100,100,255,eq));
   // 1~9
   for(ii=0;ii<3;ii++){
      for(i=0;i<3;i++){
         page.push(new Button(40+i*64,440+ii*64,60,60,ii*3+i+1,ii*3+i+1,ii*3+i+1,255,200,0));
      }
   }
   // +-*/
   var d=68;
   page.push(new Button(250,440,64,64,"➕","+",10,0,255,200));
   page.push(new Button(250+d,440,64,64,"➖","-",11,0,255,200));
   page.push(new Button(250,440+d,64,64,"❌️","*",12,0,255,200));
   page.push(new Button(250+d,440+d,64,64,"➗","/",13,0,255,200));
   // 0,"⬅"
   page.push(new Button(250,570,72,56,"0","0",14,255,120,255));
   var bk=function(cc){
      if(cc.text.length>0) {cc.text=cc.text.substring(0,cc.text.length-1);}
      if(cc.text.substring(cc.text.length-5,cc.text.length)==="Math."){
         cc.text=cc.text.substring(0,cc.text.length-5);
      }
   };
   page.push(new Button(250+d,570,72,56,"🔙","",15,255,120,255,bk));
};

void setup() {
   size(screen.width, screen.height);
   smooth();
   keys1();
}

void draw() {
   background(170,200,224);
   play(context);
   var i;
   for(i=0;i<numbers.length;i++) {
      numbers[i].draw();
   }
   if(clicked) {
      for(i=0;i<numbers.length;i++) {
         if(numbers[i].in(mouseX, mouseY)) {
            numbers[i].onClick.bind(numbers[i])(context);
         }
      }
      clicked=false;
   }
}

void mouseClicked(){
   clicked=true;
}