XML config;

void loadConfig() {
  config = loadXML("config.xml");

  //comPort=config.getString(comPort);
  
  
  //winScale=config.getFloat("winScale", 100);
  ////winX=int(config.getInt("resx", 100)*winScale)+1*winTol;
  //winX=int(config.getInt("resx", 100)*winScale);
  ////winY=int(config.getInt("resy", 100)*winScale)+7*winTol;
  //winY=int(config.getInt("resy", 100)*winScale);
  //targetIP=config.getString("targetIP", "255.255.255.255");
  //targetPort=config.getInt("targetPort", 5000);
}
