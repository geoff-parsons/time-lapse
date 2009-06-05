import ddf.minim.*;
import processing.video.*;

int secs = 10;

Capture cam;
Minim minim;
AudioSnippet snap;
int nextPic = 0;

String fileName() {
  return "SMAP-"+year()+month()+day()+hour()+minute()+second()+".png";
}

int secAdd(int time, int addSec) {
  int result = time + addSec;
  if( result < 60 ) {
    return result;
  }
  return result-60;
}

void setup() {
  size(800, 600);
  minim = new Minim(this);
  cam = new Capture(this, width, height, 15);
  snap = minim.loadSnippet("shutter.wav");
  nextPic = secAdd(second(), secs);
}

void draw() {
  if(cam.available()) {
    cam.read();
  }
  image(cam, 0, 0);
  if( second() == nextPic ) {
    snap.play();
    saveFrame(fileName());
    background(255,255,255);
    delay(200);
    nextPic = secAdd(nextPic, secs);
  }
}

