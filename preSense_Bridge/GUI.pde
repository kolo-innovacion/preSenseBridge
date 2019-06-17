int connTrue=color(0, 255, 0);
int connFalse=color(255, 0, 0);

PImage currentImg;

PImage absent;
PImage present;
PImage entry;
PImage exit;

int entryStart;
int exitStart;
int timeDur=1000;//ms
boolean entryTout=false;
boolean exitTout=false;

void guiSetup() {
  absent = loadImage("absent.png");
  present = loadImage("present.png");
  entry = loadImage("entry.png");
  exit = loadImage("exit.png");
  currentImg = absent;
}
