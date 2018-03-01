/*
  Created by : Mehr Rajput
  SID : 54717495   
*/

// Get Sound library
import processing.sound.*;

// Required Global variables
SoundFile song;                    // Song file
int size;                          // Size of array
Line[] lines;                      // Store different line data

void setup() {

  // Set Canvas size as full Screen
  fullScreen();
    
  // Get Music file
  song = new SoundFile(this, "music.mp3");
  song.loop();
  
  // Set stroke weight to 3 to increase thickness of lines
  strokeWeight(3);
  
  // Initialize variables
  size = 100;
  lines = new Line[size];
  
  // Iterate through array to create 100 lines and noises
  for (int i=0; i<size; i++) {
    lines[i] = new Line(i);  
  }
  
  // Slower the frame rate for better visual effects
  frameRate(5);
}

void draw() {
  
  // Update background color to remove old traces
  background(0);
  
  // Display all the lines
  for (int i=0; i<size; i++) {
    lines[i].display();
  }
}

// Class to store all data relevant to Line
class Line {
  
  float x, y, noise;
  int index;
  color c;

  // Constructor for the line class
  Line(int index) {
    
    // Assign random x and y position
    x = random(width);
    y = random(height);
    
    // varibale to keep track of index in the array
    this.index = index;
    
    // Initialize noise value for the line
    noise = 0.00005 * index;
    
    // Set either of the 3 colors : Pink / Purple / Blue
    int randomColor = int(random(1,4));
      
    if(randomColor == 1)
      c = color(255,105,180);
    else if(randomColor == 2)
      c = color(160,32,240);
    else
      c = color(0,255,255);
  }
  
  void display() {
    float x2 = noise(noise) * random(width);
    
    // Draw line depending on color and noise
    stroke(c);
    line(x, y, x2*2, y);
   
    // Update x and noise value
    x = x2;
    noise *= 2;
  }
}