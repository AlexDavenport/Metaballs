/**
This class Ball creates an object ball with a random starting position, velocity and direction.
*/

class Ball {
  
  /** 
  VARIABLES
  pos is the position of the Ball of type PVector.
  rad is the radius of the Ball of type float.
  vel is the velocity of the Ball of type PVector.
  */
  PVector pos;
  float rad = 40;
  PVector vel;
  
  /** 
  pos is given a start position given the x and y.
  vel is given a random starting direction and speed.
  */
  Ball(float x, float y){
    pos = new PVector(x,y);
    vel = PVector.random2D();
    vel.mult(random(2,5));
  }
  
  /** 
  This method updates the velocities of the ball given the boundaries of the window
  reversing y when the ball exceeds the height or is less than 0
  and reversing x when the ball exceeds the width or is less than 0
  */
  void updatePositions(){
    pos.add(vel);
    if (pos.x > width || pos.x <0){
       vel.x *= -1; 
    }
    if (pos.y > height || pos.y <0){
       vel.y *= -1; 
    }
  }
  
  /** 
  This method displays the stroke of the ball when called
  */
  void showStroke(){
    noFill();
    stroke(0);
    strokeWeight(4);
    ellipse(pos.x,pos.y,rad*2,rad*2);
  }
}