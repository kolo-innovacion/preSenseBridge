


//SERIAL VARIABLES
import processing.serial.*;
Serial myPort;
String comPort;
String val;
String version="NOT DETECTED";
int verStrLength=6;
int verStrLengthMax=10;
String entryVal="preSenseEntry\n";
String exitVal="preSenseExit\n";
boolean serConnect=false;
int serStatus=0;//0 is not connected, 1 is connected, 2 is pending

//UDP VARIABLES
import hypermedia.net.*;
UDP udp;

//String ip       = "192.168.0.17";  // the remote IP address
//String targetIP = "localhost";  // the remote IP address
//int targetPort = 5000;

//String entryUDP="SV:1200:1\n";
//String exitUDP="SV:1200:0\n";

String targetIP; // the remote IP address
int targetPort;

String entryUDP;
String exitUDP;

//OTHER VARS
boolean curr=false;
boolean prev=false;

//gui vars



void setup() {
  size(320, 200);
  loadConfig();
  guiSetup();
  timerSetup();
  frameRate(30);

  serStatus=attemptSerial();

  udp = new UDP( this, 6000 );
}

void draw() {
  background(255);
  showInfo();


  readFromSensor();
  reactReading();
  resetVal();

  //----------


  checkStatus();
  statusUpdate();
}
int aux=0;
void reactReading() {
  if (val!=null) {

    if (val.equals(entryVal)) {

      //case positive
      println(entryVal+"  "+aux);
      sendUDPacket(entryUDP);
      delay(5000);
      aux++;
      //timerEntry.stop();
      //timerEntry.reset();
      //timerEntry.start();
      //sendUDPacket(entryUDP);
      curr=true;
      //background(255, 191, 0);
      //current=entry;
      //showInfo();
    } else if (val.equals(exitVal)) {

      curr=false;
      //sendUDPacket(exitUDP);
      //background(255, 255, 255);
      //currentImg=absent;
      //showInfo();
    } else if ((val.length()>=verStrLength)&&(val.length()<=verStrLengthMax)) {
      //if the string comes from the serial port and is not the entry or exit value, it is assumed that it is the firmware version
      //the firmware version is used as a check fto confirm that serial comm with the preSense processor has been achieved
      //println(val.length());
      serStatus=1;//connection is correct; status passes from 2 to 1
      version=val;
      //serconnect=true;
    }
  }
}
void resetVal() {
  val=null;
}
void readFromSensor() {
  if (serStatus>0) {

    if ( myPort.available() > 0) 
    {
      val = myPort.readStringUntil('\n');         // read it and store it in val
    }
  } else {
    serStatus=attemptSerial();
  }
}

void checkStatus() {
  if ((curr==true)&&(prev==false)) {
    //sendUDPacket(entryUDP);
    //currentImg=entry;


    doEntry();
  } else if ((curr==false)&&(prev==true)) {
    //sendUDPacket(exitUDP);
    doExit();
    //current=exit;
  }
}
void statusUpdate() {
  prev=curr;
}
void sendUDPacket(String input) {
  udp.send( input, targetIP, targetPort );
}

void doEntry() {
  if (timerExit.isRunning()) {
  } else {
    sendUDPacket(entryUDP);
  }
  currentImg=entry;
  //timerEntry.start();
  //startTimer();
}
void doExit() {
  //sendUDPacket(exitUDP);
  currentImg=exit;
  //timerEntry.stop();
  //timerExit.reset();
  timerExit.start();
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
  text("UDP msg on exit:  "+exitUDP, 10, aux);
  aux+=24;
  text("LINE FEED after msg:  "+linefeed, 10, aux);
  //aux+=20;


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

boolean attemptSerial0() {
  try {
    myPort = new Serial(this, comPort, 9600);

    //version=myPort.readStringUntil('\n');  
    //println(version);
  }
  catch(Exception e) {
    //println(e);
    return false;
  }
  return true;
}

int attemptSerial() {
  try {
    myPort = new Serial(this, comPort, 9600);

    //version=myPort.readStringUntil('\n');  
    //println(version);
  }
  catch(Exception e) {
    //println(e);
    return 0;
  }
  return 2;
}

void mousePressed() {
  doEntry();
}

void mouseReleased() {
  doExit();
}
