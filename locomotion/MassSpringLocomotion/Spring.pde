class Spring {
  Point p1;
  Point p2;
  
  float spring_constant;
  float rest_length;
  
  float frequency;
  float phase;
  float amplitude;
  
  float time_cnt;


  Spring(Point p1, Point p2) {
    this.p1 = p1;
    this.p2 = p2;
    
    spring_constant = 0.1;
    rest_length = 100;
    
    amplitude = rest_length;
    phase = 2 * PI;
    frequency = 1;
    
    time_cnt = 0;
  }

  Spring(Point p1, Point p2, float spring_constant, float rest_length) {
    this.p1 = p1;
    this.p2 = p2;
    
    this.spring_constant = spring_constant;
    this.rest_length = rest_length;
    
    amplitude = rest_length;
    phase = 2 * PI;
    frequency = 1;
    
    time_cnt = 0;
  }
  
  void addSpringForceToPoint1(Point point_1, Point point_2) {
    //println("prev point_1: " + point_1.position.x + ", " + point_1.position.y);
    //println("prev point_2: " + point_2.position.x + ", " + point_2.position.y);
    
    PVector position_diff = PVector.sub(point_1.position, point_2.position);
    
    //println("point_1: " + point_1.position.x + ", " + point_1.position.y);
    //println("point_2: " + point_2.position.x + ", " + point_2.position.y);
    //println("position_diff: " + position_diff.x + ", " + position_diff.y);
    
    float distance = position_diff.mag();
    //println("distance: " + distance);
    
    float displacement = distance - rest_length;
    
    PVector direction = position_diff.normalize();
    PVector spring_force = direction.mult(-1 * spring_constant * displacement);
    
    //println("spring_force: " + spring_force.x + ", " + spring_force.y);
    //println("point_1: " + point_1.position.x + ", " + point_1.position.y);
    //println("point_2: " + point_2.position.x + ", " + point_2.position.y);
    //println();
    
    point_1.addSpringForce(spring_force);
  }
  
  void applySpringForceToBothPoints() {
    addSpringForceToPoint1(p1, p2);
    addSpringForceToPoint1(p2, p1);
  }
  
  void updateStringRestLength() {
    //rest_length = rest_length + amplitude*sin(2*PI*frequency*time_cnt + phase);
    
    //println("amplitude: " + amplitude + " osicllation: " + sin(2*PI*frequency*time_cnt + phase));
    //println("rest length: " + rest_length);
    
    //time_cnt += 0.4;
  }
  
  void display() {
    line(p1.position.x, p1.position.y, p2.position.x, p2.position.y);
  }
}
