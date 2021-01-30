

class Bubble{
  
     int x;
     int y;
     int size;
     int speedY;
     boolean justCreated = true;
     Bubble(int x, int y){
          this.x = x; 
          this.y = y;
          this.speedY = -(height/300);
     }
  
  void move(){
      y = y + speedY;
   }
   
  void render(){
     stroke(0);
      fill(200,190,255);  //(170, 170, 255); 
      if(justCreated)size=5*height/y;
          else size=5*(5-(4*y/height)); 
      ellipse(x,y,size,size);
      justCreated = false;    
  }
 
   boolean checkBubble(){
      if(y > ( myBackground.getSeaY(x)+ size/2)) return true; 
             else return false;  
 }
    
    void update(){
        move();
        render();
    }
   
 int getX(){return x;}
 int getY(){return y;}
 int getSize(){return size;}
}