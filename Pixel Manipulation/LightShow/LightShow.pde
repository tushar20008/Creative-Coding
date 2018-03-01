/*
  Created by : Tushar Anand
  Breif Desciption : Lights show with clicked pixel as backgroud  
*/

// Required Global variables
PImage img; 
color[] scratchPad; 
color pickedColor;
int pixelSize, nLights;
boolean startLights;


void setup(){
  
  // Initiate all variables
  img = loadImage("img.jpg"); // Fetch the image
  pixelSize = height*width; 
  scratchPad = new color[pixelSize];
  startLights = false;  // 
  nLights = 1;
  
  img.resize(640, 400); // Resize img
  size(640,400); 
  
  background(img); // Set background as img
  
  storeImage(); 
  
  frameRate(2);  // Change frames per second
  
}

// Function to store all the pixel values of the img
void storeImage(){
  loadPixels();
  for (int i = 0; i < pixelSize; i++) {
    scratchPad[i] = pixels[i];
  }
}

void draw(){
  
  if(startLights){
    
    //Hide the previous lights
    for(int i=0; i<width*height; i++)
        pixels[i] = pickedColor;
    updatePixels();
    
    //Number of lights increases after ever draw()
    for(int i =0; i<nLights; i++){
      
      //Show light at random position
      int x = (int)random(width);
      int y = (int)random(height);
      
      //Show light around the random position  
      for(int j=x-50; j<x+50; j++){
        for(int k=y-50; k<y+50; k++){
          
          // Make sure the position does not go beyound canvas 
          if(j>=width || k >=height || j<0 || k<0)
            continue;
       
          // Get pixel value from the img
          color c = scratchPad[j+k*width];
          
          // Show different kinds of lights
          if(i<nLights/7)
            fill(red(c),green(c),0);
          else if(i<nLights*2/7)
            fill(0,green(c),blue(c));
          else if(i<nLights*3/7)
            fill(red(c),0,blue(c));
          else if(i<nLights*4/7)
            fill(red(c),0,0);
          else if(i<nLights*5/7)
            fill(0,0,blue(c));
          else if(i<nLights*6/7)
            fill(0,green(c),0);
          else if(i<nLights)
            fill(red(c),green(c),blue(c));
            
          noStroke();
          ellipse(j,k,1,1);
        }
      }
    }
    nLights++;  // Increase number of lights gradually
    if(nLights == 50){
      setup();  // Reset after 50 lights
    }
  }
}

// Detect if mouse if pressed
void mousePressed(){
  pickedColor = get(mouseX,mouseY); // Get clicked pixel
  background(pickedColor);
  startLights = true; 
}


// Detect if any key is pressed
void keyPressed() {
  setup();
}
   