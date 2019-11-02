//Strange Blocks
//Andrew Afflitto 2019
//Fractal generator using the Gumowski-Mira Attractor algorithm

import processing.pdf.*;

float x = random(-20, 20);
float y = random(-20, 20);

float xx = 0;
float yy = 0;

int intx = 0;
int inty = 0;

float a, b;

float t, w;

int iterations = 0;

int pdfNum = 0;

void setup() {
  a = random(-1, 1);
  b = random(-1, 1);
  
  fullScreen();
  
  imageMode(CENTER);
  
  translate(width/2, height/2);
  rotate(-PI/4);
  image(attract(), 0, 0, width, width); //run attractor iteration
}

void draw() {
  //translate(width/2, height/2);
  //rotate(-PI/4);
  //image(attract(), 0, 0, width, width); //run attractor iteration
}

//Hopalong Attractor
//float xnew(float x, float y, float a, float b) {
//  return y - 1 - sqrt(abs(b*x - 1 - c))*sign(x-1);  
//}

//float ynew(float x, float y, float a, float b) {
//  return a - x - 1; 
//}

float tnew(float x) {
  return x;
}

float wnew(float x, float a) {
  return a*x+(1-a)*2*x*x/(1+x*x);
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
  PImage attractor = new PImage(2000, 2000);
  

  
  println(a, b); //Prints the A, B, and C arguements to be passed into Hopalong
  
  x = random(-20, 20);
  y = random(-20, 20);
  
  background(0);
  attractor.loadPixels();
  
  iterations = 0;
  
  colorMode(HSB, 360, 100, 100);
  
  while(iterations < 100000) {
    t = x;
    w = wnew(x, a);
    
    xx = b * y + w;
    yy = w - t;
    
    x = xx;
    y = yy;
    
    //Convert X and Y to ints and center them in the frame
    intx = (int)map(x, -50, 50, 0, 2000/2);
    inty = (int)map(y, -50, 50, 0, 2000/2);
    
    //Write to the PImage
    if(intx >= 0 && inty >= 0 && intx < 2000 & inty < 2000) {
      attractor.pixels[inty*2000 + intx] = color(((int)(iterations / 100000.0 * 360)), 75, 100);
    }
    
    iterations++;
  }  
  
  println("done!");
  
  attractor.updatePixels();
  
  return attractor;
}

void keyPressed() {
  if(key == 'r' || key == ' ') { //reset program
    a = random(-1, 1);
    b = random(-1, 1);
    
    translate(width/2, height/2);
    rotate(-PI/4);
    image(attract(), 0, 0, width, width); //run attractor iteration
  } else if(key == 'p') { //Print to PDF
    //endRecord();
    //beginRecord(PDF, "AfflittoAndrew"+(++pdfNum)+".pdf"); //Start new PDF file with incremented name
  } else if(key == 'q' || key == ESC) {
    exit(); 
  } else if(key == 's') {
    save("output/"+(pdfNum++)+".png");
  }
}

void mousePressed(){
  a = random(-1, 1);
  b = random(-1, 1);
  
  translate(width/2, height/2);
  rotate(-PI/4);
  image(attract(), 0, 0, width, width); //run attractor iteration
}