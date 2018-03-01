/*
  Created by : Mehr Rajput
  Breif Desciption : Filter the screen by percentage of RGB present in the image  
*/

// Get Video library
import processing.video.*;

// Required Global variables
Capture video;
PImage img;

void setup() {
  // Setup Canvas size
  size(320, 240);
  
  // Initaite Capture class
  video = new Capture(this, width, height, 30);
  video.start();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  loadPixels();
  img = video.get();
  
  // Counter for different RGB colors
  int r = 0, g = 0, b = 0;
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      int loc = x + y*video.width;      // Step 1, what is the 1D pixel location
      color p = img.pixels[loc];      // Step 2, what is the color
    
      // Compare RGB value of the given pixel and find the dominant one
      if(red(p) >= green(p) && red(p) >= blue(p))
        r++;
      else if(green(p) >= red(p) && green(p) >= blue(p))
        g++;
      else
        b++;
    }
  }
  
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      int loc = x + y*video.width;      // Step 1, what is the 1D pixel location
      color p = img.pixels[loc];      // Step 2, what is the color
 
      // Apply appropiate RGB filter according to the RGB counters 
      if(loc <= r)
        pixels[loc] = color(red(p),0,0);
      else if(loc <= r+g)
        pixels[loc] = color(0,green(p),0);
      else
        pixels[loc] = color(0,0,blue(p));
        
    }
  }
  updatePixels();
}