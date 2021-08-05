class Point {
  float mass;
  float damping_ratio;
  float circle_size;
   
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  boolean dragged;
  
  
  Point(float x, float y) {
    mass = 1;
    damping_ratio = 0.998;
    circle_size = circle_extent;
    
    position = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    
    dragged = false;
  }
  
  Point(float x, float y, float circle_size) {
    mass = 1;
    damping_ratio = 0.97;
    this.circle_size = circle_size;
    
    position = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    
    dragged = false;
  }
  
  void update() {
    //addGravity();
    
    //normalize_and_set_mag("acceleration", 2);
    //println("prev position: " + position.x + ", " + position.y);
    //println("acceleration: " + acceleration.x + ", " + acceleration.y);
    
    velocity.add(acceleration);
    
    applyViscousDampingForce();
    
    //normalize_and_set_mag("velocity", 2);
    
    position.add(velocity);
    
    //println("position: " + position.x + ", " + position.y);
    //println();
    
    bounceBackIfNecessary();
    
    acceleration.mult(0); // clear the acceleration at each step
  }
  
  void applyViscousDampingForce() {
    // get the change of acceleration
    velocity.mult(damping_ratio);
  }
  
  void addGravity() {
    PVector gravity = new PVector(0, 0.05);
    applyForce(gravity);
  }
  
  void addSpringForce(PVector spring_force) {
    applyForce(spring_force);
  }
  
  void applyForce(PVector force) {
    force.div(mass);
    acceleration.add(force);
  }
  
  void bounceBackIfNecessary() {
    if (position.x < border_margin) {
      velocity.x = abs(velocity.x);
      //acceleration.x = abs(acceleration.x);
    }
    if (position.y < border_margin) {
      velocity.y = abs(velocity.y);
      //acceleration.y = abs(acceleration.y);
    }
    if (position.x > width-border_margin) {
      velocity.x = -abs(velocity.x);
      //acceleration.x = -abs(acceleration.x);
    }
    if (position.y > height-border_margin) {
      velocity.y = -abs(velocity.y);
      //println("acceleration y: " + acceleration.y);
      //println("velocity.y: " + velocity.y);
      //acceleration.y = -abs(acceleration.y);
    }
  }
    
  void display() {
    circle(position.x, position.y, circle_size);
  }
  
  void detectBeingClicked(int mouse_x, int mouse_y) {
    float distance = dist(mouse_x, mouse_y, position.x, position.y);
    if (distance <= circle_extent) {
      dragged = true;
    }
  }
  
  void moveByDrag(int mouse_x, int mouse_y) {
    if (dragged == true) {
      position.x = mouse_x;
      position.y = mouse_y;
    }
  }
  
  void stopDrag() {
    dragged = false;
  }
  
  void normalize_and_set_mag(String type, float mag) {
    PVector target;
    if (type.equals("acceleration")) {
      target = acceleration;
    } else if (type.equals("velocity")) {
      target = velocity;
    } else {
      println("Invalid type!");
      return;
    }
    target.normalize();
    target.setMag(mag);
  }
}
