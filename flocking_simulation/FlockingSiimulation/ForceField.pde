class ForceField {
  PVector position;
  ForceField(float x, float y) {
    position = new PVector(x, y);
  }
  
  void attract() {
    ArrayList<Boid> close_boids = getCloseBoids(position.x, position.y, 
                                  force_field_radius);
    for (Boid boid : close_boids) {
      PVector attraction_force = boid.seek(position, max_field_force);
      boid.applyForce(attraction_force);
    }
  }
  
  void repel() { //<>//
    ArrayList<Boid> close_boids = getCloseBoids(position.x, position.y, 
                                  force_field_radius);
    for (Boid boid : close_boids) {
      //PVector attraction_force = boid.seek(negated_position, max_field_force);
      PVector position_difference = PVector.sub(boid.position, position);
      position_difference.normalize();
      position_difference.setMag(max_speed);
      position_difference.limit(max_field_force);
      boid.applyForce(position_difference);
    }
  }
}
