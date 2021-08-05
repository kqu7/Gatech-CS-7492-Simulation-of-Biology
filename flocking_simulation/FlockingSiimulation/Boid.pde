class Boid {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float angle;

  Boid(float x, float y) {
    acceleration = new PVector(0, 0);
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));
    position = new PVector(x, y);
  }

  void move() {
    integrateForces();
    updateLocationVelocityAcceleration();
    wrapAround();
    render();
  }

  void integrateForces() {
    if (collision_avoidance_on == true) {
      PVector collision_avoidance_force = getCollisionAvoidanceForce(); 
      collision_avoidance_force.mult(collision_avoidance_weight);
      applyForce(collision_avoidance_force);
    }
    if (velocity_matching_on == true) {
      PVector velocity_matching_force = getVelocityMatchingForce();     
      velocity_matching_force.mult(velocity_matching_weight);
      applyForce(velocity_matching_force);
    }
    if (flock_centering_on == true) {
      PVector flock_centering_force = getFlockCenteringForce();   
      flock_centering_force.mult(flock_centering_weight);
      applyForce(flock_centering_force);
    }
    if (wandering_on == true) {
      PVector wandering_force = getWanderingForce();
      wandering_force.mult(wandering_weight);
      applyForce(wandering_force);
    }
  }

  PVector getCollisionAvoidanceForce() {
    PVector steering_force = new PVector(0, 0);
    ArrayList<Boid> neighbors = getCloseBoids(position.x, position.y, 
                                flock_centering_radius);
    int num_neighbors = neighbors.size();
    
    for (Boid neighbor : neighbors) {
      float separation = PVector.dist(position, neighbor.position);
      PVector position_difference = PVector.sub(position, neighbor.position);
      position_difference.div(separation);
      steering_force.add(position_difference);
    }
    
    if (num_neighbors > 0) {
      steering_force.div(1.0 * num_neighbors);
      steering_force.setMag(max_speed);
      steering_force.sub(velocity);
      steering_force.limit(max_force);
    }
    return steering_force;
  }
  
  PVector getVelocityMatchingForce() {
    PVector steering_force = new PVector(0, 0);
    ArrayList<Boid> neighbors = getCloseBoids(position.x, position.y, 
                                flock_centering_radius);
    int num_neighbors = neighbors.size();
    for (Boid neighbor : neighbors) {
      steering_force.add(neighbor.velocity);
    }
    if (num_neighbors > 0) {
      steering_force.div(num_neighbors * 1.0);
      steering_force.setMag(max_speed);
      steering_force.sub(velocity);
      steering_force.limit(max_force);
    } 
    return steering_force;
  }

  PVector getFlockCenteringForce() {
    PVector neighbor_position_sum = new PVector(0, 0); 
    ArrayList<Boid> neighbors = getCloseBoids(position.x, position.y, 
                                flock_centering_radius);
    int num_neighbors = neighbors.size();
    for (Boid neighbor : neighbors) {
      neighbor_position_sum.add(neighbor.position);
    }
    if (num_neighbors > 0) {
      neighbor_position_sum.div(num_neighbors * 1.0);
      return seek(neighbor_position_sum, max_force);
    }  else {
      return new PVector(0, 0);
    }
  }
  
  PVector getWanderingForce() {
    float angle = random(TWO_PI);
    return new PVector(cos(angle), sin(angle));
  }
  
  void updateLocationVelocityAcceleration() {
    velocity.add(acceleration);
    velocity.limit(max_speed);
    position.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  PVector seek(PVector target, float max_force) {
    PVector location_difference = PVector.sub(target, position); 
    location_difference.setMag(max_speed);
    PVector steer = PVector.sub(location_difference, velocity);
    steer.limit(max_force); 
    return steer;
  }

  void render() {
    float theta = velocity.heading() + radians(90);
    fill(204, 102, 0); // this is the orange color
    stroke(255);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    
    beginShape(TRIANGLES);
    vertex(0, -shape_radius*2);
    vertex(-shape_radius, shape_radius*2);
    vertex(shape_radius, shape_radius*2);
    endShape();
    
    popMatrix();
  }
  
  void wrapAround() {
    if (position.x < -border_margin) position.x = width+border_margin;
    if (position.y < -border_margin) position.y = height+border_margin;
    if (position.x > width+border_margin) position.x = -border_margin;
    if (position.y > height+border_margin) position.y = -border_margin;
  }
}
