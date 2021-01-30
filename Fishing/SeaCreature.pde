
private class SeaCreature {
  int x;
  float y;
  int w;
  int h;
  float speedX;
  float speedY;
  float angle;
  boolean caught = false;
  boolean harpooned = false;
  boolean right = false;
  boolean stationary = false;
  boolean raised;
  boolean formation;
  color fishColor;
  int bubbleCounter = 0;
  ArrayList<Bubble> bubbles = new ArrayList<Bubble>(); //Arraylist of bubbles
  Time timer;
  
  SeaCreature(int x, float y, int size, color fishColor, boolean f) {
    this.x = x;
    this.y = y;
     this.w = size;
     this.h = int(w/5); 
     this.fishColor = fishColor;
     this.formation=f;
     timer = new Time();
     if(!formation){
         do{
            this.speedX = 10*random(-0.5,0.5);
           }while(speedX < 2 && speedX > -2);
           this.speedY = 10*random(-0.5,0.5); 
     }else {
             speedX=-5; //speedX=-3
             speedY=0;
      }
      if(speedX != 0) angle = atan(-speedY/speedX);
            else if(speedY < 0) angle = HALF_PI;
                 else if(speedY > 0) angle = PI + HALF_PI;
                     else angle = 0;  

  }
  
   SeaCreature(int x, float y, int size){
    this.x = x;
    this.y = y;
     this.w = size;
     this.h = int(w/5); 
     this.fishColor = color(255);
     this.formation=false;
     timer = new Time();
     this.speedX = 20*random(-1.0,-0.2);
        
     this.speedY = 0; /*2*random(-0.5,0.5); */     
     if(speedX != 0) angle = atan(-speedY/speedX);
         else if(speedY < 0) angle = HALF_PI;
                else if(speedY > 0) angle = PI + HALF_PI;
                     else angle = 0;  
    } // End of Constructor
  

  void move() {
    if(formation){
        if(x<100 && speedX<=5 && speedY<=0){  //speedX <=3         
           speedY= - sqrt(25-pow(speedX,2)); // 9
           speedX+=0.25; // +=0.1
        }
        if(x>width/2 && speedX>=5) formation=false;
     }else{ //  if(formation)
             if(!stationary){
               if(speedX >= 0) if(x>=((width-20)-(w/2)*abs(cos(angle)))) speedX = 10*random(-0.5,-0.2);    
               if(speedX < 0) if(x<=(10+(w/2)*abs(cos(angle))))speedX = 10*random(0.2,0.5);
               if(speedY >=0) if(y>=((height-10)-(w/2)*abs(sin(angle)))) speedY = 10*random(-0.5,0);
               if(speedY< 0) if(y<=((height/2)+10+(w/2)*abs(sin(angle)))) speedY = 10*random(0.1,0.5);
   
               speedX = random(speedX-0.2,speedX+0.2);
               speedY = random(speedY-0.4,speedY+0.4);
   
             } // if(!stationary)
          }  // else
 
     if(speedX != 0) angle = atan(-speedY/speedX);
         else if(speedY < 0) angle = HALF_PI;
                else if(speedY > 0) angle = PI + HALF_PI;
                       else angle = 0;
     x += speedX;
     y += speedY;               
  } // end of move() 

  void render() {
       int x0,x1;
       float y0,y1,x0r,x1r, y0r,y1r;
       //float[][]  rotMatrix =  {{cos(angle), sin(angle)},{-sin(angle), cos(angle)}};
       y0 = 0;
      stroke(fishColor);
       for(x0=-w/2; x0<=(w/2)-1; x0++){       
           x1 = x0 + 1;
           y1 =  - ((h/2.0) *sqrt(1 - pow((2.0*(x1)/w),2.0))); 
         
           x0r = x0*cos(angle) + y0*sin(angle);
           y0r = y0*cos(angle) - x0*sin(angle);
           x1r = x1*cos(angle) + y1*sin(angle);
           y1r = y1*cos(angle) - x1*sin(angle);
          
        strokeWeight(2); 
        line((x),(y),(x1r+x),(y1r+y));
        
        strokeWeight(1);
        line((x0r+x),y0r+y, (x1r+x),y1r+y);     
        y0 = y1;
         
   } 
   for(x0=-w/2; x0<=(w/2)-1; x0++){
       
         x1 = x0 + 1;
         y1 =  + ((h/2.0) * sqrt(1 - pow((2.0*(x1)/w),2.0)));   
         
         x0r = x0*cos(angle) + y0*sin(angle);
         y0r = y0*cos(angle) - x0*sin(angle);
         x1r = x1*cos(angle) + y1*sin(angle);
         y1r = y1*cos(angle) - x1*sin(angle);
         
        strokeWeight(2); 
        line((x),(y),(x1r+x),(y1r+y));
       
        strokeWeight(1);
        line((x0r+x),y0r+y, (x1r+x),y1r+y);
        y0 = y1;
   }    
   stroke(0);
  }


  void update() {
    move();
    render();
    for(int i =0 ; i<bubbles.size() ; i++){
       if(bubbles.get(i).checkBubble()) bubbles.get(i).update();
            else bubbleBurst(i);   
    }
  } // End of update()

  void  setXY(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  int getX(){return x;}
  int getY(){return int(y);}

  
  boolean insideNet(Boat theBoat) { 
    if (!caught && this.x <= theBoat.getLineX() + 10
           && this.x > (theBoat.getLineX() - 10)
           &&  this.y < theBoat.getLineY()
           && this.y > (theBoat.getLineY() - theBoat.getLineSize()/2)) caught = true;
    return caught;
  }
  
  boolean getCaught(){return caught;}
  void setCaught(){caught=true;}
   void makeBubble(){     
      if(int(random(100)) == 10  && timer.elapsed(2000) && !caught && !formation){        
           if(bubbleCounter<3){
                bubbles.add(new Bubble(x,int(y))); 
                bubbleCounter++;
                timer.startTime();
           }  
      }     
   }
   int bubbleX(int i){return bubbles.get(i).getX();}
   int bubbleY(int i){return bubbles.get(i).getY();}
   void bubbleBurst(int j){ 
       bubbles.remove(j);
       bubbleCounter--;   
   }
   int numBubbles(){return bubbles.size();}
   boolean form(){return formation;}
   boolean right(){ return right;}
   void harpooned(){harpooned=true;}
   boolean raised(){return raised;} 
   boolean setSpeed(int xboat, int yboat, boolean rigth){return false;}
  float angle(){return angle;}
}
