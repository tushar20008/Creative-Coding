/*
  Created by : Tushar Anand
  Breif Desciption : Noise Visualization depending on music's amplitude  
*/

// Get Sound library
import processing.sound.*;

// Required Global variables
SoundFile song;          
Amplitude analyzer;
float xstart, xnoise, ystart;
int scale;
int cols, rows;

void setup() {
  
  //Set Canvas Size
  size(300, 300);
  
  // Get Music file
  song = new SoundFile(this, "music.mp3");
  song.loop();
  
  analyzer = new Amplitude(this);
  analyzer.input(song);
  
  xstart = random(15);
  ystart = random(15);
  
  //Divide the canvas into 15 X 15 Grid
  scale = 15;
  cols = width/scale;
  rows = height/scale;
  
  // Slower the frame rate for better visualization
  frameRate(5);
}

void draw() {
  // Update background color to remove previous colors
  background(255);
  
  // Get the current amplitude of the song
  float amp = analyzer.analyze();
  
  // Update variable according to amplitude
  xstart += amp;   
  ystart += amp;  
  
  // Variable to generate the noise
  xnoise = xstart;

  // Variables for end points of line
  float x2 = xstart;
  float y2 = ystart;
  
  // For loops to iterate through through the grid
  for (int y = 0; y <= rows; y+=1) {  
    xnoise = xstart;
    y2 += amp;
    for (int x = 0; x <= cols; x+=1) {  
      xnoise += amp;
      x2 += amp;
      drawLine(x, y, x2, y2, noise(xnoise));
    }
  }
}

// Function to draw a line in each box of the grid
void drawLine(float x, float y, float x2, float y2, float noiseFactor) {
  
  // Get stroke color according to noiseFactor
  int alph = int(noiseFactor * color(0,255,0));    
  stroke(alph);
  
  // Draw line for the box
  line(x*scale,y*scale,x2*scale,y2*scale);
}