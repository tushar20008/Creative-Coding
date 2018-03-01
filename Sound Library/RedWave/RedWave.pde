import processing.sound.*;
SoundFile song;
Amplitude analyzer;
float[] history;
int index = 0;
float n = 0.01;

void setup() {
  size(640, 360);
  song = new SoundFile(this, "music.mp3");
  //song = new SoundFile(this, "vibraphon.aiff");
  song.loop();
  analyzer = new Amplitude(this);
  analyzer.input(song);
  // create an empty array of size equals width
  history = new float[width]; 
}

void draw() {
 
  n += 0.1;
  background(255);
  // update (shift array to the left)
  for (int i=0; i<width-1; i++) 
    history[i] = history[i+1];
  // save current amplitude at the last position
  history[width-1] = analyzer.analyze(); 
  // draw all recorded amplitude values
  for (int i=0; i<width; i++) {
   n += 0.01;
   int alph = int(n * color((255),0,0));  
   stroke(alph); 
   line(i, height/2-history[i]*height, i, height/2+history[i]*height);
  }
}