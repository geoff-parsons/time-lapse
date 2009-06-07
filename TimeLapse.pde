import ddf.minim.*;
import processing.video.*;

int secs = 150;

Capture cam;
Minim minim;
AudioSample shutter;
long nextPic = 0;
Date date;
long timestamp;
PFont font;

String fileName() {
  return "SNAP-"+timestamp+".png";
}

long getTime() {
  date = new Date();
  return date.getTime()/1000;
}

void setup() {
  size(800, 600);
  font = loadFont("SansSerif-24.vlw");
  textFont(font);
  
  minim = new Minim(this);
  cam = new Capture(this, width, height, 15);
  shutter = minim.loadSample("data/shutter.wav");
  timestamp = getTime();
  nextPic = timestamp + secs;
}

void draw() {
  
  if(cam.available()) {
    cam.read();
  }
  image(cam, 0, 0);
  timestamp = getTime();
  if( timestamp == nextPic ) {
    shutter.trigger();
    saveFrame(fileName());
    background(255,255,255);
    delay(200);
    nextPic = timestamp + secs;
  } else {
    fill(0);
    rect(8, 7, 60, 25);
    fill(255);
    textAlign(CENTER);
    text( String.valueOf(Math.round(nextPic-timestamp)), 8, 8, 60, 25);
  }
}

void stop() {
  shutter.close();
  minim.stop();
  super.stop();
}

