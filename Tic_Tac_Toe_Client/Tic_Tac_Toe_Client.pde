//Mark Ewert
//Apr 24

//grid
int[][] grid;
final int O = 1;
final int X = 2;

//client (Sends x's )
import processing.net.*;
Client myClient;

//------------------------------------------------------------------------
void setup() {
  //basic
  size(300, 400);
  strokeWeight(4);
  textAlign(CENTER, CENTER);
  textSize(50);

  //grid
  grid = new int[3][3];

  //client
  myClient = new Client(this, "127.0.0.1", 1234);
}//------------------------------------------------------------------------

void draw() {
  //basic
  background(255);

  //drawing the grid
  stroke(0);
  line(0, 100, 300, 100);
  line(0, 200, 300, 200);
  line(100, 0, 100, 300);
  line(200, 0, 200, 300);
  noFill();
  rect(0, 0, 300, 300);

  //grid loop
  int row = 0;
  int col = 0;
  while (row < 3) {
    drawXO(row, col);
    col++;
    if (col >= 3) {
      col = 0;
      row++;
    }
  }

  //mouse coordinates
  fill(0);
  text(mouseX + ", " + mouseY, width/2, height*7/8);

  //client
  if (myClient.available() > 0) {
    String incoming = myClient.readString();
    int recieveRow = int(incoming.substring(0, 1));
    int recieveCol = int(incoming.substring(2, 3));
    grid[recieveRow][recieveCol] = O;
  }
}//------------------------------------------------------------------------

void mousePressed() {
  int row = mouseX/100;
  int col = mouseY/100;
  if (grid[row][col] == 0) {
    myClient.write(row + "," + col);
    grid[row][col] = X;
  }
  println(row + ", " + col);
}//------------------------------------------------------------------------

void drawXO(int _row, int _col) {
  pushMatrix();
  translate(_row*100, _col*100);
  if (grid[_row][_col] == X) { //X's
    line(10, 10, 90, 90);
    line(10, 90, 90, 10);
  } else if (grid[_row][_col] == O) { //O's
    noFill();
    ellipse(50, 50, 90, 90);
  }
  popMatrix();
}//------------------------------------------------------------------------
