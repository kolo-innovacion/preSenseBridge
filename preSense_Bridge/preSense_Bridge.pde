
//SERIAL VARIABLES
import processing.serial.*;
Serial myPort;
String val;
String entryVal="preSenseEntry\n";
String exitVal="preSenseExit\n";

//UDP VARIABLES
import hypermedia.net.*;
UDP udp;

//String ip       = "192.168.0.17";  // the remote IP address
String ip       = "localhost";  // the remote IP address
int port        = 6100;

String entryUDP="SV:1200:1\n";
String exitUDP="SV:1200:0\n";


void setup()
{
  frameRate(60);
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);

  udp = new UDP( this, 6000 );
}

void draw()
{
  background(255, 255, 255);
  if ( myPort.available() > 0) 
  {
    val = myPort.readStringUntil('\n');         // read it and store it in val
  }
  if (val!=null) {

    if (val.equals(entryVal)) {
      sendUDPacket(entryUDP);

      background(0, 255, 0);
    } else if (val.equals(exitVal)) {


      sendUDPacket(exitUDP);
      background(255, 0, 0);
    }
  }
}

void sendUDPacket(String input) {
  udp.send( input, ip, port );
}
