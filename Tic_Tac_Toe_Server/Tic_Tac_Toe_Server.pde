//Mark Ewert //<>//
//Apr 24

//grid
int[][] grid;
color turnColor;
color red         = #800000;
color paleRed     = #330000;
color green       = #008000;
color paleGreen   = #003300;

//server (Sends x's )
import processing.net.*;
Server myServer;

//game
final int O = 1;
final int X = 2;
final int TIE = 3;
int firstTurn;
int turn;
int winner;

//------------------------------------------------------------------------
void setup() {
  //basic
  size(300, 400);
  strokeWeight(4);
  textAlign(CENTER, CENTER);
  textSize(50);

  //grid
  grid = new int[3][3];

  //server
  myServer = new Server(this, 1234, Server.ip());

  //game
  firstTurn = int(random(1, 3)); // 1 = O's, 2 = X's
  println(firstTurn);
}//------------------------------------------------------------------------

void draw() {
  //basic
  background(255);

  //drawing the grid
  if (turn == X) turnColor = paleGreen;
  else if (turn == O) turnColor = paleRed;
  else turnColor = 0;
  stroke(turnColor);
  line(0, 100, 300, 100);
  line(0, 200, 300, 200);
  line(100, 0, 100, 300);
  line(200, 0, 200, 300);
  noFill();
  rect(0, 0, 300, 300);

  //grid loop
  int gridFiller = 0;
  for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 3; col++) {
      drawXO(row, col);
      //tie condition
      if (grid[row][col] != 0) {
        gridFiller++;
      }
    }
  }
  if (gridFiller == 9) {
    winner = TIE;
  }

  //mouse coordinates
  fill(0);
  text(mouseX + ", " + mouseY, width/2, height*7/8);

  //win conditions
  if (grid[1][1] == X) { //middle
    if (grid[0][0] == X && grid[2][2] == X) winner = X;
    if (grid[1][0] == X && grid[1][2] == X) winner = X;
    if (grid[2][0] == X && grid[0][2] == X) winner = X;
    if (grid[2][1] == X && grid[0][1] == X) winner = X;
  } 
  if (grid[0][0] == X) { //top left
    if (grid[1][0] == X && grid[2][0] == X) winner = X;
    if (grid[0][1] == X && grid[0][2] == X) winner = X;
  } 
  if (grid[2][2] == X) {
    if (grid[2][0] == X && grid[2][1] == X) winner = X;
    if (grid[0][2] == X && grid[1][2] == X) winner = X;
  }
  
  //lose conditions
  if (grid[1][1] == O) { //middle
    if (grid[0][0] == O && grid[2][2] == O) winner = O;
    if (grid[1][0] == O && grid[1][2] == O) winner = O;
    if (grid[2][0] == O && grid[0][2] == O) winner = O;
    if (grid[2][1] == O && grid[0][1] == O) winner = O;
  } 
  if (grid[0][0] == O) { //top left
    if (grid[1][0] == O && grid[2][0] == O) winner = O;
    if (grid[0][1] == O && grid[0][2] == O) winner = O;
  } 
  if (grid[2][2] == O) {
    if (grid[2][0] == O && grid[2][1] == O) winner = O;
    if (grid[0][2] == O && grid[1][2] == O) winner = O;
  }

  //server
  Client myClient = myServer.available();
  if (myClient != null) {
    String incoming = myClient.readString();
    int recieveRow = int(incoming.substring(0, 1));
    int recieveCol = int(incoming.substring(2, 3));
    grid[recieveRow][recieveCol] = O;
    turn = X;
  } 

  //winner or loser shown
  if (winner == X) {
    stroke(paleGreen);
    strokeWeight(10);
    fill(green);
    rect(0, 0, width, height);
    fill(paleGreen);
    text("You Win!", width/2, height/2);
  } else if (winner == O) {
    stroke(paleRed);
    strokeWeight(10);
    fill(red);
    rect(0, 0, width, height);
    fill(paleRed);
    text("You Lose", width/2, height/2);
  } else if (winner == TIE) {
    stroke(0);
    strokeWeight(10);
    fill(255);
    rect(0, 0, width, height);
    fill(0);
    text("It's a tie", width/2, height/2);
  }
}//------------------------------------------------------------------------

void mousePressed() {
  int row = mouseX/100;
  int col = mouseY/100;
  if (turn == X && grid[row][col] == 0) {
    myServer.write(row + "," + col);
    grid[row][col] = X;
    println(row + ", " + col);
    turn = O;
  }

  //first Turn
  if (firstTurn != 0) {
    if (firstTurn == O) {
      println("O's start");
      myServer.write("your");
      turn = O;
      firstTurn = 0;
    } else if (firstTurn == X) {
      println("X's start");
      turn = X;
      if (grid[row][col] == 0 && mouseX != 0) {
        myServer.write(row + "," + col);
        grid[row][col] = X;
        turn = O;
        firstTurn = 0;
      }
    }
  }
}//------------------------------------------------------------------------

void drawXO(int _row, int _col) {
  pushMatrix();
  translate(_row*100, _col*100);
  if (grid[_row][_col] == X) { //X's
    stroke(green);
    line(10, 10, 90, 90);
    line(10, 90, 90, 10);
  } else if (grid[_row][_col] == O) { //O's
    noFill();
    stroke(red);
    ellipse(50, 50, 90, 90);
  }
  popMatrix();
}//------------------------------------------------------------------------
