void initializeGrid() {
  // Initialize chemical values for each grid cell
  for (int i = 0; i < grid_row_size; i += 1) {
    for (int j = 0; j < grid_col_size; j += 1) {
      grid[i][j][U_INDEX] = 1;
      grid[i][j][V_INDEX] = 0;
    }
  }
  // Creating a 10x10 gray block
  init_gray_row_start = (int)random(grid_row_size - init_gray_row_size - OFFSET);
  init_gray_col_start = (int)random(grid_col_size - init_gray_col_size - OFFSET);
  for (int i = init_gray_row_start; i < init_gray_row_start + init_gray_row_size; i += 1) {
    for (int j = init_gray_col_start; j < init_gray_col_start + init_gray_col_size; j += 1) {
      grid[i][j][U_INDEX] = 0.5;
      grid[i][j][V_INDEX] = 0.25;
    }
  }
  return;
}

void add_intermediate_to_grid(double[][][] intermediate_values) {
    for (int i = 0; i < grid_row_size; i += 1) {
      for (int j = 0; j < grid_col_size; j += 1) {
        grid[i][j][U_INDEX] += intermediate_values[i][j][U_INDEX];
        grid[i][j][V_INDEX] += intermediate_values[i][j][V_INDEX];
      }
  }
  return;
}

void copyToDisplayGrid() {
  for (int i = 0; i < grid_row_size; i += 1) {
    for (int j = 0; j < grid_col_size; j += 1) {
      display_grid[i][j] = grid[i][j][display_index];
    }
  }
}

void setKandF(float k_, float f_) {
  k = k_;
  f = f_;
  return;
}

double[] getKandF(int row_pos, int col_pos) {
  double cur_k, cur_f;
  if (spatial_varying_mode == true) {
    cur_k = lerp(MIN_K, MAX_K, 1.0 * col_pos / (grid_col_size - 1));
    cur_f = lerp(MAX_F, MIN_F, 1.0 * row_pos / (grid_row_size - 1));
  } else {
    cur_k = k;
    cur_f = f;
  }
  return new double[] {cur_k, cur_f};
}

void display() {
  copyToDisplayGrid();
  scaleGridValue();
  for (int i = 0; i < grid_row_size; i += 1) {
    for (int j = 0; j < grid_col_size; j+= 1) {
      displayCell(i, j);
    }
  }
  return;
}

void scaleGridValue() {
  double[] max_value = findExtremeValue(true);
  double[] min_value = findExtremeValue(false);
  for (int i = 0; i < grid_row_size; i += 1) {
    for (int j = 0; j < grid_col_size; j += 1) {
      display_grid[i][j] = (display_grid[i][j] - min_value[display_index]) / 
                           (max_value[display_index] - min_value[display_index]);
    }
  }
  return;
}

double[] findExtremeValue(boolean find_max) {
  double[] extreme_value;
  if (find_max == true) {
    // try to find the maximum value
    extreme_value = new double[] {Double.MIN_VALUE, Double.MIN_VALUE};
  } else {
    extreme_value = new double[] {Double.MAX_VALUE, Double.MAX_VALUE};
  }
  for (int i = 0; i < grid_row_size; i += 1) {
    for (int j = 0; j < grid_col_size; j += 1) {
      if (find_max == true) {
        extreme_value[U_INDEX] = Math.max(extreme_value[U_INDEX], grid[i][j][U_INDEX]);
        extreme_value[V_INDEX] = Math.max(extreme_value[V_INDEX], grid[i][j][V_INDEX]);
      } else {
        extreme_value[U_INDEX] = Math.min(extreme_value[U_INDEX], grid[i][j][U_INDEX]);
        extreme_value[V_INDEX] = Math.min(extreme_value[V_INDEX], grid[i][j][V_INDEX]);  
      }
    }
  }
  return extreme_value;
}

void displayCell(int row_pos, int col_pos) {
  int x = col_pos * cell_size;
  int y = row_pos * cell_size;
  fill((int)(WHITE_COLOR_VALUE * display_grid[row_pos][col_pos]));
  noStroke();
  square(x, y, cell_size);
  return;
}
