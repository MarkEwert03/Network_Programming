//Mark Ewert
//Apr 24

int[][] grid;

//------------------------------------------------------------------------
void setup() {
  //basic
  size(300, 400);
  strokeWeight(4);
  textAlign(CENTER, CENTER);
  textSize(50);

  //grid
  grid = new int[3][3];
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

  //mouse coordinates
  fill(0);
  text(mouseX + ", " + mouseY, width/2, height*7/8);

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
}//------------------------------------------------------------------------

void mousePressed() {
  int row = mouseX/100;
  int col = mouseY/100;
  if (grid[row][col] == 0) {
    grid[row][col] = 2;
  }
  println(row, col);
}//------------------------------------------------------------------------

void drawXO(int _row, int _col) {
  pushMatrix();
  translate(_row*100, _col*100);
  if (grid[_row][_col] == 1) { //X's
  line(10, 10, 90, 90);
  line(10, 90, 90, 10);
  } else if (grid[_row][_col] == 2) { //O's
  noFill();
  ellipse(50, 50, 90, 90);
  }
  popMatrix();
}//------------------------------------------------------------------------
