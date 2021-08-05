void buildFrog() {
  // these are spring constants for different parts of body
  float head_spring_constant = 0.02;
  float body_spring_constant = 0.003;
  float forearm_spring_constant = 0.001;
  float leg_weak_spring_constant = 0.005;
  float leg_strong_spring_constant = 0.01;
  
  // these are rest length coefficients for different parts of body
  float head_length_coefficient = 1.0;
  float body_length_coefficient = 1.0;
  float forearm_length_coefficient = 1.0;
  float leg_weak_length_coefficient = 0.8;
  float leg_strong_length_coefficient = 1.3;
  
  // build head triangle
  frog_points.add(new Point(200, 150));
  frog_points.add(new Point(175, 175));
  frog_points.add(new Point(225, 175));
  
  addSpringForTwoPoints(0, 1, head_spring_constant, 
    getDist(0, 1, frog_points) * head_length_coefficient, springs_for_frog, frog_points);
  addSpringForTwoPoints(0, 2, head_spring_constant, 
    getDist(0, 2, frog_points) * head_length_coefficient, springs_for_frog, frog_points);
  addSpringForTwoPoints(1, 2, head_spring_constant, 
    getDist(1, 2, frog_points) * head_length_coefficient, springs_for_frog, frog_points);                        
  
  // build body triangle
  frog_points.add(new Point(125, 175));
  frog_points.add(new Point(275, 175));
  frog_points.add(new Point(200, 275));
  
  addSpringForTwoPoints(1, 3, body_spring_constant, 
                        getDist(1, 3, frog_points) * body_length_coefficient, 
                        springs_for_frog, frog_points);
  addSpringForTwoPoints(2, 4, body_spring_constant, 
                        getDist(2, 4, frog_points) * body_length_coefficient, 
                        springs_for_frog, frog_points);  
  addSpringForTwoPoints(3, 5, body_spring_constant, 
                        getDist(3, 5, frog_points) * body_length_coefficient, 
                        springs_for_frog, frog_points);
  addSpringForTwoPoints(4, 5, body_spring_constant, 
                        getDist(4, 5, frog_points) * body_length_coefficient, 
                        springs_for_frog, frog_points);
  
  // build left forearm
  frog_points.add(new Point(115, 185));
  frog_points.add(new Point(105, 175));
  
  addSpringForTwoPoints(3, 6, forearm_spring_constant, 
                        getDist(3, 6, frog_points) * forearm_length_coefficient, 
                        springs_for_frog, frog_points);
  addSpringForTwoPoints(6, 7, forearm_spring_constant, 
                        getDist(6, 7, frog_points) * forearm_length_coefficient, 
                        springs_for_frog, frog_points);

  // build right forearm
  frog_points.add(new Point(285, 185));
  frog_points.add(new Point(295, 175));
  
  addSpringForTwoPoints(4, 8, forearm_spring_constant, 
                        getDist(4, 8, frog_points) * forearm_length_coefficient, 
                        springs_for_frog, frog_points);
  addSpringForTwoPoints(8, 9, forearm_spring_constant, 
                        getDist(8, 9, frog_points) * forearm_length_coefficient, 
                        springs_for_frog, frog_points);
    
  // build left leg
  frog_points.add(new Point(115, 285+30));
  frog_points.add(new Point(125, 295+30));
  frog_points.add(new Point(65, 320+30));

  addSpringForTwoPoints(5, 10, leg_weak_spring_constant, 
                        getDist(5, 10, frog_points) * leg_weak_length_coefficient, 
                        springs_for_frog, frog_points);
  addSpringForTwoPoints(10, 11, 0, 
                        getDist(10, 11, frog_points) * leg_weak_length_coefficient, 
                        springs_for_frog, frog_points);
  addSpringForTwoPoints(11, 12, leg_strong_spring_constant, 
                        getDist(11, 12, frog_points) * leg_strong_length_coefficient, 
                        springs_for_frog, frog_points);
  
  // build right leg
  frog_points.add(new Point(285, 285+30));
  frog_points.add(new Point(275, 295+30));
  frog_points.add(new Point(335, 320+30));
  
  addSpringForTwoPoints(5, 13, leg_weak_spring_constant, 
                        getDist(5, 13, frog_points) * leg_weak_length_coefficient, 
                        springs_for_frog, frog_points);
  addSpringForTwoPoints(13, 14, 0, 
                        getDist(13, 14, frog_points) * leg_weak_length_coefficient, 
                        springs_for_frog, frog_points);
  addSpringForTwoPoints(14, 15, leg_strong_spring_constant, 
                        getDist(14, 15, frog_points) * leg_strong_length_coefficient, 
                        springs_for_frog, frog_points);
}
