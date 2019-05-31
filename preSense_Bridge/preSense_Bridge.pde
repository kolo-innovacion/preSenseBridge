
//SERIAL VARIABLES
import processing.serial.*;
Serial myPort;
String comPort;
String val;
String entryVal="preSenseEntry\n";
String exitVal="preSenseExit\n";

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
  //String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, comPort, 9600);

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
  text("Target IP: "+targetIP+" on port "+targetPort, 10, aux);
  aux+=20;  
  text("UDP msg on entry:  "+entryUDP, 10, aux);
  aux+=20;  
  text("UDP msg on exit:  "+exitUDP, 10, aux);
  aux+=20;
  text("END OF LINE after msg:  "+eol, 10, aux);
  aux+=20;
}
