double [][][] grid;
double [][] display_grid;
int grid_row_size;
int grid_col_size;
int cell_size;
int init_gray_row_size;
int init_gray_col_size;
int init_gray_row_start;
int init_gray_col_start;
double h;
double k;
double f;
int dt;
double step_size_k;
double step_size_f;
int display_index;
boolean diffusion_only_mode;
boolean simulation_mode;
boolean spatial_varying_mode;
final int NUM_CHEMICALS = 2;
final int U_INDEX = 0;
final int V_INDEX = 1;
final int K_INDEX = 0;
final int F_INDEX = 1;
final double ru = 0.082;
final double rv = 0.041;
final float MIN_K = 0.03;
final float MAX_K = 0.07;
final float MIN_F = 0.00;
final float MAX_F = 0.08;
double[] diffusion_constant = new double[] {ru, rv}; 
final int OFFSET = 2;
final int[] ROW_DIR = {1, -1, 0, 0};
final int[] COL_DIR = {0, 0, 1, -1};
final int WHITE_COLOR_VALUE = 255;

void setup() {
  size(800, 800);
  grid_row_size = 200;
  grid_col_size = 200;
  init_gray_row_size = 10;
  init_gray_col_size = 10;
  cell_size = 4;
  
  display_index = U_INDEX;
  diffusion_only_mode = false;
  simulation_mode = false;
  spatial_varying_mode = false;
  
  k = 0.0625;
  f = 0.035;
  step_size_k = (MAX_K - MIN_K) / grid_col_size; // step_size_k is for the horizontal change
  step_size_f = (MAX_F - MIN_F) / (grid_row_size - 1); // step_size f is for the vertical change
  dt = 2; // when dt >= 13, the diffusion becomes unstable
  
  grid = new double[grid_row_size][grid_col_size][NUM_CHEMICALS];
  display_grid = new double[grid_row_size][grid_col_size];
  
  initializeGrid();
  display();
}

void draw() {
  if (simulation_mode == true) {
    if (diffusion_only_mode == true) {
      diffusionOneStep();
    } else {
      reactionDiffusionOneStep();
    }
  }
  display();
}

void keyPressed() {
  if (key == '1') {
    setKandF(0.0625, 0.035); // k = 0.0625, f = 0.035; spots pattern
    //initializeGrid();
  } else if (key == '2') {
    setKandF(0.06, 0.035); // stripes pattern
    //initializeGrid();
  } else if (key == '3') {
    setKandF(0.0475, 0.0118); // spiral waves pattern
    //initializeGrid();
  } else if (key == '4') {
    setKandF(0.0625, 0.035); // Parameters of your choice
  } else if (key == 'i' || key == 'I') {
    initializeGrid();
  } else if (key == 'u' || key == 'U') {
    display_index = U_INDEX;
  } else if (key == 'v' || key == 'V') {
    display_index = V_INDEX;
  } else if (key == 'd' || key == 'D') {
    diffusion_only_mode = !diffusion_only_mode;
  } else if (key == ' ') {
    simulation_mode = !simulation_mode;
  } else if (key == 'p' || key == 'P') {
    spatial_varying_mode = !spatial_varying_mode;
  }
}

void mouseClicked() {
  int row_pos = mouseY / cell_size;
  int col_pos = mouseX / cell_size;
  println("u: " + grid[row_pos][col_pos][U_INDEX] + " " + "v: " + 
          grid[row_pos][col_pos][V_INDEX]);
}
