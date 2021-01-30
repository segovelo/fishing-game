
class Harpoon{
      int x;
      int y;
      int size;
      boolean shoot;
      boolean reachTarget;
      boolean caught;
      boolean retracting;
      boolean raised;
      int dx;

  Harpoon(int x, int y, int size){
    this.x = x;
    this.y = y;
    this.size = size;
    shoot=false;
    reachTarget=false;
    caught=false;
    retracting=false;
    raised = false;
    dx = 0;
  }

  void update(int x1, int y1, boolean right){
      int i;  
      float angle;
      if(right) i=-1;
            else i=1;
     if(!caught) x=x1+i*60;    
      if(x!=x1) angle = atan((y-y1)/(x-x1)); 
                else angle=PI/2;
     if(!reachTarget && !caught){ 
       stroke(255,0,0);
       noFill();
       strokeWeight(8);
       arc(x,y,50,50,0.35,1.22);
       arc(x,y,50,50,1.92,2.79);
       arc(x,y,50,50,3.49,4.36);
       arc(x,y,50,50,5.06,5.93);
       strokeWeight(4);
       line(x,y-10,x,y-35);
       line(x,y+10,x,y+35);
       line(x-10,y,x-35,y);
       line(x+10,y,x+35,y);
     }
      stroke(70,70,0);
      strokeWeight(3);  

      if(caught) line(x1,y1,x,y-10); // harpoon Line
         else if(shoot){ 
                 line(x1,y1,x1+i*dx*cos(angle), y1+i*dx*sin(angle));   // harpoon Line  
                 line(x1+i*dx*cos(angle), y1+i*dx*sin(angle),  // Harpoon Spear
                      x1+i*dx*cos(angle) - i*20*cos(angle-i*0.52) ,  
                      y1+i*dx*sin(angle)  - i*20*sin(angle-i*0.52));
                 line(x1+i*dx*cos(angle), y1+i*dx*sin(angle),     // harpoon Spear
                      x1+i*dx*cos(angle) - i*20*cos(angle+i*0.52) ,  
                      y1+i*dx*sin(angle)  - i*20*sin(angle+i*0.52));
                      
                  if(y-(y1+i*dx*sin(angle))>0 && !reachTarget) dx +=20;
                      else {               
                         reachTarget = true; 
                         if(!retracting){
                             for(int m=-8;m<8;m++){
                               for(int n=-8;n<8;n++){
                                 int pixelRed = (int)get(x+m,y+n)>>16 & 0xFF;
                                 int pixelGreen = (int)get(x+i,y+n)>>8 & 0xFF;
                                 int pixelBlue = (int)get(x+i,y+n) & 0xFF;
                                 if((pixelRed==84 && pixelGreen==109 && pixelBlue==142) ||
                                   (pixelRed==180 && pixelGreen==180  && pixelBlue==180) ){caught = true; break;} 
                               } 
                             }
                             retracting = true; 
                         } // if(!retracting)                                  
                          if(dx>0)dx-=20;                 
                                 else{
                                      reachTarget = false;
                                      shoot = false;                                        
                                      retracting = false;
                                      dx=0;
                                      } 
             }
     }  // end of if(shoot)
  }
  void setX(int x, boolean right, float ang){
     if(caught){
          if(right)this.x=x+(int)(40*cos(ang));
                    else this.x=x-(int)(40*cos(ang));
     }else this.x=x;
  }
  void setY(int y){ if(y==1 && this.y<height-80)this.y += 20;
                         else if(y==-1 && this.y>height/4+80)this.y-= 20;
                                else if(this.y>height/4+80 && this.y<height-80 )this.y=y;
                  }
  void shoot(){shoot=true;}
  boolean getCaught(){return caught;}
  void setRaised(){raised= true;}
  void reset(){
    shoot=false;
    reachTarget=false;
    caught=false;
    retracting=false;
    raised = false;
    dx = 0;
  }
}