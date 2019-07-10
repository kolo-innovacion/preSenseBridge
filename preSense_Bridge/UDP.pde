import hypermedia.net.*;

UDP udp;

String targetIP; // the remote IP address
int targetPort;

String entryUDP;
String exitUDP;

void setupUDP() {
  
  udp = new UDP( this, 6000 );
}
