void buildMoth() {  

  // these are spring constants for different parts of body
  float head_spring_constant = 0.00;
  float flexible_wing_constant = 0.1;
  float rigid_wing_constant = 0.1;
  
  // these are rest length coefficients for different parts of body
  float strong_wing_coefficient = 0.95;
  float weak_wing_coefficient = 1.05;
  
  // below is for antenna
  PVector left_antenna_coordinate = new PVector(900, 175);
  PVector right_antenna_coordinate = new PVector(950, 175);
  PVector wing_center_coordinate = new PVector(925, 200);
  
  moth_points.add(new Point(left_antenna_coordinate.x, left_antenna_coordinate.y));
  moth_points.add(new Point(right_antenna_coordinate.x, right_antenna_coordinate.y));
  moth_points.add(new Point(wing_center_coordinate.x, wing_center_coordinate.y));
  
  addSpringForTwoPoints(0, 2, head_spring_constant, 
    getDist(0, 2, moth_points) * weak_wing_coefficient, springs_for_moth, moth_points);
  addSpringForTwoPoints(1, 2, head_spring_constant, 
    getDist(1, 2, moth_points) * weak_wing_coefficient, springs_for_moth, moth_points);
  
  // below is for left wing
  PVector left_wing_front = new PVector(825, 175);
  PVector left_wing_mid = new PVector(850, 225);
  PVector left_wing_last = new PVector(825, 275);
  
  moth_points.add(new Point(left_wing_front.x, left_wing_front.y));
  moth_points.add(new Point(left_wing_mid.x, left_wing_mid.y));
  moth_points.add(new Point(left_wing_last.x, left_wing_last.y));
  
  addSpringForTwoPoints(2, 3, flexible_wing_constant, 
    getDist(2, 3, moth_points) * strong_wing_coefficient, springs_for_moth, moth_points);
  addSpringForTwoPoints(3, 4, rigid_wing_constant, 
    getDist(3, 4, moth_points) * weak_wing_coefficient, springs_for_moth, moth_points);
  addSpringForTwoPoints(4, 5, rigid_wing_constant, 
    getDist(4, 5, moth_points) * weak_wing_coefficient, springs_for_moth, moth_points);
  addSpringForTwoPoints(2, 5, flexible_wing_constant, 
    getDist(2, 5, moth_points) * strong_wing_coefficient, springs_for_moth, moth_points);
  
  // below is for right wing
  PVector right_wing_front = new PVector(1025, 175);
  PVector right_wing_mid = new PVector(1000, 225);
  PVector right_wing_last = new PVector(1025, 275);
  
  moth_points.add(new Point(right_wing_front.x, right_wing_front.y));
  moth_points.add(new Point(right_wing_mid.x, right_wing_mid.y));
  moth_points.add(new Point(right_wing_last.x, right_wing_last.y));
  
  addSpringForTwoPoints(2, 6, flexible_wing_constant, 
    getDist(2, 6, moth_points) * strong_wing_coefficient, springs_for_moth, moth_points);
  addSpringForTwoPoints(6, 7, rigid_wing_constant, 
    getDist(6, 7, moth_points) * weak_wing_coefficient, springs_for_moth, moth_points);
  addSpringForTwoPoints(7, 8, rigid_wing_constant, 
    getDist(7, 8, moth_points) * weak_wing_coefficient, springs_for_moth, moth_points);
  addSpringForTwoPoints(2, 8, flexible_wing_constant, 
    getDist(2, 8, moth_points) * strong_wing_coefficient, springs_for_moth, moth_points);
  
  // Testing Code
  //PVector left_antenna_coordinate = new PVector(900, 175);
  //PVector right_antenna_coordinate = new PVector(950, 175);
  //PVector wing_center_coordinate = new PVector(925, 200);
  
  //moth_points.add(new Point(left_antenna_coordinate.x, left_antenna_coordinate.y));
  //moth_points.add(new Point(right_antenna_coordinate.x, right_antenna_coordinate.y));
  //moth_points.add(new Point(wing_center_coordinate.x, wing_center_coordinate.y));
  
  //addSpringForTwoPoints(0, 2, head_spring_constant, 
  //  getDist(0, 2, moth_points) * head_length_coefficient, springs_for_moth, moth_points);
  //addSpringForTwoPoints(1, 2, head_spring_constant, 
  //  getDist(1, 2, moth_points) * head_length_coefficient, springs_for_moth, moth_points);
  //addSpringForTwoPoints(0, 1, head_spring_constant, 
  //  getDist(0, 1, moth_points) * head_length_coefficient, springs_for_moth, moth_points);
}
