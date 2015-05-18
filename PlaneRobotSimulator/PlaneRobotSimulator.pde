
//holds the position and orientation of a robot in a plane.
class PlaneRobotPose {
  public  PVector pos= new PVector();
  public  float orientation;
};

class SimulatedRobot {
  public  PlaneRobotPose pose = new PlaneRobotPose();
  ; // where is the robor and how is it oriented?

  public  float vForward; // for continous movement (like with a gear motor)
  public  float vAngle;  // for continous movement (like with a gear motor)

  // for continous movement (like with a gear motor)
  public  void simulateStep(float time) {
    turn(vAngle*time);// poor poor euler integration...
    goForward(vForward*time);
  };

  // turn the robot without using speeds. (like with a stepper motor)
  public  void turn(float angle) {
    pose.orientation+=angle;
  }

  // drive the robot forward along its axis without using speeds. (like with a stepper motor)
  public  void goForward(float step) {
    pose.pos.x+=step*cos(pose.orientation);
    pose.pos.y+=step*sin(pose.orientation);
  }

  void draw() {
    pushMatrix(); // save old coordinate transform

    translate(0, width); // move to lower left corner
    scale(1, -1);        // mirror y axis to put the coordinate center to lower left

    translate(pose.pos.x, pose.pos.y); // move to where the robot is
    rotate(pose.orientation);           // rotate so the robot's nose lies in x-direction

      fill(200, 50, 50);  //set fill color
    float halfSize=20; // size of the robot body
    ellipse(0, 0, halfSize, halfSize);  // draw robot body
    line(0, 0, halfSize, 0);// draw robot nose
    popMatrix(); // restore old coordinates
    float windowX=pose.pos.x;
    float windowY=height-pose.pos.y; //mirror y axis to mikick a conventional coordinate system
  }
}

SimulatedRobot stepRobot= new SimulatedRobot();  // a robot moved on discrete steps
SimulatedRobot speedRobot= new SimulatedRobot(); // a robot moving at a certain speed
void setup() {
  stepRobot.pose.pos.x=100;
  stepRobot.pose.pos.y=200;
  
  // this robot will be moved by using the "simulateStep" function
  speedRobot.pose.pos.x=200;
  speedRobot.pose.pos.y=200;
  speedRobot.vAngle=0.01; // radians/second
  speedRobot.vForward=1; // pixels/second
  size(500, 500);
  frameRate(500);
}

void draw() {
  background (255, 255, 255);
  // how to use a "step robot"
  stepRobot.goForward(1);
  stepRobot.turn(0.01);
  stepRobot.draw();
  
  
  // alternative approach: continous movement+integration:
  speedRobot.simulateStep(1); // simulate a 1 second step
  speedRobot.draw();
}

