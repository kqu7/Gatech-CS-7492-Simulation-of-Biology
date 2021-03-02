import java.util.*;

int agent_size = 8;
int cell_size = 5;
int cell_per_row = 100;
int cell_per_col = 100;

Agent[][] grid;
SubPopulationGraph sub_graph;

double p_filled = 0.0;
double p_infected = 0.0;
double p_transmission = 0.0;
int time_to_recovery = 0;

int filled_cnt = 0;
int infected_cnt = 0;
int recovered_cnt = 0;
int susceptible_cnt = 0;

String SUSCEPTIBLE = "S";
String INFECTED = "I";
String RECOVERED = "R";
String EMPTY = "E";
int NOT_AVAILABLE = -1;

int INFECTED_AGENT_COLOR = color(255, 0, 0);
int SUSCEPTIBLE_AGENT_COLOR = color(0, 255, 0);
int RECOVERED_AGENT_COLOR = color(0, 0, 255);
int WHITE_COLOR = 255;
int BLACK_COLOR = 0;
float BORDER_COLOR = 153;

int HEAVY_STROKE_WEIGHT = 3;
int LIGHT_STROKE_WEIGHT = 1;

int subgraph_h = 75;
int subgraph_w = 800;

ArrayList<int[]> all_dirs = new ArrayList<int[]>();
int[] row_dir = {1, -1, 0, 0};
int[] col_dir = {0, 0, 1, -1};

boolean continuous_mode = false;
HashSet<Character> scenario_keys = new HashSet<Character>();

void setup() {
  size(800, 900);
  
  grid = new Agent[cell_per_row][cell_per_col];
  initializeGrid();
  sub_graph = new SubPopulationGraph(subgraph_h, subgraph_w);
  
  fillScenarioKeys(new Character[]{'1', '2', '3', '4', '5', '6'}, scenario_keys);
}

void draw() {
  if (!continuous_mode) {
    displayGrid();
  } else {
    simulateOneStep();
  }
}

void keyPressed() {
  p_infected = 0.005;
  if (key == '1') {
    updateSIRParameter(1.00, 0.20, 5); // p_filled, p_transmission, time_to_recovery
  } else if (key == '2') {
    updateSIRParameter(1.00, 0.20, 2);
  } else if (key == '3') {
    updateSIRParameter(1.00, 0.12, 5);
  } else if (key == '4') {
    updateSIRParameter(0.30, 0.85, 4);
  } else if (key == '5') {
    updateSIRParameter(0.30, 0.10, 2);
  } else if (key == '6') {
    updateSIRParameter(0.30, 0.93, 3);
  } else if (key == 's' || key == 'S') {
    continuous_mode = false;
    simulateOneStep();
  } else if (key == ' ') {
    continuous_mode = !continuous_mode;
  }
  if (scenario_keys.contains(key)) {
    initializeGrid();
    sub_graph = new SubPopulationGraph(subgraph_h, subgraph_w);
  }
}

void simulateOneStep() {
  IntList rand_pos = getRandomGridPosIdx();
  
  for (int i = 0; i < rand_pos.size(); i += 1) {
    
    int row_pos = rand_pos.get(i) / cell_per_row;
    int col_pos = rand_pos.get(i) % cell_per_row;    
    
    if (grid[row_pos][col_pos] != null) {
      String prev_agent_state = grid[row_pos][col_pos].getAgentState();
      
      if (grid[row_pos][col_pos].getAgentState().equals(SUSCEPTIBLE)) {
        grid[row_pos][col_pos].testWhetherInfected();
      } 
      
      int[] cur_pos = grid[row_pos][col_pos].moveAndReturnPos();
      if (cur_pos[0] != NOT_AVAILABLE) {
        row_pos = cur_pos[0];
        col_pos = cur_pos[1];
      }
      
      if (grid[row_pos][col_pos].getAgentState().equals(INFECTED)) {
        if (!prev_agent_state.equals(SUSCEPTIBLE)) {
          grid[row_pos][col_pos].incrementSIRDayCnt();
          
          if (grid[row_pos][col_pos].getSIRDayCnt() == time_to_recovery) {
            grid[row_pos][col_pos].recoverFromInfection();
          }
        }
      }
      grid[row_pos][col_pos].display();
    }
  }
  
  fillGridWithBlackSquare();
  
  sub_graph.update();
}

void initializeGrid() {
  // delete all agents in the grid
  cleanUpGrid();
  
  IntList rand_pos = getRandomGridPosIdx();
  int total_cnt = cell_per_row * cell_per_col;
  
  infected_cnt = (int)(total_cnt * p_infected);
  filled_cnt = (int)(total_cnt * p_filled);
  recovered_cnt = 0;
  susceptible_cnt = filled_cnt - infected_cnt;
  
  int cnt = 0;
  
  // fill infected agents
  fillAgentOrBlackSquare(rand_pos, cnt, infected_cnt, INFECTED);
  cnt += infected_cnt;
  
  // fill susceptible agents
  fillAgentOrBlackSquare(rand_pos, cnt, cnt + susceptible_cnt, SUSCEPTIBLE);
  cnt += susceptible_cnt;
  
  // fill empty cells
  fillAgentOrBlackSquare(rand_pos, cnt, total_cnt, EMPTY);
}


void fillAgentOrBlackSquare(IntList pos, int start, int end, String initial_state) {
  while (start < end) {
    int row_pos = pos.get(start) / cell_per_row;
    int col_pos = pos.get(start) % cell_per_row;
    if (!initial_state.equals(EMPTY)) {
      grid[row_pos][col_pos] = new Agent(row_pos, col_pos, initial_state, 0);
      grid[row_pos][col_pos].display();
    } else {
      drawBlackSquare(row_pos, col_pos);
    }
    start += 1;
  }
}

void displayGrid() {
  for (int row_pos = 0; row_pos < cell_per_row; row_pos += 1) {
    for (int col_pos = 0; col_pos < cell_per_col; col_pos += 1) {
      if (grid[row_pos][col_pos] != null) {
        grid[row_pos][col_pos].display();
      } else {
        drawBlackSquare(row_pos, col_pos);
      }
    }
  }
}

void cleanUpGrid() {
  for (int i = 0; i < cell_per_row; i += 1) {
    for (int j = 0; j < cell_per_col; j += 1) {
      grid[i][j] = null;
    }
  }
}

void fillGridWithBlackSquare() {
  for (int row_pos = 0; row_pos < cell_per_row; row_pos += 1) {
    for (int col_pos = 0; col_pos < cell_per_col; col_pos += 1) {
      if (grid[row_pos][col_pos] == null) {
        drawBlackSquare(row_pos, col_pos);
      }
    }
  }
}

void drawBlackSquare(int row_pos, int col_pos) {
  int x = row_pos * agent_size;
  int y = col_pos * agent_size;
  stroke(BORDER_COLOR);
  strokeWeight(LIGHT_STROKE_WEIGHT);
  fill(BLACK_COLOR);
  square(x, y, agent_size);
}

void updateSIRParameter(float _p_filled, float _p_transmission, int _time_to_recovery) {
  p_filled = _p_filled;
  p_transmission = _p_transmission;
  time_to_recovery = _time_to_recovery;
}

IntList getRandomGridPosIdx() {
  IntList pos = new IntList();
  for (int i = 0; i < cell_per_row; i += 1) {
    for (int j = 0; j < cell_per_col; j+= 1) {
      pos.append(i * cell_per_row + j);
    }
  }
  pos.shuffle();
  return pos;
}

void fillScenarioKeys(Character[] keys, HashSet<Character>key_set) {
  for (Character key : keys) {
    key_set.add(key);
  }
}
