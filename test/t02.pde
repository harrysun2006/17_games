void setup() {
   
   noStroke();
   
   size(screen.width, screen.height);
   sw=screen.width;
   sh=screen.height
   x=200;
   xs=1
   y=200;
   ys=1;
   x1=200;
   xs1=1
   y1=200;
   ys1=1;
   s=0;
}



void draw() {
   
   background(0,0,255);
   textSize(60);
   text(s,20,300);
   ellipse(x,y,50,50);
   rx=random(1);
   ry=random(1);
   if(mousePressed && dist(mouseX,mouseY,x,y)<25){
      
      fill(255,0,100);
      ellipse(x,y,50,50);
      s+=100;
      if(rx<0.5){
         x=0;
         xs=5;
      }else{x=sw;
      xs=-5;}
      
      if(ry<0.5){
         y=0;
         ys=5;
      } else {y=sh;
      ys=-5;}
      
   }else{fill (255,255,0);}
   
   x+=xs;
   y+=ys;
   if(x>sw){
      xs=-5;
   }
   if(x<0){
      xs=5;
   }
   if(y>sh-150){
      ys=-3;
   }
   if(y<0){
      ys=3;
   }
   ellipse(x1,y1,50,50);
   rx1=random(1);
   ry1=random(1);
   if(mousePressed && dist(mouseX,mouseY,x1,y1)<25){
      
      fill(255,0,100);
      ellipse(x1,y1,50,50);
      s+=100;
      if(rx1<0.5){
         x1=0;
         xs1=5;
      }else{x1=sw;
      xs1=-5;}
      
      if(ry1<0.5){
         y1=0;
         ys1=5;
      } else {y1=sh;
      ys1=-5;}
      
   }else{fill (255,255,0);}
   
   x1+=xs1;
   y1+=ys1;
   if(x1>sw){
      xs1=-5;
   }
   if(x1<0){
      xs1=5;
   }
   if(y1>sh-150){
      ys1=-3;
   }
   if(y1<0){
      ys1=3;
   }
}
