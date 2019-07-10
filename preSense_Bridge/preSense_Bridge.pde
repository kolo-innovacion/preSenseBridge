//OTHER VARS
boolean curr=false;
boolean prev=false;

//gui vars

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
      //sendUDPacket(entryUDP);
      curr=true;
      //background(255, 191, 0);
      //current=entry;
      //showInfo();
      println("SERIAL ENTRY");
    } else if (val.equals(exitVal)) {

      curr=false;
      //sendUDPacket(exitUDP);
      //background(255, 255, 255);
      //currentImg=absent;
      //showInfo();
      println("SERIAL EXIT");
    } else if ((val.length()>=verStrLength)&&(val.length()<=verStrLengthMax)) {
      //if the string comes from the serial port and is not the entry or exit value, it is assumed that it is the firmware version
      //the firmware version is used as a check fto confirm that serial comm with the preSense processor has been achieved
      //println(val.length());
      serStatus=1;//connection is correct; status passes from 2 to 1
      version=val;
      //serconnect=true;
    }
  }
  //clear value!!!
  val=null;
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

void doEntry() {
  if (timerExit.isRunning()) {
  } else {
    sendUDPacket(entryUDP);
  }
  currentImg=entry;
  timerEntry.start();
  //startTimer();
}

void doExit() {
  //sendUDPacket(exitUDP);
  currentImg=exit;
  timerEntry.stop();
  //timerExit.reset();
  timerExit.start();
}

void mousePressed() {
  doEntry();
}

void mouseReleased() {
  doExit();
}
