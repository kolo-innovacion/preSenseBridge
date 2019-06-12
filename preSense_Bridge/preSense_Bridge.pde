
//SERIAL VARIABLES
import processing.serial.*;
Serial myPort;
String comPort;
String val;
String version="NOT DETECTED";
int verStrLength=6;
String entryVal="preSenseEntry\n";
String exitVal="preSenseExit\n";
boolean serconnect=false;

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


void setup() {
  size(250, 150);
  loadConfig();
  frameRate(30);
  try {
    myPort = new Serial(this, comPort, 9600);
    //version=myPort.readStringUntil('\n');  
    //println(version);
  }
  catch(Exception e) {
    println(e);
  }

  udp = new UDP( this, 6000 );
}

void draw() {
  background(255, 255, 255);
  showInfo();
  if ( myPort.available() > 0) 
  {
    val = myPort.readStringUntil('\n');         // read it and store it in val
  }
  if (val!=null) {

    if (val.equals(entryVal)) {
      //sendUDPacket(entryUDP);
      curr=true;
      background(0, 255, 0);
      showInfo();
    } else if (val.equals(exitVal)) {

      curr=false;
      //sendUDPacket(exitUDP);
      background(255, 0, 0);
      showInfo();
    } else if (val.length()==verStrLength) {
      //if the string comes from the serial port and is not the entry or exit value, it is assumed that it is the firmware version
      //the firmware version is used as a check fto confirm that serial comm with the preSense processor has been achieved
      //println(val.length());
      version=val;
      serconnect=true;
    }
  }
  checkStatus();
  statusUpdate();
}

void checkStatus() {
  if ((curr==true)&&(prev==false)) {
    sendUDPacket(entryUDP);
  } else if ((curr==false)&&(prev==true)) {
    sendUDPacket(exitUDP);
  }
}
void statusUpdate() {
  prev=curr;
}
void sendUDPacket(String input) {
  udp.send( input, targetIP, targetPort );
}

void showInfo() {
  int aux=25;
  fill(0);

  text("Serial port: "+comPort, 10, aux);
  aux+=20;
  text("Firmware version: "+version, 10, aux);
  aux+=20;
  text("Target IP: "+targetIP+" on port "+targetPort, 10, aux);
  aux+=20;  
  text("UDP msg on entry:  "+entryUDP, 10, aux);
  aux+=20;  
  text("UDP msg on exit:  "+exitUDP, 10, aux);
  aux+=20;
  text("END OF LINE after msg:  "+eol, 10, aux);
  aux+=20;
}
