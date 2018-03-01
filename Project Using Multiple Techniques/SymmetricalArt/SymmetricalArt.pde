/*
  Created by : Tushar Anand & Mehr Rajput
  Brief Desciption : Interactive Symmetrical Art Game  
*/

// Get Sound library
import processing.sound.*;

// Required Global variables
SoundFile song;
int size, pageNumber, symmetry, colorCounter, circleNum, fileNumber = 0;
boolean setupDone;
color[] c, colors;
int[] undo, redo;

// Objects for the created Classes
Particle[] particles;
Circle[] circles;

void setup() {
  
  // Set Canvas Size
  size(900,600);
  
  song = new SoundFile(this, "song.mp3");
  song.loop();
  
  // Initialize all global variables
  size = 50;
  pageNumber = 1;
  setupDone = false;
  
  particles=new Particle[size];
    for(int i=0; i<size; i++) particles[i]=new Particle();
  
  circleNum = 300;
  circles = new Circle[circleNum];
  for (int i=0; i<circleNum; i++)
    circles[i] = new Circle();
}

void draw()
{
   // Show page according to the number
   if(pageNumber == 1)
     homepage();
   else
     drawingPage();
}

// Create the layout for the homepage
void homepage()
{
  background(40,40,40);
  PImage logo, heading, start;
  
  heading = loadImage("homepage_about.png");
  image(heading,60,-300);
  
  logo = loadImage("homepage_logo.png");
  image(logo,75,-60);
  
  start = loadImage("homepage_start button.png");
  image(start,30,150);
  
  for (int i=0; i<circleNum; i++) {
    circles[i].update();
    circles[i].display();
  }
}

void drawingPage()
{
  // Create layout for drawing page
  if(!setupDone)
  {
    background(40,40,40);
    setupDone = true;
    
    symmetry = 1;
    colorCounter = 0;
    
    undo = new int[height*width];
    redo = new int[height*width];
    saveUndo();
    
    // All the different color options in the toolBox
    colors = new color[8];
    colors[0] = color(255,0,0);
    colors[1] = color(255,0,128);
    colors[2] = color(0,191,255);
    colors[3] = color(148,0,211);
    colors[4] = color(0,255,0);
    colors[5] = color(253,184,19);
    colors[6] = color(207,83,0);
    colors[7] = color(153,153,153);
    
    c = new color[2];
    c[0] = color(255,0,0);
    c[1] = color(0,191,255);
 
  }
  
  //Load Tool Box
  PImage heading, toolBox;
    
  heading = loadImage("toolbar_heading.png");
  image(heading,-80,-90);
    
  toolBox = loadImage("toolbar.png");
  image(toolBox,-140,50, 450, 550);
  
  noStroke();
  drawingActions();
}

// Create different patterns
void drawingActions()
{
  if(mousePressed)
  {
    if(mouseX < 220)
      return;
    if(symmetry == 1)
      drawAt(mouseX,mouseY);
    else if(symmetry == 2)
    {
      drawAt(mouseX,mouseY);
      drawAt(width-mouseX,height-mouseY);
    }
    else if(symmetry == 3)
    {
  
      int x = int(map(mouseY, 0, height, 0, width));
      int y = int(map(mouseX, 0, width, 0, height));
      drawAt(mouseX,mouseY);
      drawAt(width-mouseX,height-mouseY);
      drawAt(x, y);
      
    }
    else if(symmetry == 4)
    {
      drawAt(mouseX,mouseY);
      drawAt(width-mouseX,height-mouseY);
      drawAt(width-mouseX,mouseY);
      drawAt(mouseX,height-mouseY);
    }
    else if(symmetry == 5)
    {
      int x = int(map(mouseX, 0, width, mouseX, width - mouseX));
      int y = int(map(mouseY, 0, height, mouseY, height - mouseY));
      drawAt(mouseX,mouseY);
      drawAt(width-mouseX,height-mouseY);
      drawAt(x, y); 
      drawAt(width-mouseX,mouseY);
      drawAt(mouseX,height-mouseY);
    }
    else if(symmetry == 6)
    {
      int x = int(map(mouseX, 0, width, mouseX, width - mouseX));
      int y = int(map(mouseY, 0, height, mouseY, height - mouseY));
      drawAt(mouseX,mouseY);
      drawAt(width-mouseX,height-mouseY);
      drawAt(x, y);
      
      x = int(map(mouseX, 0, width, width- mouseX, mouseX));
      y = int(map(mouseY, 0, height, height - mouseY, mouseY));
      drawAt(x,y);
      drawAt(width-mouseX,mouseY);
      drawAt(mouseX,height-mouseY);
    }
  }
}

void drawAt(int X, int Y)
{

  float dir=int(random(36))*10;
  
  int i=0;
  while(i<size) {
    if(particles[i].status<1) {
      particles[i].startNow(dir, X, Y);
      break;
    }
    i++;
  }
    
  for(i=0; i<size; i++) 
    if(particles[i].status>0) particles[i].update(); 
}

// Change colors
void changeColor(int index)
{
  c[colorCounter++] = colors[index];
  colorCounter %=2; 
}

void saveUndo()
{
  loadPixels();
  for (int i = 0; i < width*height; i++) {
      undo[i] = pixels[i];
  }
  updatePixels();
}    
  
void undo()
{
  loadPixels();
  boolean same = true;
  for (int i = 0; i < width*height; i++) {
    if( pixels[i] != undo[i])
      same = false;
  }
  
  if(same)
    return;
  
  for (int i = 0; i < width*height; i++) {
    redo[i] = pixels[i];
    pixels[i] = undo[i];
  }
  updatePixels();
}

void redo()
{
  loadPixels();
  boolean same = true;
  for (int i = 0; i < width*height; i++) {
    if( pixels[i] != redo[i])
      same = false;
  }
  
  if(same)
    return;
    
  for (int i = 0; i < width*height; i++) {
    undo[i] = pixels[i];
    pixels[i] = redo[i];
  }
  updatePixels();
}

void saveImage()
{
  PImage partialSave = get(200,10,900,600);
  partialSave.save("createdArt/SymmetricalArt-"+fileNumber+".png");
  fileNumber++;
}

void mouseClicked()
{
  if(pageNumber == 1)
  {
    // When Start Button is clicked
    if(overButton(330,500,170,50))
      pageNumber = 2;
  }
  else if(pageNumber == 2)
  {
    
    // Check for different color buttons
    if(overButton(39,76,50,50))
      changeColor(0);
    else if(overButton(104,76,50,50))
      changeColor(1);
    else if(overButton(39,136,50,50))
      changeColor(2);
    else if(overButton(104,136,50,50))
      changeColor(3);
    else if(overButton(39,196,50,50))
      changeColor(4);
    else if(overButton(104,196,50,50))
      changeColor(5);
    else if(overButton(39,256,50,50))
      changeColor(6);
    else if(overButton(104,256,50,50))
      changeColor(7);
    // Check for different symmetry buttons
    else if(overButton(32,388,15,20))
      symmetry = 1;
    else if(overButton(75,388,15,20))
      symmetry = 2;
    else if(overButton(115,388,15,20))
      symmetry = 3;
    else if(overButton(55,418,15,20))
      symmetry = 4;
    else if(overButton(98,418,15,20))
      symmetry = 5;
    else if(overButton(138,418,15,20))
      symmetry = 6;
    // Check for New, Undo, Redo and Save
    else if(overButton(30,450,130,35))
      setup();
    else if(overButton(30,490,130,35))
      undo();
   else if(overButton(30,530,130,25))
      redo();
   else if(overButton(30,560,130,30))
      saveImage();
   else 
     saveUndo();
  }
}

// Find out if the clicked position is inside the rectangle
boolean overButton(int x, int y, int width, int height)  
{
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height)
    return true;
  else
    return false;
}