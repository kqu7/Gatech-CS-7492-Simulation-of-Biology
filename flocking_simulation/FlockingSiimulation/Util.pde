void displayForceConditionMessage() {
  println("Flock Centering Force: " + (flock_centering_on ? "ON" : "OFF"));
  println("Velocity Matching Force: " + (velocity_matching_on ? "ON" : "OFF"));
  println("Collision Avoidance Force: " + (collision_avoidance_on ? "ON" : "OFF"));
  println("Wandering Force: " + (wandering_on ? "ON" : "OFF"));
  println();
}

void initializeBoids() {
  boids = new ArrayList<Boid>();
  for (int i = 0; i < boid_cnt; i++) {
    boids.add(new Boid(random(width), random(height)));
  }
}

ArrayList<Boid> getCloseBoids(float source_x, float source_y, float radius) {
  ArrayList<Boid> neighbors = new ArrayList<Boid>();
  for (Boid other : boids) {
    float distance = getDistanceBetweenLocation(source_x, source_y, 
                     other.position.x, other.position.y);
    if (distance > 0 & distance <= radius) {
      neighbors.add(other);
    }
  }
  return neighbors;
}

float getDistanceBetweenLocation(float x_1, float y_1, float x_2, float y_2) {
  return (float) Math.sqrt(Math.pow((x_1 - x_2), 2) + Math.pow((y_1 - y_2), 2));
}

void simulateOneStep() {
  for (Boid boid : boids) {
    boid.move();
  }
}

void displayBoids() {
  for (Boid boid : boids) {
    boid.render();
  }
}
