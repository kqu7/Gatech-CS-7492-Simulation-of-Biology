void reactionDiffusionOneStep() {
  double[][][] diffusion_interemdiate_value = diffusionOneStep();
  double[][][] reaction_intermediate_value = reactionOneStep();
  for (int i = 0; i < grid_row_size; i += 1) {
    for (int j = 0; j < grid_col_size; j += 1) {
      grid[i][j][U_INDEX] += dt * (diffusion_interemdiate_value[i][j][U_INDEX] +
                            reaction_intermediate_value[i][j][U_INDEX]);
      grid[i][j][V_INDEX] += dt * (diffusion_interemdiate_value[i][j][V_INDEX] +
                            reaction_intermediate_value[i][j][V_INDEX]);
    }
  }
}

double[][][] diffusionOneStep() {
  double[][][] intermediate_values = new double[grid_row_size][grid_col_size][NUM_CHEMICALS];
  for (int i = 0; i < grid_row_size; i += 1) {
    for (int j = 0; j < grid_col_size; j += 1) {
      intermediate_values[i][j][U_INDEX] = diffusionPerCell(i, j, U_INDEX);
      intermediate_values[i][j][V_INDEX] = diffusionPerCell(i, j, V_INDEX);                                                   
    }
  }
  if (diffusion_only_mode == true) {
    add_intermediate_to_grid(intermediate_values);
  }
  return intermediate_values;
}

double[][][] reactionOneStep() {
  double[][][] intermediate_values = new double[grid_row_size][grid_col_size][NUM_CHEMICALS];
  for (int i = 0; i < grid_row_size; i += 1) {
    for (int j = 0; j < grid_col_size; j += 1) {
       double[] updated_uv = reactionPerCell(i, j);
       intermediate_values[i][j][U_INDEX] = updated_uv[U_INDEX];
       intermediate_values[i][j][V_INDEX] = updated_uv[V_INDEX];
    }
  }
  return intermediate_values;
}

double diffusionPerCell(int row_pos, int col_pos, int chemical_index) {
   double diffusion_value = 0.0;
   double coefficient = diffusion_constant[chemical_index];
   for (int i = 0; i < ROW_DIR.length; i += 1) {
     int new_row_pos = (row_pos + ROW_DIR[i] + grid_row_size) % grid_row_size;
     int new_col_pos = (col_pos + COL_DIR[i] + grid_col_size) % grid_col_size;
     diffusion_value += coefficient * grid[new_row_pos][new_col_pos][chemical_index];
   }
   diffusion_value -= 4 * coefficient * grid[row_pos][col_pos][chemical_index];
   return diffusion_value;
}

double[] reactionPerCell(int row_pos, int col_pos) {
  double u = grid[row_pos][col_pos][U_INDEX];
  double v = grid[row_pos][col_pos][V_INDEX];
  double uvv = u * v * v;
  double[] kf = getKandF(row_pos, col_pos);
  double reaction_u = (kf[F_INDEX] * (1 - u) - uvv);
  double reaction_v = (uvv - (kf[F_INDEX] + kf[K_INDEX]) * v);
  return new double[] {reaction_u, reaction_v};
}
