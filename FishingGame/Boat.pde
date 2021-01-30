
private class Boat{
   int x;
   int y;
   int dx;
   int size;
   float angle=0; 
   int shakeCounter = 0;
   boolean movingRight = true;
   boolean shake = false;
   fishingLine myFishingLine;
   Harpoon harpoon;
   Time timer; 
   Boat(int x, int y, int size){
       this.x = x;
       this.y = y;
       this.size = size;
       myFishingLine = new fishingLine(this.x-size/5,this.y-21*size/40);
       timer = new Time();
       harpoon = new Harpoon(this.x,y+height/2,size);
    }  
    
    void move(int arrowKey){
       if(arrowKey == 1) {
              dx = 20;
              if(myFishingLine.lineDrag <60 && myFishingLine.getLength()>0 
                       && myFishingLine.getLength()<200)
                                  myFishingLine.lineDrag += myFishingLine.getLength()/10;   
             if(myFishingLine.lineDrag <120 && 
                       myFishingLine.getLength()>201)
                             myFishingLine.lineDrag += myFishingLine.getLength()/20; 
       }  else if(arrowKey == -1){ 
                   dx = -20;
                  if(myFishingLine.lineDrag >-120 && myFishingLine.getLength()>0)myFishingLine.lineDrag -= (10*2*myFishingLine.getLength()/height);  
                 }     
               // else dx = 0;
       x = x+ dx;
       if(movingRight)myFishingLine.setXY(x-7*size/10,y-21*size/40);
          else myFishingLine.setXY(x+7*size/10,y-21*size/40);
       if(dx>0)dx-=10; 
       if(dx<0)dx+=10;
       if(dx==0 && myFishingLine.lineDrag >= 2) myFishingLine.lineDrag -=2;
       if(dx==0 && myFishingLine.lineDrag <= -2) myFishingLine.lineDrag +=2; 
       if(shake){
          if(shakeCounter == 0){
               x += 4;
               y += 4;
               shakeCounter++;
          }   else if(shakeCounter % 2 ==0){
                           x += 8;
                           y += 8;  
                           shakeCounter++;
                   } else if(shakeCounter < 30){
                            x -= 8;
                            y -= 8;
                            shakeCounter++;
                           } else {
                                    x -= 4;
                                    y -= 4;
                                    this.shake = false;
                                    shakeCounter = 0;
                                  }
      } // End of if(shake)      
  }  // End of void move()
  
    void render(int arrowKey){
        if((arrowKey == -1 && movingRight)||(arrowKey == 1 && !movingRight)){ 
                boatDesign(arrowKey);
                if( movingRight) movingRight = false;
                      else movingRight = true;  
         } else if(movingRight)boatDesign(1);
                    else boatDesign(-1);
        if(level != GameLevel.LEVEL3)myFishingLine.render(movingRight);
            else harpoon.update(getLineX(),getLineY(), movingRight); 
              
   } // End of void render(int arrowKey)


  void  boatDesign(int i){
  
    fill(150,0,0);
    stroke(150,0,0);
    rect(x,y,i*4*size/10,-(size/8));
    rect(x,y,-(i*size/2),-(size/8));
    triangle((x+i*4*size/10),y, (x+i*size/2),(y-(size/6)), (x+i*4*size/10),(y-(size/6)));
    fill(255);
    stroke(255);
    rect(x,y-(size/8),i*size/4,-size/10);
    rect(x+i*1*size/16,y-9*size/40, 3*i*size/16,-2*size/16);
    fill(200,180,255);
    ellipse(x+i*size/8,y-12*size/40,i*size/18,size/18);
    ellipse(x+12*i*size/64,y-12*size/40,i*size/18,size/18);
    fill(50);
    rect(x-(i*size/16),y-size/5, i*size/3, -size/40);
    fill(0,50,180);
    rect(x+i*size/16, y-7*size/20,11*i*size/50, -size/40);
    fill(150,0,0);
    stroke(150,0,0);
    rect(x+i*3*size/20,y-size/8,i*size/4,-size/24);

    fill(255);
    stroke(255);
   if(i == 1) arc(x+3*i*size/20,y-size/6, size/7, size/12, 0, HALF_PI);
         else arc(x+3*i*size/20,y-size/6, size/7, size/12, HALF_PI, PI);
    strokeWeight(size/50);
    stroke(40);
    line(x-3*i*size/10,y-size/8,x-i*7*size/10,y-21*size/40);
    strokeWeight(size/80);
    line(x-(i*9*size/20),y-size/8,x+int(i*(0.093*size-size/2)), y-int(0.22*size));     
  }
    void sinking(color seaColor){
      if(movingRight){
           sunkBow(1);
           sunkStern(1, seaColor);
      } else{
             sunkBow(-1);
             sunkStern(-1, seaColor);
          } 
    }
    void sunkBow(int i){
      int posX = x;
      int posY = y;
   if( y > height/4+50 && angle<=45){
       angle+=0.1;
   }
   if(y > height/4+50){
       posX = 0;
       posY = 0;
       pushMatrix();
       translate(x,y);
       rotate(radians(i*angle));
    }
    fill(150,0,0);
    stroke(150,0,0);
    rect(posX-15*i,posY,15*i+i*4*size/10,-(size/8));
    triangle(posX-15*i,posY,posX-15*i,posY-(size/24),posX-i*5-15*i,posY-(size/48));
    triangle(posX-15*i,posY-(size/24),posX-15*i,posY-(size/12),posX-i*8-15*i,posY-(size/20));
    triangle(posX-15*i,posY-(size/16),posX-15*i,posY-(size/8),posX-i*7-15*i,posY-(3*size/32));
    triangle((posX+i*4*size/10),posY, (posX+i*size/2),(posY-(size/6)), (posX+i*4*size/10),(posY-(size/6)));
    fill(255);
    stroke(255);
    rect(posX,posY-(size/8),i*size/4,-size/10);
    rect(posX+i*1*size/16,posY-9*size/40, 3*i*size/16,-2*size/16);
    fill(200,180,255);
    ellipse(posX+i*size/8,posY-12*size/40,i*size/18,size/18);
    ellipse(posX+12*i*size/64,posY-12*size/40,i*size/18,size/18);
    fill(50);
    rect(posX-(i*size/16),posY-size/5, i*size/3, -size/40);
    fill(0,50,180);
    rect(posX+i*size/16, posY-7*size/20,11*i*size/50, -size/40);
    fill(150,0,0);
    stroke(150,0,0);
    rect(posX+i*3*size/20,posY-size/8,i*size/4,-size/24);
    fill(255);
    stroke(255);
   if(i == 1) arc(posX+3*i*size/20,posY-size/6, size/7, size/12, 0, HALF_PI);
         else arc(posX+3*i*size/20,posY-size/6, size/7, size/12, HALF_PI, PI); 
         
   if(y > height/4+50) popMatrix();      
    }  
    
    void sunkStern(int i, color seaColor){
      fill(150,0,0);
      stroke(150,0,0);
      rect(x-(i*30),y,-(i*(size/2)),-(size/8));
      stroke(seaColor /*170, 170, 255*/);
      fill(seaColor/*170, 170, 255*/);
      triangle(x-(i*30),y,x-(i*30),y-(size/24),x-(i*36),y-(size/48));
      triangle(x-(i*30),y-(size/24),x-(i*30),y-(size/12),x-(i*36),y-(size/16));
      triangle(x-(i*30),y-(size/12),x-(i*30),y-(size/8),x-(i*36),y-(5*size/48));      
      strokeWeight(size/50);
      stroke(40);
      line(x-3*i*size/10-(i*30),y-size/8,x-(i*30)-i*7*size/10,y-21*size/40);
      strokeWeight(size/80);
      line(x-(i*9*size/20)-(i*30),y-size/8,x+int(i*(0.093*size-size/2))-(i*30), y-int(0.22*size));     
    }
    
    void update(int arrowKey, color seaColor){
      move(arrowKey);
      if(timer.elapsed(100)){ 
            checkSea(seaColor);
            timer.startTime();
       } 
       render(arrowKey);
    }
    
    void setLineUp(Boolean myBoolean){ myFishingLine.setLineUp(myBoolean);}
    
    int getLineX(){
          return myFishingLine.getX(); 
    }
    
    int getLineY(){
         return myFishingLine.getY(); 
    }
  
  boolean isHit(int bubbleX, int bubbleY){
       if(this.x <= (bubbleX+size/2) &&  this.x >= (bubbleX-size/2) &&
                 this.y >= bubbleY-5) return true;
           else  return false;     
  }   
    
  int getDrag(){
       return myFishingLine.getDrag(); 
  }
  
  void setMovingRight(boolean move){
        movingRight = move; 
  }
  
  boolean getMovingRight(){
      return movingRight; 
  }
  
  void releaseNet(){
      myFishingLine.increaseLine(); 
  }
  
  int getLineLength(){
     return myFishingLine.getLength(); 
  }
  
  int getLineSize(){
      return myFishingLine.getSize(); 
  }
   int direction(){
       return myFishingLine.direction();
   }
   
   void setY(int y){this.y=y;}
   int getX(){return x;}
   int getY(){return y;}
   int getSize(){return size;}
   void shake(){ this.shake = true;}
   void checkSea(color seaColor){
      color boatLevel = get(x,y-1);
      color boatTopLevel = get(x+5+size/2,y-5);
      if(boatLevel!=seaColor) y+=2;
          else if(boatTopLevel == seaColor ) y-=2;
   }
   void shoot(){harpoon.shoot();}
   boolean harpooned(){return harpoon.getCaught();}
   void setHarpoonX(int x, boolean right, float angle){harpoon.setX(x, right,angle);}
   void setHarpoonY(int y){harpoon.setY(y);}
   void raised(){harpoon.setRaised();}
   void reset(){
    harpoon.reset();
   } 
  void resetLine(){myFishingLine.reset();}
 }