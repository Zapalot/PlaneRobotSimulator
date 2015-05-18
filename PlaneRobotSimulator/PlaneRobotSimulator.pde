
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
  public  void simulateStep() {
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
SimulatedRobot myRobot= new SimulatedRobot();
void setup() {
  myRobot.pose.pos.x=20;
  myRobot.pose.pos.y=20;
  size(500, 500);
}

void draw() {
  background (255, 255, 255);
  myRobot.draw();
}

