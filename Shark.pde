
private class Shark extends SeaCreature{
  
    int[][][] sharkR = new int[66][200][3]; // 3-d array of integers will store pixel 
    int[][][] sharkL = new int[66][200][3];  // colours to render the shark.
    boolean swimUp;
    boolean swimDown;
    
    Time struggle;
    Shark(int x, float y, int size) {
         super(x,y,size);   
         String[] rgbShark; 
         swimUp = false;
         swimDown = false;
         formation = true;
         raised = false;
         struggle = new Time();
         rgbShark = loadStrings("data/sharkR.txt"); // Load from an external file the strings 
         for(int i=0; i<66; i++){                   // that contain the pixels colour values
           for(int j=0; j<200; j++){     
             for(int k=0; k<3; k++){   // Convert to integer and store in 3-D array
               sharkR[i][j][k] = Integer.parseInt(rgbShark[600*i+3*j+k]);  // Right oriented shark        
             }
           }
         }   
      
         rgbShark = loadStrings("data/sharkL.txt");
         for(int i=0; i<66; i++){
           for(int j=0; j<200; j++){     
             for(int k=0; k<3; k++){ 
               sharkL[i][j][k] = Integer.parseInt(rgbShark[600*i+3*j+k]); // Left oriented shark    
             }
           }
         }   
   
       }  // End of Constructor

    @ Override void move() {
      if(formation && x>width/3) x += speedX;
          else{ if(!harpooned){
             formation=false; 
             if(speedX >= 0 && x>=(width-105)){ 
                speedX = 10*random(-1.0,-0.2);  
                speedY=0;
             }else if(speedX < 0 && x<=105){
                      speedX = 10*random(0.5,1.0);  
                      speedY=0;
                    } 
             if(speedY >=0 && y>=(height-100)){
               speedY = random(-0.2,-0.1);
               swimDown = false;
             }
             if(speedY< 0 && y<=(2*height/5)){ 
                 speedY = random(0.1,0.2); 
                 swimUp = false;
             }
             if(timer.elapsed(2000)){
                speedX += pow(-1,(int)random(1,2.1))*5*random(1.0,3.0);
                if(!swimUp)speedY += random(-0.1,0.1);  
                timer.startTime();
             }   
           if(speedX<5 && speedX>0){
                     speedX=10;
                     if(!swimUp)speedY=0.1*speedX;
            }   
            if(speedX<0 && speedX>-5){
                     speedX=-10;
                     if(!swimDown)speedY=0.1*speedX;
            }   
            
            if((int)random(0,300)==20 && !swimDown) swimUp = true;
            if(swimUp) speedY = -abs(0.1*speedX);
            if((int)random(0,200)==20 && !swimUp) swimDown = true;
            if(swimDown) speedY = abs(0.2*speedX);

           if(speedX != 0)angle = atan(-speedY/speedX);
     
           }  // End of if(!harpooned) 
             else if(!raised) {
                    if(struggle.firstTime){
                        struggle.setFirst(false);
                        struggle.startTime();
                    }    
                    if(struggle.elapsed(20000)){
                      if( x<=105 || x>=(width-105))speedX=-speedX;
                      if( y>=(height-100) || y<=(2*height/5)) speedY=-speedY;  

                      if(speedX>0)speedX-=0.5;
                         else if(speedX<0) speedX+=0.5;
                      if(speedY>0)speedY-=0.5;
                         else if(speedY<0) speedY+=0.5;  
                      if(abs(speedX)<0.5)speedX=0;
                      if(abs(speedY)<0.5)speedY=0;
                      if(speedX==0 && speedY==0)raised = true;
                    }else{ // End of if(struggle.elapsed(20000))
                          if(speedX >= 0 && x>=(width-105)){ 
                               speedX = 10*random(-4.0,-2.0);  
                               speedY=0;
                          }else if(speedX < 0 && x<=105){
                                    speedX = 10*random(2.0,4.0);  
                                    speedY=0;
                                   } // End of if
                          if(speedY >=0 && y>=(height-100)){
                               speedY = random(-0.2,-0.1);
                               swimDown = false;
                           }
                           if(speedY< 0 && y<=(3*height/4)){ 
                               speedY = random(0.1,0.5); 
                               swimUp = false;
                           }
                           if(timer.elapsed(2000)){
                                speedX = pow(-1,(int)random(1,2.1))*10*random(2.0,5.0);
                                if(!swimUp)speedY += random(-0.1,0.1);  
                                timer.startTime();
                            }   
                           if(speedX<5 && speedX>0){
                               speedX=20;
                               if(!swimUp)speedY=0.05*speedX;
                           }   
                           if(speedX<0 && speedX>-5){
                               speedX=-20;
                               if(!swimDown)speedY=0.05*speedX;
                           }   
            
                           if((int)random(0,300)==20 && !swimDown) swimUp = true;
                           if(swimUp) speedY = -abs(0.05*speedX);
                           if((int)random(0,200)==20 && !swimUp) swimDown = true;
                           if(swimDown) speedY = abs(0.1*speedX);
                           if(speedX != 0)angle = atan(-speedY/speedX); 
                           if(x<100)x=120;
                           if(x>width-100)x=width-120;
                        }
             }  // End of else
         
        }   
       if(speedX>=0)right = true; 
             else right = false;
        x += speedX;
        y += speedY; 
      
  } // end of move() 
  
  @ Override void render(){
    pushMatrix();
    translate(x,y);
    rotate(-angle);
    noStroke();
    if(speedX>=0){
      for(int i=0; i<66; i++){
         for(int j=0; j<200; j++){
            if(sharkR[i][j][0]!= 170){ // Ignore thecolour of background "Transparency" 
               fill(sharkR[i][j][0],sharkR[i][j][1],sharkR[i][j][2]);
               ellipse(j-100,i-33,2,2);
            } // End of if 
         }
       }
     } else{ 
           for(int i=0; i<66; i++){
               for(int j=0; j<200; j++){
                  if(sharkL[i][j][0]!= 170){
                     fill(sharkL[i][j][0],sharkL[i][j][1],sharkL[i][j][2]);
                     ellipse(j-100,i-33,2,2);
                  } // end of if   
               }
             }
           } // End of else 
     popMatrix();   
  } // End of render
  
    @ Override void makeBubble(){     
      if((int)(random(80)) == 10 && !formation && !raised){ // let the shark sends bubbles at random       
           if(bubbleCounter<5){ // set the maximum number of bubble at once
                if(speedX>=0)bubbles.add(new Bubble(x+10+w/2,(int)y-10));  // Add bubbles to the array List
                   else bubbles.add(new Bubble(x-10-w/2,(int)y-10)); 
                bubbleCounter++;  // Count the bubbles
           }  
      }     
   } // End of makeBubble()
  
   @ Override boolean setSpeed(int xboat, int yboat, boolean right){
     int i;
     if(right) i=-1;
     else i=1;
     if(abs(x-xboat)>200 || abs(y-yboat)>100){
        if(abs(x-(xboat+i*(20+width/20)))<6){
           speedX = 0;
           if(y>100+height/4)speedY = -3;
               else speedY=0;
          angle =  HALF_PI;
        } else{
               angle = atan((yboat-y)/(x-(xboat+i*(20+width/20))));
              if(abs(x-(xboat+i*(20+width/20)))>5){
                  if(x<(xboat+i*(20+width/20)))speedX = 3;                 
                     else  speedX = -3;
              } else speedX=0;      
               if(y>100+height/4)speedY = -3;
                   else speedY=0;
              } // end of else       
       return false;
     } else return true;
   
   } // End of @ Override setSpeed()
}