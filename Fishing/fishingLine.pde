
  private class fishingLine{
     int x;
     int y;
     int lineLength = 0;
     int lineDrag =0;     
     boolean lineUp = false;
     int size = height/5;
     
      fishingLine(int x, int y){
      this.x = x;
      this.y = y;
      }
      
      void render( boolean right){
        if(lineUp) {
              lineLength -= height/120;
              if(lineLength <= 0){
                     lineUp = false;
                     lineLength = 0;
              }       
        }    
        line(x,y,x-lineDrag,y+lineLength);
        noFill();
        if(lineLength >60 && right) {
             for(int i=0; i< 5; i++){
                     arc(x-lineDrag,y+lineLength-size/5,size,(i*size/10),HALF_PI, PI+HALF_PI);
             }        
        }
        if(lineLength >60 && !right){
              for(int i = 0; i< 5 ; i++){
                 arc(x-lineDrag,y+lineLength-size/5,size,(i*size/10), - HALF_PI,HALF_PI);
              }
        }      
      }
      
      void setXY(int x, int y){
           this.x = x;
           this.y = y;
      }
      
      int getX(){return (x-lineDrag);} 
      
      int getY(){return(y+lineLength);}
      
      int getDrag(){return lineDrag;}
      
      int getSize(){return size;}
     
      int getLength(){return lineLength; }
      
      void setLineUp(boolean a){lineUp=a;}
      boolean getLineUp(){return lineUp;}
       void reset(){lineLength = 0;}
       void increaseLine(){lineLength += height/80;}
       
       int direction(){
          if(lineLength >60 && lineDrag>=0) return 1;
                else return -1;
       }
   }
   