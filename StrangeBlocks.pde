//Strange Blocks
//Andrew Afflitto 2019
//Fractal generator using the Hopalong Attractor algorithm

import processing.pdf.*;

float x = 0.1;
float y = 0.1;

float xx = 0;
float yy = 0;

int intx = 0;
int inty = 0;

float a, b, c, d;

int iterations = 0;

int pdfNum = 0;

void setup() {
  a = random(-3, 3);
  b = random(-3, 3);
  c = random(-0.5, 1.5);
  d = random(-0.5, 1.5);
  
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
float xnew(float x, float y, float a, float b, float c, float d) {
  return sin(y*b)+c*sin(x*b);
}

float ynew(float x, float y, float a, float b, float c, float d) {
  return sin(x*a)+d*sin(y*a);
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
  

  
  println(a, b, c); //Prints the A, B, and C arguements to be passed into Hopalong
  
  x = 0.1;
  y = 0.1;
  
  background(0);
  attractor.loadPixels();
  
  iterations = 0;
  
  colorMode(HSB, 360, 100, 100);
  
  while(iterations < 100000) {
    xx = xnew(x, y, a, b, c, d);
    yy = ynew(x, y, a, b, c, d);
    
    x = xx;
    y = yy;
    
    //Convert X and Y to ints and center them in the frame
    //intx = (int)x + 2000/2;
    //inty = (int)y + 2000/2;
    intx = (int) map(x, -5, 5, 0, 2000);
    inty = (int) map(y, -5, 5, 0, 2000);
    
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
    a = random(-3, 3);
    b = random(-3, 3);
    c = random(-0.5, 1.5);
    d = random(-0.5, 1.5);
    
    translate(width/2, height/2);
    rotate(-PI/4);
    image(attract(), 0, 0, width, width); //run attractor iteration
  } else if(key == 'p') { //Print to PDF
    //endRecord();
    //beginRecord(PDF, "AfflittoAndrew"+(++pdfNum)+".pdf"); //Start new PDF file with incremented name
  } else if(key == 'q' || key == ESC) {
    exit(); 
  } else if(key == 's') {
    save("output/dream/"+(pdfNum++)+".png");
  }
}

void mousePressed(){
  a = random(10);
  b = random(10);
  c = random(10);
  
  translate(width/2, height/2);
  rotate(-PI/4);
  image(attract(), 0, 0, width, width); //run attractor iteration
}