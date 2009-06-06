import ddf.minim.*;
import processing.video.*;

int secs = 10;

Capture cam;
Minim minim;
AudioSample shutter;
long nextPic = 0;
Date date;
long timestamp;

String fileName() {
  return "SMAP-"+timestamp+".png";
}

long getTime() {
  date = new Date();
  return date.getTime()/1000;
}

void setup() {
  size(800, 600);
  minim = new Minim(this);
  cam = new Capture(this, width, height, 15);
  shutter = minim.loadSample("shutter.wav");
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
  }
}

void stop() {
  shutter.close();
  minim.stop();
  super.stop();
}

