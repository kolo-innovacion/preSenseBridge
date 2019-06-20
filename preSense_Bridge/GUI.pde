int connTrue=color(0, 255, 0);
int connFalse=color(255, 0, 0);
int connAlert=color(255, 127, 0);

PImage currentImg;

PImage absent;
PImage present;
PImage entry;
PImage exit;
PImage logo;

int entryStart;
int exitStart;
int timeDur=1000;//ms
boolean entryTout=false;
boolean exitTout=false;

PFont myFont;

void guiSetup() {
  absent = loadImage("absent.png");
  present = loadImage("present.png");
  entry = loadImage("entry.png");
  exit = loadImage("exit.png");
  logo=loadImage("koloLogo.png");
  currentImg = absent;
  myFont=createFont("Tahoma", 14);
  //myFont=createFont("Gill Sans MT", 24);
  textFont(myFont);
}
