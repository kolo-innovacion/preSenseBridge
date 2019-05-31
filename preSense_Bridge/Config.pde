XML config;
boolean eol;
void loadConfig() {
  config = loadXML("config.xml");

  comPort=config.getString("comPort", null);
  targetIP=config.getString("targetIP", "255.255.255.255");
  targetPort=config.getInt("targetPort", 5000);
  entryUDP=config.getString("entryMsg", "SV:1200:1\n");
  exitUDP=config.getString("exitMsg", "SV:1200:0\n");
  eol=boolean(config.getInt("EOL", 1));

  if (eol) {
    entryUDP=entryUDP+"\n";
    exitUDP=exitUDP+"\n";
  } else {
  }

  //verboseConfig();
}

void verboseConfig() {
  println("Serial communication started on  "+comPort);
  println("UDP will be send to  "+targetIP+" on port  "+targetPort);
  println("UDP message on entry:  "+entryUDP);
  println("UDP message on exit:  "+exitUDP);
}
