//Mark Ewert
//Apr 16

//Server
import processing.net.*;
Server myServer;
String outgoing; 
String incoming;
String valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890!@#$%^&*()[]{}-_=+;:,.?<>";

void setup() {
  //Basic
  size(300, 300);
  textAlign(CENTER, CENTER);
  textSize(20);

  outgoing = "";
  incoming = "";

  myServer = new Server(this, 1234);
}//------------------------------------------------------------------------------------------------------------------------------------------------------------

void draw () {
  //Basic
  background(0);
  fill(64);
  text(outgoing, width/2, height*1/4);
  fill(128);
  text(incoming, width/2, height*3/4);

  Client myClient = myServer.available();
  if (myClient != null) {
    incoming = myClient.readString();
  }
}//------------------------------------------------------------------------------------------------------------------------------------------------------------

void keyPressed() {
  if (key == ENTER) {
    myServer.write(outgoing);
    outgoing = "";
  } else if (key == BACKSPACE && outgoing.length() > 0) { 
    outgoing = outgoing.substring(0, outgoing.length()-1);
  } else if (valid.contains(""+key)) {
    outgoing += key;
  }
}//-------------------------------------------------------------------------------------------------------------------------------------------------------------
