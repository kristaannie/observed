import org.openkinect.processing.*;
import processing.video.*;

Kinect2 kinect2;
PImage img;
float minThresh = 480;
float maxThresh = 920;

//change photos
String [] photos = {
 "head_chop600",
 "sword",
 "no_nose",
 "black_eyes",
 "mad_bust600"
};

String currentPhoto;
float timeToNextPhoto = 300;
float photoStart;
int _index;



//change animations
String [] _animations = {
  "circle",
  "rectangle",
  "doubles",
  "text",
  "stars",
  "tiles"
};


String currentAnimation;
float timeToNext = 3000;
float animationStart;
int index;



Bust bust1;
Bust bust2;
Bust bust3;

void setup(){
  size(1200, 800);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
  
//set up photos
  _index = floor(random(0,photos.length));//;
  currentPhoto = photos[index];
  photos[index] = photos[photos.length - 1];
  photos[photos.length - 1] = currentPhoto;
  
  
//set up animations
  index = floor(random(0,_animations.length));//;
  currentAnimation = _animations[index];
  _animations[index] = _animations[_animations.length - 1];
  _animations[_animations.length - 1] = currentAnimation;
  
  
  bust1 = new Bust("black_eyes");
  bust1.w = 300;
  bust1.h = 300;
  bust1.x = 50;
  bust1.y = 200;
  bust1.animation = "rectangle";
  bust1.circleX = 170;
  bust1.circleY = 170;
  bust1.limit = 90;


  bust2 = new Bust("sword");
  bust2.w = 300;
  bust2.h = 300;
  bust2.x = 450;
  bust2.y = 200;
  bust2.animation = currentAnimation;
  bust2.circleX = 170;
  bust2.circleY = 140;
  bust2.limit = 150;
  
  
  bust3 = new Bust("head_chop600");
  bust3.w = 300;
  bust3.h = 300;
  bust3.x = 850;
  bust3.y = 200;
  bust3.animation = currentAnimation;
  bust3.circleX = 150;
  bust3.circleY = 150;
  bust3.limit = 150;
  
// Start animation
  animationStart = millis();
}

void draw(){
background(100);
PImage dImg = kinect2.getDepthImage();
int[] depth = kinect2.getRawDepth();
int record = 4500;
int rx = 0;
int ry = 0;
float avg = 0;
for (int x = 0; x < kinect2.depthWidth; x++) {
   for (int y = 0; y < kinect2.depthHeight; y++) {
     int offset = x + y * kinect2.depthWidth;

     int d = depth[offset];
     avg += d;
    }
 }

avg /= (kinect2.depthWidth * kinect2.depthHeight);
//float w = map(avg, 0, 4500, width, 0);
rect(0, 0, avg, 20);
//image(dImg, 0, 0);

//println(avg);

bust1.display(avg);
bust2.display(avg);
bust3.display(avg);

// if the current time - the start time is greater than timeToNext then we want to change the animation
// Unless someone is in the zone
 if (millis() - animationStart >= timeToNext && avg != maxThresh){
   index = floor(random(0,_animations.length - 1));
   currentAnimation = _animations[index];
   bust1.animation = currentAnimation;
   bust2.animation = currentAnimation;
   bust3.animation = currentAnimation;
   
   
   
   _animations[index] = _animations[_animations.length - 1];
  _animations[_animations.length - 1] = currentAnimation;
   animationStart = millis();
 }
 
 if (millis() - photoStart >= timeToNextPhoto && avg != maxThresh){
     int index1 = floor(random(0,photos.length - 1));
     int index2 = (index1 + 1) % photos.length;
     int index3 = (index2 + 2) % photos.length;
     
     bust1.setImage(photos[index1]);
     bust2.setImage(photos[index2]);
     bust3.setImage(photos[index3]);
 }
 
 




//in the future, replace mouseX with person's position from kinect
//if(w < 100){
//  bust2.animation = "cactus";
//  bust1.animation = "cactus";  
//}
//else{
//  bust2.animation = "rectangle";
//  bust1.animation = "rectangle";
//}

}