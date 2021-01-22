class Background{
   int livesCounter;
   int score;
   int j;
   int[] starX=new int[100];
   int[] starY=new int[100];
   int[]  seaX = new int[41];
   int[] seaY = new int[41];
   float sunX;
   float sunY;
   boolean waveUp; 
   boolean day;
   color seaColor;
   Time timer, message;
   String msg = "Use RIGHT, LEFT, UP and DOWN arrow keys to move the target.\n "+
                 "Press CTRL key ONCE to shoot the harpoon.\n "+
                 "Wait to the harpoon to fully retract before shooting again.";
   Background(){
     livesCounter = 10;
     score=0;
     j = 0;
     sunX=width/2;
     sunY=height/15;
     waveUp = true;
     day=true;
     timer = new Time();
     message = new Time();
   }
  void update(GameLevel level){
    seaColor = color(170, 170, 255); 
    int red=80;
    int green=100;
    int blue=255;    
    int moonAlpha=0;
    int seaRed=170;
    int seaGreen=170;
    int seaBlue=255;
    if(sunY>height/8 && sunY<=height/4){
           red=(int)(140-480*sunY/height); 
           green=(int)(160-480*sunY/height); 
           blue=(int)(415-1280*sunY/height);
           moonAlpha= (int)(1920*sunY/height -240);
           seaRed=(int)(250-640*sunY/height);
           seaGreen=(int)(250-640*sunY/height);
           seaBlue=(int)(375-960*sunY/height);
           seaColor=color(seaRed,seaGreen,seaBlue);
     } else if(sunY>height/4) {
                red=20;green=40;blue=95;
                moonAlpha= 240;
                seaColor=color(90,90,135);
             }
    fill(red,green,blue);
    rect(0, 0, width, height/4+10);
    // Draw Moon
    noStroke();
    fill(255,255,255,moonAlpha);
    ellipse(5*width/6,height/15,height/20,height/20);
    stars();    // Draw Stars
    fill(red,green,blue);    
    ellipse((5*width/6)-height/60,height/15,height/20,height/20);  // Draw moon
    stroke(0);
    if(sunX>0 && day){
      if(sunY<height/6)fill(255,255,0); 
          else fill(255,255-2*(sunY-height/6),0);
     strokeWeight(0);     
       ellipse(sunX,sunY,height/25,height/25);  // draw sun
       if(timer.elapsed(100)){
          sunX-=1;
          sunY= 19*height/60-height*sqrt(1-(pow(((width/2)-sunX),2)/pow(width/2,2)))/4;
          timer.startTime();
       }   
    }  else{ day= false; 
            // sunX=width/10;
            }
    if(sunX>=0 && sunX<width && !day)sunX+=1;
        else day=true;
     // Draw Island
    fill(80,40,0);
    ellipse(width/3,height/4+20,2*width/5,height/12); // Draw island
    stroke(210,110,0);
    strokeWeight(6);
    line(width/5,height/4-5,width/5-10,height/5-30);  // Draw Trees
    line(width/5+10,height/4-5,width/5+10,height/5-30);  
    line(7*width/15,height/4-5,7*width/15-10,height/5-30);
    line(7*width/15+10,height/4-5,7*width/15+10,height/5-30);  
    line(width/3,height/4-10,width/3-10,height/5-30);
    line(width/3+10,height/4-10,width/3+10,height/5-30);  
    line(width/3+15,height/4-10,width/3+20,height/5-30); 
    
    fill(0,100,0);
    stroke(0);
    strokeWeight(1);    
    ellipse(width/5-10,height/5-30,20,20);
    ellipse(width/5+10,height/5-30, 25,20);
    ellipse(7*width/15-10,height/5-30,20,20);
    ellipse(7*width/15+10,height/5-30, 25,20);
    ellipse(width/3-10,height/5-30,28,20);
    ellipse(width/3+10,height/5-30, 25,20);
    ellipse(width/3+20,height/5-30, 32,20);
    
     
    
    fill(seaColor);
    rect(0, 10+height/4, width, 3*height/4-10);

  for(int i=0;i<=40;i++){
        seaX[i] = i*width/40; 
         seaY[i] = (int)((height/4)+(j)*sin(radians(seaX[i]))/10);
  }
 
  for(int i=0; i<40;i++){  
      line(seaX[i],seaY[i],seaX[i+1],seaY[i+1]);
      stroke(seaColor);
      strokeWeight(3);
      for(int m =1 ;m<10;m++){
            line(seaX[i],seaY[i]+3*m,seaX[i+1],seaY[i+1]+3*m);
      }
      strokeWeight(1);
      stroke(0,0,1);
   }
   
   if(j<=150 && waveUp)j++;
     else{ if(j>=-150){
                j--;
                waveUp=false;
              }  else waveUp = true; 
    }  // End of if(j<=150 && waveUp)
   navBar(level);
  if(level==GameLevel.LEVEL3 && message.getFirst()){
      message.startTime();
      message.setFirst(false);
  }
  if(level==GameLevel.LEVEL3 &&!message.elapsed(10000)){
      textSize(32);
      fill(255,0,0);
      text(msg,width/8,2*height/5);
  }
   
} // End of update()

    
void navBar(GameLevel level){
      fill(220);      
      rect(0,0,width,30);
      fill(255,0,0);
      rect(width-30,0,30,30);
      fill(0);
      textSize(20);
      text("X",width-20,20);
      text("Lives : "+ livesCounter,50,20);
      text("Score : " + score,450,20); 
      text("Number of Fishes : "+myShoal.size(),600,20);
      text(" "+level,width-300,20);
  }  // End Of Navigation Bar
  
  void stars(){
    if(timer.getFirst()){
      for(int i=0; i<100;i++){
         starX[i]=(int)random(0,width);
         starY[i]=(int)random(30,height/5);
      } 
     timer.setFirst(false); 
   } 
       for(int i=0;i<100;i++) ellipse(starX[i],starY[i],2,2);    
  }
  void setScore(){score=0;}
  void score(){ 
          if(level == GameLevel.LEVEL3) score +=10;
              else score++;
  }
  void setLives(int i){livesCounter = i;}
  void lives(){livesCounter--;}
  int getScore(){ return score;}
  boolean getLives(){return (livesCounter<=0);}
  color getSeaColor(){return seaColor;}
  int getSeaY(int x){return (int)((height/4)+(j)*sin(radians(x))/10);}
}