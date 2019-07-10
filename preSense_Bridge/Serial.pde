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

//functions
int attemptSerial() {
  try {
    myPort = new Serial(this, comPort, 9600);
  }
  catch(Exception e) {
    return 0;
  }
  return 2;
}

void updateSerialStatus() {
  serStatus=attemptSerial();
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
