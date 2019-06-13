int connTrue=color(0, 255, 0);
int connFalse=color(255, 0, 0);

PImage current;

PImage absent;
PImage present;
PImage entry;
PImage exit;

void guiSetup() {
  absent = loadImage("absent.png");
  present = loadImage("present.png");
  entry = loadImage("entry.png");
  exit = loadImage("exit.png");
  current = absent;
}
