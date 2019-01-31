import processing.pdf.*;

float x = 0;
float y = 0;

float xx = 0;
float yy = 0;

int intx = 0;
int inty = 0;

float a, b, c;

int iterations = 0;

int pdfNum = 0;

void setup() {
  a = random(10);
  b = random(10);
  c = random(10);
  
  size(225, 225);
  
  beginRecord(PDF, "AfflittoAndrew0.pdf");
  image(attract(), 0, 0); //run attractor iteration
  //endRecord();
}

void draw() {
  //do nothing
}

float xnew(float x, float y, float a, float b, float c) {
  return y - 1 - sqrt(abs(b*x - 1 - c))*sign(x-1);  
}

float ynew(float x, float y, float a, float b, float c) {
  return a - x - 1; 
}

int sign(float x) {
  if(x > 0) {
    return 1;
  } else if(x < 0) {
    return -1;
  } else {
    return 0;
  }
}

PImage attract() {
  
  PImage attractor = new PImage(225, 225);
  
  a = random(10);
  b = random(10);
  c = random(10);
  
  println(a, b, c);
  
  x = 0;
  y = 0;
  
  background(0);
  attractor.loadPixels();
  
  iterations = 0;
  
  while(iterations < 100000) {
    xx = xnew(x, y, a, b, c);
    yy = ynew(x, y, a, b, c);
    
    x = xx;
    y = yy;
    
    //intx = (int) map(x, -1E1, 1E1, 0, 225);
    //inty = (int) map(y, -1E1, 1E1, 0, 225);
    intx = (int)x + width/2;
    inty = (int)y + height/2;
    
        
    if(intx >= 0 && inty >= 0 && intx < 225 & inty < 225) {
      attractor.pixels[inty*width + intx] = color(255);
    }
    
    iterations++;
  }  
  
  println("done!");
  
  attractor.updatePixels();
  
  return attractor;
}

void keyPressed() {
  if(key == 'r') { //reset
    image(attract(), 0, 0);
  } else if(key == 'p') {
    endRecord();
    beginRecord(PDF, "AfflittoAndrew"+(++pdfNum)+".pdf");
  }
}
