
class FishXY{
  int[]  x;
  float[] y;
  FishXY(){
    x =new int[10];
    y = new float[10]; 
    x[0] = width+100;
    y[0] = height-125;
    x[1] = x[0]+100;
    y[1] = y[0]-25;
    x[2] = x[0]+100;
    y[2] = y[0]+25;
    x[3] = x[1]+100;
    y[3] = y[1]-25;
    x[4] = x[1]+100;
    y[4] = y[1]+25;
    x[5] = x[1]+100;
    y[5] = y[2]+25;
    x[6] = x[3]+100;
    y[6] = y[3]-25;
    x[7] = x[5]+100;
    y[7] = y[3]+25;
    x[8] = x[3]+100;
    y[8] = y[4]+25;
    x[9] = x[3]+100;
    y[9] = y[5]+25;   
  }
  int getX(int i){ return x[i];}
  float getY(int i){ return y[i];}
}
  