class Ruler {
  int xpos, ypos, rwidth, rheight;

  Ruler(int x, int y, int wid, int heigh) {
    xpos=x;
    ypos=y;
    rwidth=wid;
    rheight=heigh;
  }

  void display() {
    fill(246,255,5);
    if (rwidth>rheight) {
      rect(xpos,ypos,rwidth,rheight);
      for(int i=0;i<rwidth;i++){
        if(i%10==0){
          text(i,rwidth+i,rheight);
        }
        
      }
    } else {
    }
  }
}

