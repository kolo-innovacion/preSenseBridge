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

void updateSerialStatus() {
  serStatus=attemptSerial();
}
