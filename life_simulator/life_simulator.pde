int cell_size = 9;
int cell_per_row = 100;
int cell_per_col = 100;
// this variable denotes whehter the mode of operation is continous or not
boolean mode = false;
int buffer_time = 500;
Cell[][] grid;

void setup() {
  // define the size of the board
  size(900, 900);
  // construct the grid 
  grid = new Cell[cell_per_row][cell_per_col];
  // populate the grid with cells, initalizing the alive status of the cell to death
  initializeCell(false);
}

void draw() {
  if (!mode) {
    for (int row_cnt = 0; row_cnt  < cell_per_row; row_cnt += 1) {
      for (int col_cnt = 0; col_cnt < cell_per_col; col_cnt += 1) {
        grid[row_cnt][col_cnt].display();
      }
    }
  } else {
    simulateOneStep();
  }
}

void mousePressed() {
  int cell_row_pos = mouseX / cell_size;
  int cell_col_pos = mouseY / cell_size;
  grid[cell_row_pos][cell_col_pos].changeAliveStatus();
  grid[cell_row_pos][cell_col_pos].display();
}


void keyPressed() {
  // if the released key is either c or C, clear the grid to all black
  if (key == 'c' || key == 'C') {
     initializeCell(false);
  } else if (key == 'r' || key == 'R') {
  // if the released key is either r or R, randomize the state of the grid
     initializeCell(true);
  } else if (key == 'g' || key == 'G') {
  // if the released key is g or G, toggle between single-step and continuous update mode
    mode = !mode;
  } else if (key == ' ') {
  // if the released key is space bar, switch to single-step mode and take one simulation step
    mode = false;
    simulateOneStep();
  }
}

void initializeCell(boolean random_flag) {
  for (int row_cnt = 0; row_cnt  < cell_per_row; row_cnt += 1) {
    for (int col_cnt = 0; col_cnt < cell_per_col; col_cnt += 1) {
      // if randomFlag is set to true, then initialize the alive status of cells by the random number
      // otherwise, initialize the alive status of cells to death
      grid[row_cnt][col_cnt] = new Cell(row_cnt, col_cnt, random_flag ? (random(1) > 0.49 ? true : false) : false);
    }
  }
}

void simulateOneStep() {
  for (int row_cnt = 0; row_cnt  < cell_per_row; row_cnt += 1) {
    for (int col_cnt = 0; col_cnt < cell_per_col; col_cnt += 1) {
      int alive_neighbor_cnt = grid[row_cnt][col_cnt].getAliveNeighborCnt();
      if (alive_neighbor_cnt == 3) {
        if (grid[row_cnt][col_cnt].isAlive() == false) {
          grid[row_cnt][col_cnt].changeAliveStatus();
        }
      } else {
        if (grid[row_cnt][col_cnt].isAlive() == true && alive_neighbor_cnt != 2) {
          grid[row_cnt][col_cnt].changeAliveStatus();
        }
      }
      grid[row_cnt][col_cnt].display();
    }  
  }
}

class Cell {
  int rowPos;
  int colPos;
  boolean alive;
  
  Cell(int _rowPos, int _colPos, boolean _alive) {
    rowPos = _rowPos;
    colPos = _colPos;
    alive = _alive;
  }
  
  int getAliveNeighborCnt() {
    int alive_neighbor_cnt = 0;
    int[] rowDir = { 0, 0, -1, -1, -1, 1, 1, 1};
    int[] colDir = { 1, -1, 0, 1, -1, 0, 1, -1};
    for (int i = 0; i < rowDir.length; i++) {
      int curRowPos = (rowDir[i] + rowPos + cell_per_row) % cell_per_row;
      int curColPos = (colDir[i] + colPos + cell_per_col) % cell_per_col;
      if (grid[curRowPos][curColPos].isAlive()) {
        alive_neighbor_cnt += 1;
      }
    }
    return alive_neighbor_cnt;
  }
  
  boolean isAlive() {
    return alive;
  }
  
  void changeAliveStatus() {
    alive = !alive;
  }
  
  void display() {
    int x = rowPos * cell_size;
    int y = colPos * cell_size;
    // draw the border of the cell
    stroke(153);
    // fill the color of the cell
    if (alive) {
      // if the cell is alive, fill the cell with the white color
      fill(255);
    } else {
      // otherwise, fill the cell with the black color
      fill(0);
    }
    square(x, y, cell_size);
  }
}
