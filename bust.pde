class Bust {
 int x, y;
 int w, h;
 int limit;
 PImage image;
 PFont myfont;
 PImage _blend;
 PImage[] doubles;
 float move;
 String animation;
 int _map;
 int _random;
 float _slide;
 int maxThresh;
 int minThresh;
 
 int circleX, circleY;

 //Constructor
 Bust(String imageName) {
   setImage(imageName);
   myfont = createFont("Roboto-Black-120", 120);
   move = 0;
   x = width/2;
   y = height/2;
   
 }
 
 void setImage(String imageName){
   image = loadImage(imageName + ".png");
 }

 void display(float avg) {
   tint(145, 207, 168);
   imageMode(CORNER);
   image(image, x, y, w, h);
   noStroke();
   maxThresh = 1840;
   minThresh = 1440;
   float _w = constrain(avg, minThresh, maxThresh);
   
   if(animation == "circle"){
       _w = map(_w, minThresh, maxThresh, 200, 0);
       
       //fill(59, 54, 54);
       fill(229, 94, 71);
       ellipse(x + circleX, y + circleY, _w, _w);
    }
    else if(animation == "rectangle"){
      pushMatrix();
      translate(x,y);
       float rectY = map(_w, minThresh, maxThresh, limit, h);
       float rectH = map(_w, minThresh, maxThresh, h-limit, 0);
       //UPDATE RECT
       //move = move + .5;
       //if (move > limit) {
       //  move = limit;
       //}
       //DRAW RECT
       fill(90, 150, 176, 230);
       
       rect(0, rectY, 300, rectH);
       fill(255,0,0);
       popMatrix();
       
       
      }
    else if(animation == "doubles"){
       _w = Math.round(map(avg, minThresh, maxThresh, 40, 0));
       if (_w > 20) {
         _w = 20;
        }
       fill(145, 207, 168, 150);
       rect(x,y,h,w);
       blend(image, 0, 0, 600, 600, parseInt(x + _w), y, 300, 300, LIGHTEST);
       blend(image, 0, 0, 600, 600, x,  parseInt(y + _w), 300, 300, LIGHTEST);
       blend(image, 0, 0, 600, 600, parseInt(x + _w * -1), y, 300, 300, LIGHTEST);
      }
     //else if(animation == "cactus") {
     //  //_random = Math.round(random(0,10));
     //  blend(_blend, 0, 0, 600, 600, x, y, 300, 300, MULTIPLY); 
     // }
     else if(animation == "text") {
       for (int i = 0; i<100; i+=20){
         for(int j = 0; j<100; j+=10){
            _w = map(_w, minThresh, maxThresh, 0, 50);
           float _x = map(avg, minThresh, maxThresh, 255, 0);
           _random = Math.round(random(0,50));
           fill(208, 236, 244, _x);
           textSize(15);
           text("hahaha, sorry", x + 100 + i + _random, y + 100 + j);
          }
         }  
      }
      else if(animation == "stars") {
        _w = map(_w, minThresh, maxThresh, 1055, 0);
        fill(0, _w);
        //rect(x, y, w, h);
        fill(136, 193, _w);
        for(int i = 0; i < _w; i++){
          ellipse(x + random(0,300), y + random(0,300), 2, 2);
        } 
      }
      else if(animation == "tiles") {
        _w = map(_w, minThresh, maxThresh, PI, 0);
        for (int i = 0; i < 300; i+=10) {
          for (int j = 0; j < 300; j+=10) {
              PImage chunk = image.get(i*2, j*2, 20, 20);
              pushMatrix();
              translate(x+i, y+j);
              rotate(_w);
              imageMode(CENTER);
              //tint(255,100);
              image(chunk, 0, 0, 10, 10);
              popMatrix();

          }   
         }
    }
  }
   
}
   