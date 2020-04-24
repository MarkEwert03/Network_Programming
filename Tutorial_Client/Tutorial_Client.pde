//Mark Ewert "209.121.150.126" Mr P
//Apr 16

//Client
import processing.net.*;
Client myClient;
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

  myClient = new Client(this, "201.6.49.227", 1234);
  //             Client(this sketch, ip adress which for this computer is "127.0.0.1", arbitrary number foe wifi access)
}//-------------------------------------------------------------------------------------------------------------------------------------------------------------

void draw() {
  //Basic
  background(255);
  fill(128);
  text(outgoing, width/2, height*1/4);
  fill(64);
  text(incoming, width/2, height*3/4);

  if (myClient.available() > 0) {
    incoming = myClient.readString();
  }
}//-------------------------------------------------------------------------------------------------------------------------------------------------------------

void keyPressed() {
  if (key == ENTER) {
    myClient.write(outgoing);
    outgoing = "";
  } else if (key == BACKSPACE && outgoing.length() > 0) {
    outgoing = outgoing.substring(0, outgoing.length()-1);
  } else if (valid.contains(""+key)) {
    outgoing += key;
  }
}//-------------------------------------------------------------------------------------------------------------------------------------------------------------
