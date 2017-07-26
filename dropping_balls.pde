void setup() {
   size(screen.width, screen.height);
   
   x=screen.width/2;
   y=520;
   ys=30;
   
   
   a=50;
   b=0;
   ab=150;
   
   c=140;
   d=0;
   cd=170;
   
   e=210;
   f=-700;
   ef=1800;
   
   g=175;
   gg=-1700;
   gh=13000;
   
   aa=50;
   bb=-10000;
   aaa=150
   bbb=-10000;
   
   
   bd=0;
   p=1;
   
   s=0;
   h=400;
   dd=11;
   level=1;
   ys=36;
   
}

void draw() {
   z=dd+24;
   background(0,0,255);
   //pause
   fill(190,0,255);
   rect(190,540,50,55);
   textSize(22);
   fill(0,0,150);
   text("Pau",197,560);
   text("se",204,584);
   if(mouseX<230 && mouseX>190 && mouseY<595 && mouseY>540){
      fill(255,0,0);
      rect(190,540,50,55);
      fill(0,0,150);
      text("Pau",197,560);
      text("se",204,584);
      ps=0;
      ys=0;
      }else{
         
         ps=p*z/30;
         ys=30;
      }
      x=mouseX;
      line(0,530,375,530);
      fill(210,250,120);
      ellipse(x,y,z,z);
      if(mousePressed && mouseY<530 && mouseY >84){y-=ys;}
      else{y=520}
      if(y<0){y=520}
      
      ellipse(a,b,50,50); // num1
      rect(a-25,b-45,ab/2.5,10);
      b+=ps;
      if(dist(x,y,a,b)<z/2+25 && b<480+bd){
         ab-=dd;
      }
      if(dist(a,b,a,400)<95 && shield===true){
         ab-=dd;
      }
      if(ab<=0){
         a=random(350);
         b=0;
         ab=100;
         s+=100;
         p=1;
      }
      if(b>=510+bd){
         h-=68;
         a=random(350);
         b=0;
      }
      ellipse(c,d,50,50); // num2
      rect(c-25,d-45,cd/2.5,10);
      d+=ps;
      if(dist(x,y,c,d)<z/2+25 && d<480+bd){
         cd-=dd;
      }
      if(dist(c,d,c,400)<95 && shield===true){
         cd-=dd;
      }
      if(cd<=0){
         c=random(350);
         d=0;
         cd=100;
         s+=100;
      }
      if(d>=510+bd){
         h-=68;
         c=random(350);
         d=0;
         cd=100;
      }
      ellipse(e,f,100,100); // num3
      rect(e-35,f-65,ef/17,10);
      f+=ps/1.8;
      if(dist(x,y,e,f)<z/2+50 && f<450+bd){
         ef-=dd-2;
      }
      if(dist(e,f,e,400)<120 && shield===true){
         ef-=dd;
      }
      if(ef<=0){
         e=random(350);
         f=-500;
         ef=700;
         s+=300;
      }
      if(f>=480+bd){
         h-=200;
         e=random(350);
         f=-500;
         ef=700;
      }
      ellipse(g,gg,260,260); // num4
      gg+=ps/4;
      if(dist(x,y,g,gg)<z/2+140 && gg<450+bd){
         gh-=dd;
      }
      if(dist(g,gg,g,400)<210 && shield===true){
         gh-=dd;
      }
      if(gh<=0){
         g=screen.width/2;
         gg=-1000;
         gh=10000+z*200;
         s+=5000;
      }
      if(gg>=400+bd){
         h-=800;
         g=screen.width/2
         gg=-2200;
         gh=10000+z*200;
      }
      fill(0,0,255);
      textSize(80);
      text(gh,g-100,gg+50);
      
      //num 5,6,7
      
      fill(255,0,255);
      ellipse(aa,bb,30,30);
      bb+=ps*3.5;
      if(dist(x,y,aa,bb)<z/2+15){
         bb=0;
         aa=random(350);
         s+=70;
      }
      if(dist(aa,bb,aa,400)<70 && shield===true){
         bb=0;
         aa=random(350);
         s+=70;
      } 
      if(dist(aa,bb,aa,530)<15){
         h-=100;
         bb=0;
         aa=random(350);
      }
      fill(255,0,255);
      ellipse(aaa,bbb,30,30);
      bbb+=ps*3.5;
      if(dist(x,y,aaa,bbb)<z/2+15){
         bbb=0;
         aaa=random(350);
         s+=70;
      }
      if(dist(aaa,bbb,aaa,400)<70 && shield===true){
         bbb=0;
         aaa=random(350);
         s+=70;
      } 
      if(dist(aaa,bbb,aaa,530)<15){
         h-=100;
         bbb=0;
         aaa=random(350);
      }
      
      
      shield=false;
      go=false;
      if(f>-700 && f<-600){
         textSize(50);
         fill(255,0,255);
         text("Level"+level,100,300);
      }
      if(bbb>-100 && bbb<0){
         level=2;
         text("Level"+level,100,300);
      }
      
      //Freeze
      textSize(13);
      fill(190,0,255);
      rect(10,540,50,55);
      fill(0,0,150);
      text("Freeze",16,565);
      text("$700",19,585);
      
      if(mousePressed && mouseX<60 && mouseX>10 && mouseY<595 && mouseY>540 && s>=700){
         fill(255,0,0);
         rect(10,540,50,55);
         fill(0,0,150);
         text("Freeze",16,565);
         text("$700",19,585);
         p=0;
         s-=700;
      }
      //Upgrade damage
      md=dd*dd*dd;
      fill(190,0,255);
      rect(70,540,50,55);
      fill(0,0,150);
      textSize(11);
      text("Upgrade",76,553);
      text("damage",79,570);
      text("$"+md,73,587);
      if(mousePressed && mouseX<120 && mouseX>70 && mouseY<595 && mouseY>540 && s>=md){
         fill(255,0,0);
         rect(70,540,50,55);
         fill(0,0,150);
         textSize(16);
         text("Upgrade",76,553);
         text("damage",79,570);
         text("$"+md,73,587);
         dd+=2.5;
         s-=md;
      }
      //body damage
      fill(190,0,255);
      rect(130,540,50,55);
      textSize(17);
      fill(0,0,150);
      text("Body",135,555);
      textSize(12);
      text("Damage",135,569);
      textSize(16);
      text("$3300",135,585);
      if(mousePressed && mouseX<180 && mouseX>130 && mouseY<595 && mouseY>540 && s>=3300 && bd===0){
         fill(255,0,0);
         rect(130,540,50,55);
         fill(0,0,150);
         text("Body",135,555);
         textSize(12);
         text("Damage",135,569);
         textSize(16);
         text("$3300",135,585);
         s-=3300;
         bd=100;
         dd+=4;
         
      }
      if(bd>10){
         fill(255,0,255);
         rect(130,540,50,55);
         fill(0,0,150);
         text("Body",135,555);
         textSize(12);
         text("Damage",135,569);
         textSize(16);
         text("$3300",135,585);
      }
      //score and health and power
      textSize(50);
      fill(102,103,0);
      text("$"+s,135,50);
      textSize(20);
      fill(0,255,50);
      text(h,320,550);
      text("Health",250,550);
      text("Damage/size:  "+dd,200,520);
      if(h<=0){
         textSize(100);
         fill(255,0,250);
         text("GAME",10,170);
         text("OVER",10,370);
         x=screen.width/2;
         y=520;
         ys=30;
         go=true;
      }
      if(mousePressed && go===true){
         a=50;
         b=0;
         ab=150;
         
         c=140;
         d=0;
         cd=170;
         
         e=210;
         f=-700;
         ef=1800;
         
         g=175;
         gg=-1700;
         gh=13000;
         
         aa=50;
         bb=-10000;
         aaa=150
         bbb=-10000;
         
         
         bd=0;
         p=1;
         
         s=0;
         h=400;
         dd=11;
         level=1;
         ys=30;
      }
      //shield
      fill(190,0,255);
      rect(10,10,100,50);
      fill(0,0,0);
      textSize(20);
      text("Shield",20,30);
      text("$4.50",25,55);
      if(mousePressed && mouseX<110 && mouseX > 10 && mouseY<60  && mouseY >10 && s>0){
         fill(255,0,0);
         rect(10,10,100,50);
         fill(0,0,0);
         textSize(20);
         text("Shield",20,30);
         text("$4.50",25,55);
         line(0,470,375,470);
         line(0,440,375,440);
         line(0,420,375,420);
         line(0,400,375,400);
         s-=4;
         shield=true;
      }
      
      
      
      
      //restart
      fill(183,103,255);
      rect(260,560,100,30);
      fill(0);
      text("restart",280,580);
      if(mousePressed && mouseX<360 && mouseX>260 && mouseY<590 && mouseY>560){
         fill(255,0,0);
         rect(260,560,100,30);
         fill(0);
         text("restart",280,580);
         x=screen.width/2;
         y=520;
         ys=30;
         
         
         a=50;
         b=0;
         ab=150;
         
         c=140;
         d=0;
         cd=170;
         
         e=210;
         f=-700;
         ef=1800;
         
         g=175;
         gg=-1700;
         gh=13000;
         
         aa=50;
         bb=-10000;
         aaa=150
         bbb=-10000;
         
         
         bd=0;
         p=1;
         
         s=0;
         h=400;
         dd=11;
         level=1;
         ys=30;
      }
      
   }
