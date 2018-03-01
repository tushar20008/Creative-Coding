// Circle class to manage all the 300 circles
class Circle {
  
  // required variables for each individual circle
  float x, y, nextX, nextY, d, speed, s;

  // Constructor to initialize all the values
  Circle() {
    x = random(width);
    y = random(height);
    nextX = random(width);
    nextY = random(height);
    d = dist(x, y, nextX, nextY);
    speed = random(0.0005, 0.005);
    //size
    s = random(2, 6);
  }
  
  // Assign new target position for the circle
  void update() {
    x = lerp(x, nextX, speed);
    d = dist(x, y, nextX, nextY);
    if (d < 10) {
      nextX = random(width);
      nextY = random(height);
    }
  }
  
  // Update the drawing visually
  void display() {
    stroke(0,191,255);
    fill(0,191,255, d/4);
    ellipse(x, y, s, s);
  }
}