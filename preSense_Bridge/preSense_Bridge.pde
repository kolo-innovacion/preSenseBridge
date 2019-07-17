//preSense Bridge 1.0.0 compiled
boolean curr=false;
boolean prev=false;

void setup() {
  size(320, 200);
  frameRate(120);

  loadConfig();
  setupGUI();
  setupTimer();
  updateSerialStatus();
  setupUDP();
}

void draw() {
  background(255);
  showInfo();
  readFromSensor();
  reactReading();
  checkStatus();
  statusUpdate();
}

void reactReading() {
  if (val!=null) {

    if (val.equals(entryVal)) {
      curr=true;
      println("SERIAL ENTRY");
    } else if (val.equals(exitVal)) {

      curr=false;
      println("SERIAL EXIT");
    } else if ((val.length()>=verStrLength)&&(val.length()<=verStrLengthMax)) {
      //if the string comes from the serial port and is not the entry or exit value, it is assumed that it is the firmware version
      //the firmware version is used as a check fto confirm that serial comm with the preSense processor has been achieved
      serStatus=1;//connection is correct; status passes from 2 to 1
      version=val;
    }
  }
  //clear value!!!
  val=null;
}

void checkStatus() {
  if ((curr==true)&&(prev==false)) {
    doEntry();
  } else if ((curr==false)&&(prev==true)) {
    doExit();
  }
}

void statusUpdate() {
  prev=curr;
}

void doEntry() {
  if (timerExit.isRunning()) {
  } else {
    sendUDPacket(entryUDP);
  }
  currentImg=entry;
  timerEntry.start();
}

void doExit() {
  currentImg=exit;
  timerEntry.stop();
  timerExit.start();
}

void mousePressed() {
  doEntry();
}

void mouseReleased() {
  doExit();
}
