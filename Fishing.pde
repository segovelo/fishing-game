
// Sebastian Vergara Student ID 16064914
//  Press and HOLD control key to lower the fishing net


ArrayList<SeaCreature> myShoal; // Array list of sea creature objects
Boat myBoat;     // The fishing vessel object
GameLevel level;  // Enum to store the three different game levels , splash screen and game over screen 
Background myBackground; // Object rendering the background of game
Time timer, focus_timer;  // Object timer of class Time to give timing and sequence
boolean _focus; // Game window gain focus at start-up  boolean 

 void setup() {
     fullScreen();
     background(200,200,255);
     myShoal = new ArrayList<SeaCreature>();
     level = GameLevel.SPLASH; //SPLASH; // Set object level to SPLASH screen
     myBackground = new Background(); // Create background object
     timer = new Time(); // Create timer object
     focus_timer = new Time();
     _focus = false;
     Initialize();  // call method Initialize
 }

 void draw() {  
   switch(level) {
     case SPLASH:  // Splash screen
         check_focus();
         if(!timer.elapsed(12000)){ 
              fill(80,100,255);
              ellipse(width/2,height/4-myBoat.getSize()/5,1.8*myBoat.getSize(),1.8*myBoat.getSize());
              textSize(32);
              fill(255,0,0);
              text("Use RIGHT and LEFT arrow keys to move the boat.\n "+
                   "To lower the fishing net press and hold the CTRL key.\n "+
                   "Realease CTRL key to lift the fishing net.",width/8,3*height/4);
              myBoat.render(1);  // call method render() for myBoat object
              if(timer.elapsed()%10==0 && !timer.elapsed(8000)){ // Generate a status bar
                   fill(255,0,0); // 
                   rect(width/4,(height-10)/2,(timer.elapsed()*width/16000),20); // draw a enlarging rectangle
              }        
          }else{ 
                 level = GameLevel.LEVEL1; // 12 seconds after the splash screen first show set level to LEVEL1
                }
        break;
     
     case LEVEL1:  // LEVEL1
           myBackground.update(level);
           if(timer.getFirst()){
              timer.startTime();  //startTime = millis();
              timer.setFirst(false);//firstTime = false;
              fishInit(level);   // CALL fishInit() method - Initialize the shoal
           }else if(timer.elapsed(3000)) update(level);// call update() method, update all objects  
                      else  myBoat.update(0,myBackground.getSeaColor()); 
          break;
      case LEVEL2:  // case LEVEL2
           myBackground.update(level);
           if(timer.getFirst()){
              timer.startTime();  //startTime = millis();
              timer.setFirst(false);//firstTime = false;
              fishInit(level);
           }else if(timer.elapsed(3000)) update(level); // call update() method, update all objects
                    else  myBoat.update(0,myBackground.getSeaColor());                      
           break;
        case LEVEL3: // case LEVEL3
            myBackground.update(level);
           if(timer.getFirst()){
              timer.startTime();  //startTime = millis();
              timer.setFirst(false);//firstTime = false;
              fishInit(level);
           }else if(timer.elapsed(10000)) update(level);  // call update() method, update all objects
                        else  myBoat.update(0,myBackground.getSeaColor()); // UPDATE myBoat object
            break;
         case GAMEOVER: // case GAMEOVER
              myBackground.update(level); // call method update() for myBackground object
              gameOver();  // call method gameOver() shows dialog box.
           break;
       } // End of switch
 } // End of void draw()

   void Initialize(){
        timer.startTime();
        myBackground.setLives(5);//livesCounter = 5;
        myBackground.setScore();//score = 0;
        myBoat = new Boat(width/2, height/4,  width/10);       
    }  // End of Initialize()
        
    void fishInit(GameLevel level){
        float y;
        int x;
        FishXY fishPos=new FishXY();
        myBoat.resetLine();
         for(int i = 0; i<10; i++){
             x = int(random(15, width - 15));
             y = random(10+(height/2), height-10);              
             switch(level){
               case SPLASH:
                  break;
               case LEVEL1: 
                 myShoal.add(new Fish(fishPos.getX(i), fishPos.getY(i),30));  
                 break;
               case LEVEL2:
                 myShoal.add(new Fish2(x, y, 22));  
                 break;
              case LEVEL3:
                 i=9;
                 myShoal.add(new Shark(width+300, height-120, 200));  
                 break; 
             case GAMEOVER:
                 break;
          }  // End of switch
        } // End of for   
    } //  End of fishInit()
     
 void  keyPressed() {
   if (level != GameLevel.GAMEOVER && level != GameLevel.SPLASH) {
     if (key == CODED) {   
      if (keyCode == RIGHT && myBoat.getX()< (width-(20+myBoat.getSize()/2))) {
          myBoat.update(1,myBackground.getSeaColor());
         // myBoat.setMovingRight(true);  
      }
      if (keyCode == LEFT && myBoat.getX() > 20+myBoat.getSize()/2 ) {
          myBoat.update(-1,myBackground.getSeaColor());
          //myBoat.setMovingRight(false);   
      }
      if (keyCode == UP && level == GameLevel.LEVEL3 && !myBoat.harpooned()){myBoat.setHarpoonY(-1);}
      if (keyCode == DOWN && level == GameLevel.LEVEL3 && !myBoat.harpooned()){myBoat.setHarpoonY(1);}
 
      if (keyCode == CONTROL && !myShoal.get(0).form() && myShoal.size()>0) {
        if(level != GameLevel.LEVEL3){
            if (myBoat.getLineLength()<3*height/4) myBoat.releaseNet();
            myBoat.setLineUp(false);
        } else{
               myBoat.shoot(); 
             }
      }
    }
  }
} 

void keyReleased() {
    if (key==CODED) {
      if(keyCode==CONTROL && myBoat.getLineLength()>height/80)  myBoat.setLineUp(true);      
    } 
}

  void gameOver(){
        if(myBoat.getY()<height-50){
            myBoat.setY(myBoat.getY()+1);
            myBoat.sinking(myBackground.getSeaColor());
        } else { 
                MessageWindow myMessage= new MessageWindow(width/2,height/2,320,200);
                myMessage.render();   
                myBoat.sinking(myBackground.getSeaColor());
              }
       for (int i = 0; i< myShoal.size(); i++) myShoal.get(i).update();         
    }  // End of gameOver()
 
   void mouseClicked(){
        if((mouseX>=width-30 && mouseY<=30)) exit();
        if(mouseX>= (width/2)-120 && mouseX<= (width/2)-40 && mouseY>=(height/2)+60 && mouseY<=(height/2)+100 && level==GameLevel.GAMEOVER) {  
                    while( myShoal.size()>0) myShoal.remove(0);         
                    level = GameLevel.LEVEL1;               
                    Initialize();
                    fishInit(level);                     
          }       
        if(mouseX>=(width/2)+40 && mouseX<=(width/2)+120 && mouseY>=(height/2)+60 && mouseY<=(height/2)+100 && level==GameLevel.GAMEOVER) exit();
   }       
   
   void update(GameLevel eachLevel){ 
          myBackground.update(level);
           for(int i = 0; i<myShoal.size(); i++){     
              if(myShoal.get(i).insideNet(myBoat)){              
                   if(myBoat.getMovingRight()){
                       myShoal.get(i).setXY(myBoat.getLineX()-((height/10) -25-2*(i%15)) ,myBoat.getLineY()-(height/29+3*(i%10))); 
                    } else  myShoal.get(i).setXY(myBoat.getLineX()+((height/10) -25-2*(i%15)) ,myBoat.getLineY()-(height/29+3*(i%10)));
               }
               if( myShoal.get(i).getCaught() && myBoat.getLineLength()<60) {
                     myShoal.remove(i);
                     myBackground.score();//score++ 
               }    
            } // End of for  
                 //} // End of if(myShoal != null && myBoat != null)
                 
            for(int i = 0; i< myShoal.size(); i++) {
                 myShoal.get(i).update();  
                 myShoal.get(i).makeBubble();
            } // End of for
            for(int i = 0 ; i< myShoal.size() ; i++){
                for(int j = 0; j < myShoal.get(i).numBubbles();  j++){
                    if(myBoat.isHit(myShoal.get(i).bubbleX(j),myShoal.get(i).bubbleY(j))){
                        myBoat.shake();
                        myBackground.lives();                                    
                        myShoal.get(i).bubbleBurst(j);   
                    }  // End of if(myBoat.isHit())      
               } // End of  for(int j = 0
            } // End of for(int i = 0  
            myBoat.update(0,myBackground.getSeaColor()); 
            if(level == GameLevel.LEVEL3 && myBoat.harpooned()){
                 myBoat.setHarpoonX(myShoal.get(0).getX(),myShoal.get(0).right(),
                                    myShoal.get(0).angle());
                 myBoat.setHarpoonY(myShoal.get(0).getY()); 
                 myShoal.get(0).harpooned();
                 if( myShoal.get(0).raised()){
                    myBoat.raised();
                    if(myShoal.get(0).setSpeed(myBoat.getX(),myBoat.getY(),myBoat.getMovingRight())){
                         myShoal.remove(0);
                         myBackground.score();
                         myBoat.reset();
                     }     
                 } 
                   
            } // End of if(level == GameLevel.LEVEL3 && myBoat.harpooned()
            if(myBackground.getLives()) level = GameLevel.GAMEOVER;    
            if(myShoal.size() < 1 && myBoat != null){
               int index = eachLevel.ordinal()+1;
               GameLevel[] myLevel = level.values();
               index %= myLevel.length;
               if(myLevel[index]!=GameLevel.SPLASH &&
                  myLevel[index]!=GameLevel.GAMEOVER)level = myLevel[index]; 
                      else level = GameLevel.LEVEL1; 
               timer.setFirst(true);
                  } // End of  if(myShoal.size() < 1 &&)
          // } 
   }  // End of update()
   
   
   void check_focus() {
      if ( !_focus && !focus_timer.elapsed(5000)) {  
        if ( !focused ) ((java.awt.Canvas) surface.getNative()).requestFocus();
          else  _focus= true;
      }
   }
