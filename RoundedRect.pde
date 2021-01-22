
 class RoundedRect{
     int xc, yc, rectWidth, rectHeight;
     int xrad, yrad;
     color rectColor;
    RoundedRect(int xc, int yc, int rectWidth, int rectHeight){  
       this.xc = xc;     
       this.yc = yc;
       this.rectWidth = rectWidth;
       this.rectHeight = rectHeight;
       xrad = rectWidth/8;
       yrad = rectWidth/8;
       rectColor = color(180,255,180);
    }
    
     RoundedRect(int xc, int yc, int rectWidth, int rectHeight, int xrad, int yrad){  
        this.xc = xc;     
        this.yc = yc;
        this.rectWidth = rectWidth;
        this.rectHeight = rectHeight;
        this.xrad = xrad;
        this.yrad = yrad;
        this.rectColor = color(180,255,180);
     }
    RoundedRect(int xc, int yc, int rectWidth, int rectHeight, color bckGrnd){  
       this.xc = xc;     
       this.yc = yc;
       this.rectWidth = rectWidth;
       this.rectHeight = rectHeight;
       this.xrad = rectWidth/8;
       this.yrad = rectWidth/8;
       this.rectColor = bckGrnd; 
   }
   
    RoundedRect(int xc, int yc, int rectWidth, int rectHeight, int xrad, int yrad, color bckGrnd){  
        this.xc = xc;     
        this.yc = yc;
        this.rectWidth = rectWidth;
        this.rectHeight = rectHeight;
        this.xrad = xrad;
        this.yrad = yrad;
        this.rectColor = bckGrnd;
     }
     
   void render(){
     rectMode(CENTER);
     fill(rectColor);
     noStroke();
  
     rect(xc,yc,rectWidth,rectHeight); // Big Central Rectangle
     // Top Rectangle
     rect(xc,yc-(rectHeight+yrad)/2,(rectWidth-2*xrad),yrad);
     // Bottom Rectangle
     rect(xc,yc+(rectHeight+yrad)/2,(rectWidth-2*xrad),yrad);  

    stroke(0); 
    //  Left Top arc
    arc(xc+xrad-rectWidth/2,yc-rectHeight/2,2*xrad,2*yrad,PI,(PI+HALF_PI));
    //  Right arc
    arc(xc-xrad+rectWidth/2,yc-rectHeight/2,2*xrad,2*yrad,-HALF_PI,0);
    // Left Bottom arc
    arc(xc+xrad-rectWidth/2,yc+rectHeight/2,2*xrad,2*yrad,HALF_PI,PI);
    // Left Bottom arc
    arc(xc-xrad+rectWidth/2,yc+rectHeight/2,2*xrad,2*yrad,0,HALF_PI);
 
    line(xc-rectWidth/2,yc-rectHeight/2,xc-rectWidth/2,yc+rectHeight/2); // Left Vertical line
    line(xc+rectWidth/2,yc-rectHeight/2,xc+rectWidth/2,yc+rectHeight/2); // Right Vertical line
    line(xc+xrad-rectWidth/2,yc-yrad-rectHeight/2,xc-xrad+rectWidth/2,yc-yrad-rectHeight/2);  // Top Horizontal line
    line(xc+xrad-rectWidth/2,yc+yrad+rectHeight/2,xc-xrad+rectWidth/2,yc+yrad+rectHeight/2);  // Bottom Horizontal line  
    noStroke();
    noFill();
    rectMode(CORNER);
   }
   
   void update(){
    // fill(180,255,180);
    render();

   }
  
}