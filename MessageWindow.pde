

class MessageWindow{
     int xc, yc, rectWidth, rectHeight;
     int xrad, yrad;
     color bckGrndColor;
     color buttonColor;
     String[] message = {"Game Over", "Play", "Quit"};
     RoundedRect myRect;
     RoundedRect[] myButtons = new RoundedRect[2];
  
     MessageWindow(int xc, int yc, int rectWidth, int rectHeight){
           this.xc = xc;     
           this.yc = yc;
           this.rectWidth = rectWidth;
           this.rectHeight = rectHeight;
           this.xrad = rectWidth/8;
           this.yrad = rectWidth/8;
           this.bckGrndColor = color(180,255,180);  
           buttonColor = color(154,255,240);
           myRect = new RoundedRect(xc,yc,rectWidth,rectHeight);
           myButtons[0] = new RoundedRect(xc-rectWidth/4,yc+2*rectHeight/5,80,30,buttonColor);
           myButtons[1] = new RoundedRect(xc+rectWidth/4,yc+2*rectHeight/5,80,30,buttonColor);
          //message[0] = {"Game Over", "Play", "Quit"};
          // message[1] = "Play";
           //message[2] = "Quit";
     }
  
       MessageWindow(int xc, int yc, int rectWidth, int rectHeight,color bckGrndColor, color buttonColor){
           this.xc = xc;     
           this.yc = yc;
           this.rectWidth = rectWidth;
           this.rectHeight = rectHeight;
           this.xrad = rectWidth/8;
           this.yrad = rectWidth/8;
           this.bckGrndColor = bckGrndColor;  
           this.buttonColor = buttonColor;
           myRect = new RoundedRect(xc,yc,rectWidth,rectHeight,bckGrndColor);
           myButtons[0] = new RoundedRect(xc-rectWidth/4,yc+2*rectHeight/5,80,30,buttonColor);
           myButtons[1] = new RoundedRect(xc+rectWidth/4,yc+2*rectHeight/5,80,30,buttonColor);
     }
     
          MessageWindow(int xc, int yc, int rectWidth, int rectHeight, String[] message ){
           this.xc = xc;     
           this.yc = yc;
           this.rectWidth = rectWidth;
           this.rectHeight = rectHeight;
           this.xrad = rectWidth/8;
           this.yrad = rectWidth/8;
           this.bckGrndColor = color(180,255,180);  
           buttonColor = color(154,255,240);
           myRect = new RoundedRect(xc,yc,rectWidth,rectHeight);
           myButtons[0] = new RoundedRect(xc-rectWidth/4,yc+rectHeight/4,80,30,buttonColor);
           myButtons[1] = new RoundedRect(xc+rectWidth/4,yc+rectHeight/4,80,30,buttonColor);
           this.message = message;
     }
     
     void render(){
       myRect.render();
       myButtons[0].render();
       myButtons[1].render(); 
       
      textSize(52);
      fill(0,0,255);
      text(message[0],xc-2*rectWidth/5,yc-rectHeight/4);  
      textSize(24);  
      text(message[1],xc-20-rectWidth/4,yc+9*rectHeight/20);
      text(message[2],xc-20+rectWidth/4,yc+9*rectHeight/20);  
     }

}