class Agent {
  int row_pos;
  int col_pos;
  
  String agent_state = "";
  
  int sir_day_cnt = 0;
  
  Agent(int _row_pos, int _col_pos, String _agent_state, int _sir_day_cnt) {
    row_pos = _row_pos;
    col_pos = _col_pos;
    agent_state = _agent_state;
    sir_day_cnt = _sir_day_cnt;
  }

  void testWhetherInfected() {
    if (!agent_state.equals(SUSCEPTIBLE)) {
      return;
    }
    int infected_neighbor_cnt = cntInfectedNeighbors();
    // perform random tests to determine whether the agent will be infected
    for (int j = 0; j < infected_neighbor_cnt; j++) {
      if (random(1) < p_transmission) {
        getInfected();
        return;
      }
    }
  }
  
  int[] moveAndReturnPos() {
    ArrayList<int[]> possible_move = getPossibleMoves();
    if (possible_move.size() == 0) { 
      return new int[] {NOT_AVAILABLE, NOT_AVAILABLE};
    }
    int[] move = getNextRandomMove(possible_move);
    int prev_row_pos = row_pos;
    int prev_col_pos = col_pos;
    row_pos = (row_pos + move[0] + cell_per_row) % cell_per_row;
    col_pos = (col_pos + move[1] + cell_per_col) % cell_per_col;
    grid[row_pos][col_pos] = new Agent(row_pos, col_pos, agent_state, sir_day_cnt);
    // delete the agent in the original pos
    grid[prev_row_pos][prev_col_pos] = null;
    return new int[]{row_pos, col_pos};
  }
  
  void recoverFromInfection() {
    agent_state = RECOVERED;
    sir_day_cnt = 0;
    recovered_cnt += 1;
    infected_cnt -= 1;
  }
  
  void getInfected() {
    agent_state = INFECTED;
    sir_day_cnt = 0;
    infected_cnt += 1;
    susceptible_cnt -= 1;
  }
  
  int[] getNextRandomMove(ArrayList<int[]> possible_move) {
    float rand = random(possible_move.size());
    int[] move = possible_move.get((int)rand);
    return move;
  }
  
  ArrayList<int[]> getPossibleMoves() {
    ArrayList<int[]> possible_move = new ArrayList<int[]>();
    ArrayList<Agent> neighbors = getNeighbors();
    for (int i = 0; i < neighbors.size(); i++) {
      if (neighbors.get(i) == null) {
        possible_move.add(new int[]{row_dir[i], col_dir[i]});
      }
    }
    return possible_move;
  }
  
  
  int cntInfectedNeighbors() {
    int infected_neighbor_cnt = 0;
    ArrayList<Agent> neighbors = getNeighbors();
    for (int i = 0; i < neighbors.size(); i++) {
      if (neighbors.get(i) != null) {
          String agent_state = neighbors.get(i).getAgentState();
          if (agent_state.equals(INFECTED)) {
            infected_neighbor_cnt += 1;
        }
      }
    }  
    return infected_neighbor_cnt;
  }

  ArrayList<Agent> getNeighbors() {
    ArrayList<Agent> neighbors = new ArrayList<Agent>();
    for (int i = 0; i < row_dir.length; i++) {
      int new_row_pos = (row_pos + row_dir[i] + cell_per_row) % cell_per_row;
      int new_col_pos = (col_pos + col_dir[i] + cell_per_col) % cell_per_col;
      if (grid[new_row_pos][new_col_pos] != null) {
        neighbors.add(grid[new_row_pos][new_col_pos]);
      } else {
        neighbors.add(null);
      }
    }
    return neighbors;
  }
  
  int getSIRDayCnt() {
    return sir_day_cnt;
  }
  
  int[] getPos() {
    return new int[] {row_pos, col_pos};
  }
  
  String getAgentState() {
    return agent_state;
  }
  
  void incrementSIRDayCnt() {
    sir_day_cnt += 1;
  }
  
  void display() {
    int x = row_pos * agent_size;
    int y = col_pos * agent_size;
    
    stroke(BORDER_COLOR);
    strokeWeight(LIGHT_STROKE_WEIGHT);
    
    if (agent_state.equals(INFECTED)) {
      fill(INFECTED_AGENT_COLOR);
    } else if (agent_state.equals(SUSCEPTIBLE)) {
      fill(SUSCEPTIBLE_AGENT_COLOR);
    } else {
      fill(RECOVERED_AGENT_COLOR);
    }
    square(x, y, agent_size);
  } 
}
