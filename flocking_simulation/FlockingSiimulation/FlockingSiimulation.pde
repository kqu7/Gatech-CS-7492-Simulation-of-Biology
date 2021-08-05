int boid_cnt;
float shape_radius;

float max_speed;
float max_force;
float max_field_force;

float velocity_matching_weight;
float flock_centering_weight;
float collision_avoidance_weight;
float wandering_weight;

float velocity_matching_radius;
float flock_centering_radius;
float collision_avoidance_radius;
float force_field_radius;

float border_margin;

boolean simulation_on;
boolean attraction_mode;
boolean clear_path;
boolean velocity_matching_on;
boolean flock_centering_on;
boolean collision_avoidance_on;
boolean wandering_on;

ArrayList<Boid> boids;
final float BLUE_VALUE = 100;

void setup() {
  size(700, 700);
  background(0, 0, BLUE_VALUE);
  
  boid_cnt = 16;
  shape_radius = 2;
  
  max_speed = 2;
  max_field_force = 0.5;
  max_force = 0.03;
  
  velocity_matching_weight = 1.0;
  flock_centering_weight = 1.0;
  collision_avoidance_weight = 1.5;
  wandering_weight = 0.05;
  
  velocity_matching_radius = 45;
  flock_centering_radius = 45;
  collision_avoidance_radius = 30;
  force_field_radius = 10;
  
  border_margin = 2;
  
  attraction_mode = true;
  simulation_on = true;
  clear_path = true;
  velocity_matching_on = true;
  flock_centering_on = true;
  collision_avoidance_on = true;
  wandering_on = true;
  
  initializeBoids();
}

void draw() {
  if (clear_path == true) {
    background(0, 0, BLUE_VALUE);
  }
  if (simulation_on == true) {
    if (mousePressed == true) {
      ForceField force_field = new ForceField(mouseX, mouseY);
      if (attraction_mode == true) {
        force_field.attract();
      } else {
        force_field.repel();
      }
    }
    simulateOneStep();
  } else {
    displayBoids();
  }
}

void mousePressed() {
  boids.add(new Boid(mouseX, mouseY));
}

void keyPressed() {
  if (key == 'a') {
    attraction_mode = true;
  } else if (key == 'r') {
    attraction_mode = false;
  } else if (key == 's') {
    initializeBoids();
  } else if (key == 'p') { 
    clear_path = !clear_path;
  } else if (key == 'c') { 
    clear_path = true;
  } else if (key == '1') { 
    flock_centering_on = !flock_centering_on;
    displayForceConditionMessage();
  } else if (key == '2') { 
    velocity_matching_on = !velocity_matching_on;
    displayForceConditionMessage();
  } else if (key == '3') { 
    collision_avoidance_on = !collision_avoidance_on;
    displayForceConditionMessage();
  } else if (key == '4') { 
    wandering_on = !wandering_on;
    displayForceConditionMessage();
  } else if (key == '+' || key == '=') { 
    if (boid_cnt <= 100) {
      boids.add(new Boid(random(width), random(height)));
      boid_cnt += 1;
    }
  } else if (key == '-') { 
    if (boid_cnt > 0) {
      boids.remove(0);
      boid_cnt -= 1;
    }
  } else if (key == ' ') { 
    simulation_on = !simulation_on;
  }
}
