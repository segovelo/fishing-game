
class Time{
   boolean firstTime;
   int startTime;
   Time(){
      startTime = millis(); 
      firstTime = true;
   }
    void startTime(){startTime = millis();}
    boolean elapsed(int t1){return ((millis()-startTime)>=t1);}
    void setFirst(boolean a){firstTime = a;}
    boolean getFirst(){return firstTime;}
    int elapsed(){return (millis()-startTime);}
}