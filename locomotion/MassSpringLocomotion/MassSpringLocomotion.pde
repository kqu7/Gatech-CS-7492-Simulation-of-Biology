float border_margin;
float circle_extent;
int point_cnt;

int moth_cnt = 0; // this is only a temporary variable 

boolean continuous;

ArrayList<Point> points; // this is left with the purpose of debugging
ArrayList<Point> frog_points;
ArrayList<Point> moth_points;

Spring[][] springs_for_frog;
Spring[][] springs_for_moth;

void setup() {
  size(1200, 800);
  background(255, 255, 255);
  
  border_margin = 10;
  point_cnt = 100; // this probably should be deleted afterward
  circle_extent = 5;
  
  continuous = false;
  
  springs_for_frog = new Spring[point_cnt][point_cnt];
  springs_for_moth = new Spring[point_cnt][point_cnt];
  
  initializePoints();
  //points = new ArrayList<Point>();
  
  frog_points = new ArrayList<Point>();
  buildFrog();
  
  moth_points = new ArrayList<Point>();
  buildMoth();
}

void draw() {
  background(255, 255, 255);
  applyDrag(); // move points by dragging
  
  if (continuous == true) {
    // clear the trail left by the moving points
    simulateOneStep();
  }
  displayPoints(frog_points);
  displayPoints(moth_points);
  displaySprings();
}

void keyPressed() {
  if (key == 'a') {
    // this is just a test
    addSpringForTwoPoints(0, 1, springs_for_frog);
  } else if (key == 's') {
    simulateOneStep();
  } else if (key == 'r') {
    // reset
    frog_points = new ArrayList<Point>();
    springs_for_frog = new Spring[point_cnt][point_cnt];
    buildFrog();
    
    moth_points = new ArrayList<Point>();
    springs_for_moth = new Spring[point_cnt][point_cnt];
    buildMoth();
  }
}

void mousePressed() {
  //println("Cnt: " + moth_cnt + " X: " + mouseX + " Y: " + mouseY);
  moth_points.add(new Point(mouseX, mouseY, 5));
  for (Point point : frog_points) {
    point.detectBeingClicked(mouseX, mouseY);
  }
  for (Point point : moth_points) {
    point.detectBeingClicked(mouseX, mouseY);
  }
}

void mouseReleased() {
  for (Point point : frog_points) {
    point.stopDrag();
  }
  for (Point point : moth_points) {
    point.stopDrag();
  }
}
