class SubPopulationGraph {
  int subgraph_h = -1;
  int subgraph_w = -1;
  
  int current_x_pos = 5;
  
  int step_size = 6;
  int mark_size = 5;
  
  float height_ratio = 0.75;
  
  SubPopulationGraph(int _subgraph_h, int _subgraph_w) {
    subgraph_h = _subgraph_h;
    subgraph_w = _subgraph_w;
    fill(WHITE_COLOR);
    rect(0, 800, 800, 100 + 10); // 10 is the left margin
  }
  
  float calculate_height(float percentage) {
    return subgraph_h * percentage * height_ratio;
  }
  
  void update() {
    strokeWeight(HEAVY_STROKE_WEIGHT);
    stroke(INFECTED_AGENT_COLOR);
    
    float infected_height = calculate_height(1.0 * infected_cnt / filled_cnt);
    point(current_x_pos, 875 - infected_height); 

    stroke(SUSCEPTIBLE_AGENT_COLOR);
    float susceptible_height = calculate_height(1.0 * susceptible_cnt / filled_cnt);
    point(current_x_pos, 875 - susceptible_height); 
    
    stroke(RECOVERED_AGENT_COLOR);
    float recovered_height = calculate_height(1.0 * recovered_cnt / filled_cnt);
    point(current_x_pos, 875 - recovered_height); 
    
    current_x_pos += step_size;
  }
}
