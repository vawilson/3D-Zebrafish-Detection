

// Valentine Wilson and Darby Thompson
import controlP5.*;
import java.io.File;

DropdownList d1, d2;
PFont font;
String k;
PShape rectangle;
int counter;
boolean colored;
boolean done;
ArrayList<Ruler> rulers;
int framenum;
boolean p;
int mtx, mty, mbx, mby;
Rectangle rectt, rects;
Boolean hi;
String drop1, drop2;
int kkkk;
boolean tankMode;
ScrollableList scroll, scroll2;
Ruler r;
int xpos2;
boolean text;
boolean lol;
int moviewidth, movieheight, moviewidtht, movieheightt;
String inputFolder;
import processing.video.*;
import peasy.*;
ControlP5 cp5;
Movie smovie;
Movie tmovie;
Movie nsmovie;
Movie ntmovie;
int moviewidths, movieheights;
int avx2;
String[] fileList;
boolean showFish=true;
boolean showHistory=true;
PFont font2;
boolean diminishHistory=false;
ArrayList<PVector> positions;
ArrayList<PVector> rgb;
ArrayList<Integer> time;
ArrayList<Integer> xpos22;
ArrayList<PVector> sfish;
ArrayList<PVector> tfish;
PeasyCam cam;
String tablename;
String inputname;
float LRS, HRS, LGS, HGS, LBS, HBS, LRT, HRT, LGT, HGT, LBT, HBT;
int startt;
int num;
int starts;
boolean nyce;
void setup() {
  size(1000, 720, P2D);  // image is 640 x 360
  background(159, 127, 216);
  text=true;
  num=0;

  rectangle = createShape(RECT, width-150, 130, 145, 100);
  rectangle.setFill(color(240, 0, 0));
  rectangle.stroke(0);
  loadmovie();
  font2=createFont("arial", 12);
  font = createFont("arial", 20);
  moviewidth=640;
  movieheight=360;
  moviewidtht=640;
  movieheightt=360;
  movieheights=360;
  moviewidths=640;
  kkkk=0;
  nyce=false;
  counter=0;
  colored=true;
  rulers= new ArrayList<Ruler>();
  time =new ArrayList<Integer>();
  sfish = new ArrayList<PVector>();
  tfish  = new ArrayList<PVector>();
  positions = new ArrayList<PVector>();
  xpos22 = new ArrayList<Integer>();
  rgb = new ArrayList<PVector>();
  lol=false;
  cam = new PeasyCam(this, 300);
  rgb.add(new PVector(0, 0, 0));
  p=false;
  r= new Ruler(300, 300, 200, 10);
  rulers.add(r);
  done=false;
  hi=false;
  //INPUT DATA TABLE NAME-
  // whenever you put in a new video change input name so that your previous data isn't overwritten, so change whatevers between
  //the "" to the new name. For example "new" could become "new2" or "TestVideo". Make sure to keep the ""'s though!
  inputname="new";
  //INPUT FISH COLOR RANGE- use rgb values, you can use rgb value analyzers on te internet to find the values or you can guess and test by clicking on the fish which will 
  //print out the rgb value at that pixel, the whole fish won be the exact same color though so you need a range. 
  //hint: (Usig red fish/ fish that are very different from background color will make find its location a lot more accurate)
  // LR/HR = lower bound red/higher bound red, LG/HG = lower bound green/higher bound green, LB/HB = lower bound blue/higher bound blue
  //also background lighting may vary between Side and Top shots causing color differences so there are bounds for each shot.
  fill(0);
  tankMode=false;
  textFont(font2);
  text("Red:", width-150, 40);
  text("Green:", width-150, 80 );
  text("Blue:", width-150, 120);
  //Side-shot colors
  LRS=145 ;
  HRS= 175;

  LGS=100 ;
  HGS=125 ;

  LBS=50 ;
  HBS=86 ;
  //Top-shot colors
  LRT=145 ;
  HRT=175 ;

  LGT=100 ;
  HGT=125 ;

  LBT=50 ;
  HBT=86 ;
  // SIZE OF TANK IN PIXELS- Upload your video and watch in the program. If you see the fishes path jumping to random areas above the water, that means there is color inerference
  // so you can make the computer look only at the water by setting where the water begins in "starts" below. Or just make it 0 if you don't need to select a specific area.

  startt=movieheight/5;
  starts=movieheight*7/10;
  createTable();

  fill(0);
  textFont(font2);
  text("Time:", 645, 283);

  text("Area between tick marks are half an inch or 48 pixels", width*2/3, height/2+100);
  
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  cp5.addSlider("Time Control")
    .setPosition(645, 236)
      .setSize(300, 20)
        .setRange(0, int(smovie.duration()-1))


          .setNumberOfTickMarks(int(smovie.duration()))
            .setSliderMode(Slider.FLEXIBLE)
              ;

  scroll = cp5.addScrollableList("Tank Side View")
    .setPosition(645, 130)
      .setSize(200, 100)
        .setBarHeight(20)
          .setItemHeight(20)
            .setType(ScrollableList.DROPDOWN)
              .setOpen(true)                 
                // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
                ;
  scroll2 = cp5.addScrollableList("Tank Top View")
    .setPosition(645, 25)
      .setSize(200, 100)
        .setBarHeight(20)
          .setItemHeight(20)
            .setType(ScrollableList.DROPDOWN)
              .setOpen(true) 

                // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
                ;
  cp5.get(ScrollableList.class, "Tank Side View").setType(ControlP5.DROPDOWN);
  cp5.get(ScrollableList.class, "Tank Top View").setType(ControlP5.DROPDOWN);



  ButtonBar b = cp5.addButtonBar("bar")
    .setPosition(0, 0)
      .setSize(width, 20)

        .addItems(split("a b c d e f i j k l", " "))

          ;


  b.changeItem("a", "text", "Toggle Fish");
  b.changeItem("b", "text", "Toggle History");
  b.changeItem("c", "text", "Recent History");
  b.changeItem("d", "text", "Pause");
  b.changeItem("e", "text", "Play");
  b.changeItem("f", "text", "Restart");


  b.changeItem("i", "text", "Reset Color");
  b.changeItem("j", "text", "Name Table");
  b.changeItem("k", "text", "Save Frame");
  b.changeItem("l", "text", "Set Tank Size");
  b.setColorBackground(0);
  b.setColorActive(0);
  b.onClick(new CallbackListener() {
    public void controlEvent(CallbackEvent ev) {
      ButtonBar bar = (ButtonBar)ev.getController();

      if (bar.hover()==0) {
        println("hi");
        showFish = !showFish;
      } else if (bar.hover()==1) {
        showHistory = !showHistory;
      } else if (bar.hover()==2) {
        diminishHistory = !diminishHistory;
      } else if (bar.hover()==3) {
        smovie.pause();
        tmovie.pause();
        hi=true;
      } else if (bar.hover()==4) {
        smovie.play();
        tmovie.play();
        hi=false;
      } else if (bar.hover()==5) {
        positions.clear();
        smovie.jump(0);
        tmovie.jump(0);
        rectt=null;
        rects=null;
      } else if (bar.hover()==6) {
        sfish.clear();
        tfish.clear();
        resetColor();
      } else if (bar.hover()==7) {
        if (!lol ) {
          cp5.addTextfield("Table Name")
            .setPosition(width-350, 340)
            .setSize(200, 40)

          .setFont(font)
            .setColor(color(255, 255, 255))
            ;
        } else {
          inputname= "new";
        }
      } else if (bar.hover()==8) {
        float k=random(1000000);
        save("saved frames/"+ k + ".jpg");
      } else if (bar.hover()==9) {
        //setTankSize();
        tankMode=true;
      }
    }
  }
  );



  displayFiles();
  drop1=scroll.getLabel();
  drop2=scroll2.getLabel();
}

void displayFiles() {
  inputFolder= "data";
  File dataFolder = new File(sketchPath, inputFolder);
  fileList = dataFolder.list( );
  for (int i=0; i<fileList.length; i++) {
    scroll.addItem(fileList[i], i);
    scroll2.addItem(fileList[i], i);
  }
}



void resetColor() {
  LRS=255;
  HRS=0;
  LGS=255;
  HGS=0;
  LBS=255;
  HBS=0;
  LRT=255;
  HRT=0;
  LGT=255;
  HGT=0;
  LBT=255;
  HBT=0;
}

void loadColor() {
  LRS=255;
  HRS=0;
  LGS=255;
  HGS=0;
  LBS=255;
  HBS=0;
  LRT=255;
  HRT=0;
  LGT=255;
  HGT=0;
  LBT=255;
  HBT=0;
  for (int i=0; i<sfish.size (); i++) {
    if (sfish.get(i).x<LRS) {
      LRS=sfish.get(i).x;
    }
    if (sfish.get(i).x>HRS) {
      HRS=sfish.get(i).x;
    }
    if (sfish.get(i).y<LGS) {
      LGS=sfish.get(i).y;
    }
    if (sfish.get(i).y>HGS) {
      HGS=sfish.get(i).y;
    }
    if (sfish.get(i).z<LBS) {
      LBS=sfish.get(i).z;
    }
    if (sfish.get(i).z>HBS) {
      HBS=sfish.get(i).z;
    }
  } 
  for (int i=0; i<tfish.size (); i++) {
    if (tfish.get(i).x<LRT) {
      LRT=tfish.get(i).x;
    }
    if (tfish.get(i).x>HRT) {
      HRT=tfish.get(i).x;
    }
    if (tfish.get(i).y<LGT) {
      LGT=tfish.get(i).y;
    }
    if (tfish.get(i).y>HGT) {
      HGT=tfish.get(i).y;
    }
    if (tfish.get(i).z<LBT) {
      LBT=tfish.get(i).z;
    }
    if (tfish.get(i).z>HBT) {
      HBT=tfish.get(i).z;
    }
  }
}
void mouseReleased() {
  if (mouseX>620 && mouseY<260 && mouseX<950 && mouseY>240) {
    if (((Slider) cp5.getController("Time Control")).getValue()!=int(tmovie.time())) {
      smovie.jump(((Slider) cp5.getController("Time Control")).getValue());
      tmovie.jump(((Slider) cp5.getController("Time Control")).getValue());

      positions.clear();
      xpos22.clear();
    }
  }
  if (tankMode && nyce) {
    tankMode=false;
    nyce=false;
  }
}
void mousePressed() {

  if (smovie!=null && tmovie!=null && tankMode && mouseX<=640) {
    if (mouseY>=height/2 ) {
      rectt= new Rectangle(mouseX, mouseY, 1, 1);
    } else {
      rects= new Rectangle(mouseX, mouseY, 1, 1);
    }
  } 
  if (!(scroll.getLabel().equals(drop1))) {
    println(scroll.getLabel());
    smovie = new Movie(this, scroll.getLabel() ); 
    smovie.volume(0);
    smovie.play();
    smovie.pause();
    LRS=255;
    HRS=0;
    LGS=255;
    HGS=0;
    LBS=255;
    HBS=0;
    positions.clear();
    xpos22.clear();
    sfish.clear();
    drop1=scroll.getLabel();
  }
  if (!(scroll2.getLabel().equals(drop2))) {
    println(scroll2.getLabel());

    tmovie = new Movie(this, scroll2.getLabel());
    tmovie.volume(0);
    tmovie.play();
    tmovie.pause();
    LRT=255;
    HRT=0;
    LGT=255;
    HGT=0;
    LBT=255;
    HBT=0;
    tfish.clear();
    positions.clear();
    xpos22.clear();
    drop2=scroll2.getLabel();
  }
}


void loadmovie() {

  smovie = new Movie(this, "RedFishSide5 copy.mp4");
  smovie.volume(0);
  smovie.play();
  smovie.pause();
  tmovie = new Movie(this, "RedFishTop5 copy.mp4");
  tmovie.volume(0);
  tmovie.play();
  tmovie.pause();
}


void movieEvent(Movie m) {
  m.read();
}

boolean isDone(Movie m) {
  return (m.time()>=m.duration()-.06);
}

void draw() {

  if (!done && smovie!=null && tmovie!=null) {


    framenum=positions.size()-1;
    counter=int(smovie.frameRate*smovie.time());
    //cam.beginHUD();
    if (rectt!=null) {
      println(mtx + ""+mty +"" +rectt.widthr +"" +rectt.heightr );
    }
    if ( rectt==null || rectt.widthr==0 || rectt.heightr==0) {
      movieheightt=360;
      moviewidtht=640;
    } else {
      movieheightt=rectt.heightr;
      moviewidtht=rectt.widthr;
      mtx=rectt.xpos;
      mty=rectt.ypos;
    }
    if ( rects==null || rects.widthr==0 || rects.heightr==0) {
      movieheight=360;
      moviewidth=640;
    } else {
      movieheights=rects.heightr;
      moviewidths=rects.widthr;
      mbx=rects.xpos;
      mby=rects.ypos;
    }
    if (p) {
      cp5.get(Textfield.class, "Table Name").remove();
      p=false;
      fill(159, 127, 216);
      noStroke();
      rect(width-352, 340, 210, 150);
    }
    fill(159, 127, 216);
    noStroke();
    rect(675, 260, 100, 100);
    fill(0);
    loadColor();
    text(int(smovie.time()), 678, 283);
    //movie.pause();
    if (isDone(smovie) || isDone(tmovie)) {
      smovie.stop();
      done=true;
      tmovie.stop();
    }
    if (mouseX<=moviewidth && mouseX>=0) {
      displayColor();
    }
    image(smovie, 0, height/2, moviewidth, movieheight);
    image(tmovie, 0, 0, moviewidth, movieheight);
    //cp5.getController("Time Control").setValue(cp5.getController("Time Control").getValue());
    cp5.draw();
    shape(rectangle);
    g.removeCache(smovie);
    g.removeCache(tmovie);
    //convertToGrayscale();
    findFish();
    if (showHistory) {
      drawPath();
    }

    if (!colored) {
      convertToGrayscale();
    }


    //cam.endHUD();

    //drawPath();

    //drawTimedPath();
    if (rectt!=null) {
      rectt.display();
    }
    if (rects!=null) {

      rects.display();
    }

    stroke(0);
    line(0, height/2, width*2/3-27, height/2);
    line(width*2/3-27, 20, width*2/3-27, height);
    //strokeWeight(2);
    stroke(255, 0, 0);
    for (int i =0; i<width; i=i+96) {
      
      if (i<width*2/3-27) {
        stroke(255, 0, 0);
        line(i, (height/2)+3, i, (height/2)-3);
      }
      stroke(255, 0, 0);
      line(width*2/3-30, i+20, width*2/3-27, i+20);
    }
    for (int i=48; i<width; i=i+96) {
      stroke(0, 0, 255);
      line(width*2/3-30, (i+20), width*2/3-27, (i+20));
      if (i<width*2/3-27) {
        line(i, (height/2)+3, i, (height/2)-3);
      }
    }

    strokeWeight(1);
    if (done) {
      fill(255, 255, 255);
      rect(20, height/2-70, 610, 90);
      fill(0);
      stroke(0);
      textSize(45);
      text("Ur done, gg kiddo", 30, height/2);
    }
  }
}
void mouseDragged() {

  if (tankMode && mouseX<=640) {
    nyce=true;
    if (mouseY>height/2 ) {

      rectt.update(mouseX, mouseY);
      print(rectt.widthr);
    } else {
      rects.update(mouseX, mouseY);
    }
  }
}

void keyPressed() {
  if (key==ENTER || key==RETURN && cp5.get(Textfield.class, "Table Name").getText()!=null) {
    inputname=cp5.get(Textfield.class, "Table Name").getText();
    println(inputname);
    p=true;
  }
}
void displayColor() {
  loadPixels();
  textFont(font2);
  fill(159, 127, 216);
  rect(width-120, 30, 70, 12);
  rect(width-113, 70, 60, 22);
  rect(width-120, 110, 50, 22);
  fill(0);
  text( int(red(pixels[mouseX+mouseY*width])), width-120, 40);
  text(  int(green(pixels[mouseX+mouseY*width])), width-110, 80);
  text( int(blue(pixels[mouseX+mouseY*width])), width-118, 120);
  rectangle.setFill(color(red(pixels[mouseX+mouseY*width]), green(pixels[mouseX+mouseY*width]), blue(pixels[mouseX+mouseY*width])));
}
void mouseClicked() {
  println("mousex:"+ mouseX + "mousey:"+mouseY);
  if (mouseX<=moviewidth && mouseX>=0 && mouseY>30 && mouseY<=height/2) {
    loadPixels();
    println(red(pixels[mouseX+mouseY*width])+" "+green(pixels[mouseX+mouseY*width])+" "+blue(pixels[mouseX+mouseY*width]) + "top");
    sfish.add(new PVector(red(pixels[mouseX+mouseY*width]), green(pixels[mouseX+mouseY*width]), blue(pixels[mouseX+mouseY*width])));
  }
  if (mouseX<=moviewidth && mouseX>=0 && mouseY<height && mouseY>=height/2) {
    loadPixels();
    println(red(pixels[mouseX+mouseY*width])+" "+green(pixels[mouseX+mouseY*width])+" "+blue(pixels[mouseX+mouseY*width])+ "bottom");
    tfish.add(new PVector(red(pixels[mouseX+mouseY*width]), green(pixels[mouseX+mouseY*width]), blue(pixels[mouseX+mouseY*width])));
  }
}

void convertToGrayscale() {
  loadPixels();

  for (int x=0; x<moviewidth; x++) {
    for (int y=0; y<height; y++) {
      float r = red(pixels[x+y*width]);
      float g = green(pixels[x+y*width]);
      float b = blue(pixels[x+y*width]);
      int avg = int((r+g+b)/3.0);

      pixels[x+y*width] = color(avg, avg, avg);
    } 
    updatePixels();
  }
}

void findFish() {
  loadPixels();
  //side
  int avx=0, avy=0, avz=0, avx2=0, count=0, countk=0;
  int xpos=0, ypos=0, zpos=0, xpos2=0;
  for (int x=mbx; x<mbx+moviewidths; x++) {
    for (int y=mby; y<mby+movieheight; y++) {
      if (LRS<red(pixels[x+y*width]) && red(pixels[x+y*width])<HRS  &&
        LGS<green(pixels[x+y*width]) && green(pixels[x+y*width])<HGS &&
        LBS<blue(pixels[x+y*width]) && blue(pixels[x+y*width])<HBS) {
        if (showFish) {
          pixels[x+y*width] = color(0, 0, 204);
        }
        avz+= y;
        avx2+= x;
        countk++;
      }
    }
  }
  println("x:"+mtx + "y:" +mty);
  for (int x=mtx; x<mtx+moviewidtht; x++) {
    for (int y=mty; y<movieheightt; y++) {

      if (LRT<red(pixels[x+y*width+movieheight*width]) && red(pixels[x+y*width+movieheight*width])<HRT  &&
        LGT<green(pixels[x+y*width+movieheight*width]) && green(pixels[x+y*width+movieheight*width])<HGT &&
        LBT<blue(pixels[x+y*width+movieheight*width]) && blue(pixels[x+y*width+movieheight*width])<HBT) {
        if (showFish) {
          pixels[x+y*width+movieheight*width] = color(255, 102, 204);
        }
        avx+= x;
        avy+= y;
        count++;
      }
    }
  }
  if (count>0 ) {
    xpos = int(avx/count);
    ypos = int(avy/count);
    fill(250, 255, 0);
    point(xpos, ypos);
  }
  if (countk>0) {
    zpos = int(avz/countk);
    xpos2=int(avx2/countk);
    fill(250, 255, 0);
    point(xpos2, zpos);
  }

  if (ypos>startt && zpos>10) {
    xpos22.add(xpos2);
    positions.add(new PVector(xpos, ypos, zpos));
    updateTable(xpos, ypos, zpos, tmovie.time());
    time.add(int(smovie.time()));
    updatePixels();
  }
}
void drawPath() {


  fill(0, 255, 0);
  stroke(0, 255, 0);

  if (!diminishHistory) {

    for (int i=0; i<positions.size ()-1; i++) {
      stroke(0, 255, 0);

      line(positions.get(i).x, positions.get(i).y+movieheight, positions.get(i+1).x, positions.get(i+1).y+movieheight);
      line(xpos22.get(i), positions.get(i).z, xpos22.get(i+1), positions.get(i+1).z);
    }
  } else {
    int alpha = 255;
    for (int i=positions.size ()-2; i>0; i--) {
      stroke(0, 255, 0, alpha);
      //top
      line(positions.get(i).x, positions.get(i).y, positions.get(i+1).x, positions.get(i+1).y);
      //side
      line(xpos22.get(i), positions.get(i).z+movieheight, xpos22.get(i+1), positions.get(i+1).z+movieheight);
      alpha -= 5;
    }
  }
}

