void initializePoints() {
  points = new ArrayList<Point>();
  for (int i = 0; i < point_cnt; i++) {
    points.add(new Point(random(width), random(height)));
  }
}

void addSpringForTwoPoints(int point_idx_1, int point_idx_2, Spring[][] collection) {
  if (point_idx_1 == point_idx_2) {
    println("Indexes of points should be different!");
    return;
  } else if (0 > point_idx_1 || point_idx_1 >= point_cnt ||
    0 > point_idx_2 || point_idx_2 >= point_cnt) {
    println("At least one index of points is invalid");
    return;
  }
  // make sure that the index of the first point is less than that of the second 
  // to avoid conflict (e.g. the springs for (1, 2) and (2, 1) should be the same)
  if (point_idx_1 > point_idx_2) {
    int tmp = point_idx_1;
    point_idx_1 = point_idx_2;
    point_idx_2 = tmp;
  }
  Point p1 = points.get(point_idx_1);
  Point p2 = points.get(point_idx_2);
    
  collection[point_idx_1][point_idx_2] = new Spring(p1, p2);
}

void addSpringForTwoPoints(int point_idx_1, int point_idx_2, 
 float spring_constant, float rest_length, Spring[][] collection, ArrayList<Point> points) {
  if (point_idx_1 == point_idx_2) {
    println("Indexes of points should be different!");
    return;
  } else if (0 > point_idx_1 || point_idx_1 >= point_cnt ||
    0 > point_idx_2 || point_idx_2 >= point_cnt) {
    println("At least one index of points is invalid");
    return;
  }
  // make sure that the index of the first point is less than that of the second 
  // to avoid conflict (e.g. the springs for (1, 2) and (2, 1) should be the same)
  if (point_idx_1 > point_idx_2) {
    int tmp = point_idx_1;
    point_idx_1 = point_idx_2;
    point_idx_2 = tmp;
  }
  Point p1 = points.get(point_idx_1);
  Point p2 = points.get(point_idx_2);
    
  collection[point_idx_1][point_idx_2] = new Spring(p1, p2, spring_constant, rest_length);
}

float getDist(int i, int j, ArrayList<Point> points) {
  Point p_i = points.get(i);
  Point p_j = points.get(j);
  
  return p_i.position.dist(p_j.position);
}

void applyDrag() {
  for (Point point : points) {
    point.moveByDrag(mouseX, mouseY);
  }
}

void simulateOneStep() {
  updatePoints();
  updateSprings();
}

void updatePoints() {
  updatePointsHelper(frog_points);
  updatePointsHelper(moth_points);
}

void updatePointsHelper(ArrayList<Point> points) {
  for (Point point : points) {
    point.update();
  }
}

void displayPoints(ArrayList<Point> points) {
  for (Point point : points) {
    point.display();
  }
}

void updateSprings() {
  displayOrUpdateSpringsHelper(springs_for_frog, false);
  displayOrUpdateSpringsHelper(springs_for_moth, false);
}

void displaySprings() {
  displayOrUpdateSpringsHelper(springs_for_frog, true);
  displayOrUpdateSpringsHelper(springs_for_moth, true);
}

void displayOrUpdateSpringsHelper(Spring[][] spring_collections, boolean display) {
  for (int i = 0; i < spring_collections.length; i += 1) {
    for (int j = 0; j < spring_collections[0].length; j += 1) {
      if (spring_collections[i][j] != null) {
        if (display == true) {
          spring_collections[i][j].display();
        } else {
          spring_collections[i][j].updateStringRestLength();
          spring_collections[i][j].applySpringForceToBothPoints();
        }
      }
    }
  }
}
