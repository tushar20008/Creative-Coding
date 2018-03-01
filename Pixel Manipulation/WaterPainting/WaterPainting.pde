PImage photo; 
color[] scratchPad;
int pixelSize;

void setup(){
  photo = loadImage("img.jpg"); 
  photo.resize(640, 400);
  size(640,400);
  background(photo);
  pixelSize = height*width;
  scratchPad = new color[pixelSize];
  storeImage();  
}

void storeImage(){
  loadPixels();
    for (int i = 0; i < pixelSize; i++) {
      scratchPad[i] = pixels[i];
    }
}

void draw(){
    
    for(int i=0; i<pixelSize; i++)
       pixels[i] = scratchPad[i];
    
    for(int j=0; j<=mouseX; j++)   
    for(int i=j; i< pixelSize; i+=width){
        color c = scratchPad[i + width - 2*(i%width)-1];
  
        float red = red(c);
        red = 255 - red;
        
        float green = green(c);
        green = 255 - green;
        
        float blue = blue(c);
        blue = 255 - blue;

        pixels[i] = color(red,green,blue);
    }
    
    updatePixels();
}