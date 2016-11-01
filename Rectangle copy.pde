class Rectangle {
  int ypos;
  int xpos;
  int heightr;
  int widthr;
  int r;
  int g;
  int b;
  Rectangle(int x, int y, int w, int h) {
    ypos=y;
    xpos=x;
    widthr =w;
    heightr =h;
    r=0;
    g=0;
    b=0;
  }

  void display() {
    fill(r, g, b, 0);
    rect(xpos, ypos, widthr, heightr);
  }

  void update(int x, int y) {
    //if rectangle is drawn in the other direction it flips over
    if (x>=xpos) {
      widthr=int(dist(x, ypos, xpos, ypos));
    } else {

      widthr=-int(dist(xpos, ypos, x, ypos));
    }
    if (y>=ypos) {
      heightr=int(dist(xpos, y, xpos, ypos));
    } else {

      heightr=-int(dist(xpos, y, xpos, ypos));
    }
  }
}

