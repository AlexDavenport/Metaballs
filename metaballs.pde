/**
This code creates moving metaballs with colour changing interactions
This is an extension of Daniel Shiffman's Metaball code
*/

//Creates an array of 5 new Ball objects
Ball[] ballArray = new Ball[5];

/**
Initial variables are created
sat is the saturation
satD is the degrees of satuation of type float
hue is the hue (obviously)
*/
int sat = 255;
float satD = 0;
int hue = 125;
int ballScale = 200;


/**
This method is used to set up the initial screen characteristics
including window size, colour mode (of hue, saturation and brightness),
and a for loop that creates ballArray.length number of Ball objects
at random positions within the confines of the screen size.
*/
void setup() {
  size(600,400);
  colorMode(HSB);
  for (int i=0; i<ballArray.length;i++){
    ballArray[i] = new Ball(random(width),random(height));
  }
}

/**
This method checks for key presses
s changes the amount of saturation and is modulated on a cosine wave
c changes the hue looping around all 255 colours
*/
void pressKey() {
  if (key == 's' && keyPressed == true) {
    satD += 0.05;
  }
  sat = int(255*cos(satD));
  
  if (key == 'c' && keyPressed == true) {
    if (hue < 255){
      hue += 1;
    } else {
      hue = 0;
    }
  }
}

/**
This draw method draws all the pixels to the screen
Pixels are first loaded
A nested for loop is used to locate each pixel in the pixel array
pixelArray is used to locate the required pixel in the 1D array in pixels[]
A further for loop is used to cycle through each Ball in the ballArray
dist is a function based on the distance between the pixel and the centre of the ball
Brightness of the pixels is a function inversley proportional to distanace from every other ball.
sumBrightness sums this together.
The pixels array is then updated according to this.
*/
void draw() {
  loadPixels();
  pressKey();
  for (int x=0; x < width; x++) {
    for (int y=0; y < height; y++) {
      int pixelArray = x + y * width;
      float sumBrightness = 0;
      for(Ball b: ballArray){
        float dist = dist(x,y,b.pos.x,b.pos.y);
        sumBrightness += ballScale*ballArray[0].rad/dist;
      }
      pixels[pixelArray] = color(hue,sat,sumBrightness);
    }
  }
  
  //pixels are updated
  updatePixels();
  
  /**
  A for loop to update all the positioning for the Ball objects
  A conditional is used to check if the original Ball srokes should be shown when the spacebar is held down
  */
  for ( Ball b: ballArray){
    b.updatePositions();
    if (key == ' ' && keyPressed == true) {
      b.showStroke(); 
    }
  }
  

  //Some text to show controls and title
  textSize(20);
  text("Metaballs", 5, 20);
  textSize(14);
  text("Hold \"c\" to change the hue\nHold \"s\" to change the saturation\nHold space to see the original balls", 5, 350);
  fill(0);
}