// Circle Particle to create different patterns
class Particle 
{
  // required variables
  PVector v1, v2;
  
  float direction , additionalDirection, animationSpeed;
  
  int status, counter;
  
  boolean colorNumber;
  
  // Constructor to initialize all the values
  Particle() 
  {
    v1 = new PVector(0,0);
    v2 = new PVector(0,0);
    status = 0;
  }
  
  // Initialize depending on mouse positions
  void startNow(float D, int X, int Y) 
  {
    direction = D;

    float random10 = random(10);
    
    if(random10 < 80)
      status = 15 + int(random(30));
    else if(random10 < 9) 
      status = 45 + int(random(50));
    else 
      status = 100 + int(random(100));
    
    if(random10 < 8) 
      animationSpeed = random(2) + 0.5;
    else 
      animationSpeed = random(2) + 2;

    if(random10 < 8) 
      additionalDirection = 15;
    else 
      additionalDirection = 45;
    
    v1.set(X,Y);
    move();
    direction = D;
    counter = 10;
    
    if(random10 > 5) 
      colorNumber = false;
    else 
      colorNumber = true;
  }
  
  // Make the vector move
  void move() 
  {
    if(random(10) > 5) 
      additionalDirection = -additionalDirection;
    direction += additionalDirection;
    
    v2.set(animationSpeed,0);
    v2.rotate(radians(direction+40));

    counter = 10 + int(random(5));
    if(random(10) > 8) 
      counter += 32;
  }
  
  // Update the drawing visually
  void update() 
  {
    status--;
    
    if(status > 31) {
      v2.rotate(radians(1));
      v2.mult(1f);
    }
    
    v1.add(v2);
    if(!colorNumber) 
      fill(c[0]);
    else 
      fill(c[1]);
      
    pushMatrix();
    translate(v1.x,v1.y);
    rotate(radians(direction));
    rect(0,0,1,15);
    popMatrix();
    
    if(status==0) 
    {
      if(random(10) > 5) 
        fill(c[0]);
      else 
        fill(c[1]);
      
      if(random(10)>8) 
        ellipse(v1.x,v1.y,8,8);
      else
        ellipse(v1.x,v1.y,2,2);
    }
    
    // Make sure it stays inside the drawing area
    if(v1.x < 220 || v1.x + 20 > width || v1.y < 20 || v1.y +20 > height) 
      status = 0;
    
    if(status < 32) 
    {
      counter--;
      if(counter == 0) 
        move();
    }
   } 
}