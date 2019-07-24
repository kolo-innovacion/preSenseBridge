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

void setupGUI() {
  absent = loadImage("absent.png");
  present = loadImage("present.png");
  entry = loadImage("entry.png");
  exit = loadImage("exit.png");
  logo=loadImage("koloLogo.png");
  currentImg = absent;
  myFont=createFont("Tahoma", 14);
  textFont(myFont);
}

void showInfo() {
  int aux=20;

  displayConnection();

  fill(0);
  text("Serial port: "+comPort, 10, aux);
  aux+=22;
  text("Firmware version: "+version, 10, aux);
  aux+=26;
  text("Target IP: "+targetIP+" on port "+targetPort, 10, aux);
  aux+=24;  
  text("UDP msg on entry:  "+entryUDP, 10, aux);
  aux+=24;  
  //text("UDP msg on exit:  "+exitUDP, 10, aux);
  //aux+=24;
  text("LINE FEED after msg:  "+linefeed, 10, aux);


  image(logo, 254, 14);

  currentImg.resize(54, 0);
  image(currentImg, ((width/2)-26), 150);
  tint(0, 255, 0);
}

void displayConnection() {
  if (serStatus==1) {
    fill(connTrue);
  } else if (serStatus==2) {
    fill(connAlert);
  } else {
    fill(connFalse);
  }
  noStroke();
  rect(0, 0, width, 50);
}
