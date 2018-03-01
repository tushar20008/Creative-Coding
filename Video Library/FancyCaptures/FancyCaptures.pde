/*
  Created by : Tushar Anand
  Breif Desciption : Fancy Captures triggered by mouse click  
*/

// Get Video library
import processing.video.*;

// Required Global variables
Capture video;
PImage img;
int counter = 0;                                  // Keeps track of different captures

void setup() {
  size(320, 240);                                // Set Canvas Size
  video = new Capture(this, width, height, 30);  // Initate Capture class
  video.start();
}

void captureEvent(Capture video) {
  video.read();
}

void mousePressed(){                              // Detect mouse click
  counter = (counter+1)%4;                        // Change Capture Style
}

void draw() {
  loadPixels();
  img = video.get();
  
  // Call different functions depending on counter value
  if(counter == 0)                              
    normalCapture();
  else if(counter == 1)
    contrastCapture();
  else if(counter == 2)
    invertCapture();
  else if(counter == 3)
    dominantCapture();   
  
  updatePixels();
}

void normalCapture(){
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      int loc = x + y*video.width;      // Step 1, what is the 1D pixel location
      color p = img.pixels[loc];        // Step 2, what is the color
    
      pixels[loc] = p;                  // Just display normally
        
    }
  }
}

// Performs Contrast Image Streching
void contrastCapture(){
  
  color MP = color(0,0,0);                          // Pixel value for white
  color a = color(255,255,255);                     // Max pixel value in the img
  color b = color(0,0,0);                           // Min pixel value in the img
  
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      int loc = x + y*video.width;    // Step 1, what is the 1D pixel location
      color c = img.pixels[loc];      // Step 2, what is the current color     
       
      // Compare current pixel to get max and min pixel of the img
      if(c>b)                        
        b=c;
      if(c<a)
        a=c;
    }
  }
  
  color R = a-b;                      // Difference between max and min
    
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      int loc = x + y*video.width;      // Step 1, what is the 1D pixel location
      color p = img.pixels[loc];        // Step 2, what is the color
      
      // Apply linear scaling function to get contrast stretching
      p = (p-b)*MP/R;
      pixels[loc] = p;
        
    }
  }
}

// Inverts the colors of each pixel
void invertCapture(){
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      int loc = x + y*video.width;      // Step 1, what is the 1D pixel location
      color p = img.pixels[loc];      // Step 2, what is the color
      
      // Get RGB values of current pixel
      float r = red(p);
      float g = green(p);
      float b = blue(p);
      
      // Invert RGB values
      pixels[loc] = color(255-r,255-g,255-b);
        
    }
  }
}

// Convert each pixel to dominant RGB filter
void dominantCapture(){
  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      int loc = x + y*video.width;     // Step 1, what is the 1D pixel location
      color p = img.pixels[loc];      // Step 2, what is the color
      
      // Get RGB values of current pixel
      float r = red(p);
      float g = green(p);
      float b = blue(p);
      
      // Comapare to get the dominant pixel and display that one
      if(r>=g && r>=b)
        pixels[loc] = color(r,0,0);
      else if(g>=r && g>=b)
         pixels[loc] = color(0,g,0);
      else
         pixels[loc] = color(0,0,b);
  
    }
  }
}