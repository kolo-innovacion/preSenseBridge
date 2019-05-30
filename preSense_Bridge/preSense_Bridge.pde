import processing.serial.*;
Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
String entryVal="preSenseEntry\n";
String exitVal="preSenseExit\n";

void setup()
{
  frameRate(60);
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  background(255, 255, 255);
  if ( myPort.available() > 0) 
  {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
  }
  if (val!=null) {
    //println("SOMETHING");

    if (val.equals(entryVal)) {
      println("ENTRY DETECTED");

      background(0, 255, 0);
    } else if (val.equals(exitVal)) {

      println("XXXXXXXXXXXXXX");

      background(255, 0, 0);
    }
  } //print it out in the console
}
