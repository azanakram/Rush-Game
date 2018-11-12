int startTime, timer, screen; //<>// //<>//
boolean playGame = false, instructionScreen = false, gameOverScreen = false;
PImage imgCar, imgArrowKeys, imgArrowUp, imgArrowLeft, imgArrowDown, imgArrowRight;
float carX, car2X, lifePoints, cloudMoveX, cloudTimer;
float [] cloudX, cloudY, cloudSpeeds;
int amountOfClouds = 10, amountOfLives = 5, score = 0;
ArrayList <Integer> inGameKeys;
ArrayList <Integer>arrowKeysDisplayedsPressed;
ArrayList <PImage>arrowKeysDisplayed;
boolean buttonPressed;

void settings() {
  fullScreen();
}
void setup() {
  imgCar = loadImage("spr_classiccar_0.png"); //load car image
  imgArrowKeys = loadImage("arrowKeys.png"); //load arrow keys on instructions
  imgArrowUp = loadImage("arrowUp.png"); //load image of the up arrow key
  imgArrowLeft= loadImage("arrowLeft.png"); //load image of the left arrow key
  imgArrowDown= loadImage("arrowDown.png"); //load image of the down arrow key
  imgArrowRight= loadImage("arrowRight.png"); //load image of the right arrow key

  carX = width;//allows the cars on the intro screen to move
  car2X = 1.5*width; //allows the cars on the intro screen to move
  startTime = 60; //how long the game will be
  cloudMoveX = 0; //clouds don't move at first
  cloudX = new float[amountOfClouds]; //loads a certain number of x values for the code
  cloudY = new float[amountOfClouds]; //loads a certain number of y values for the code
  cloudSpeeds = new float[amountOfClouds]; //loads a certain number for the cloud speeds
  inGameKeys = new ArrayList <Integer>();
  arrowKeysDisplayedsPressed = new ArrayList<Integer>();
  arrowKeysDisplayed = new ArrayList<PImage>();
  arrowKeysDisplayed.add(imgArrowUp); //put arrow pictures in the array
  arrowKeysDisplayed.add(imgArrowLeft);//put arrow pictures in the array
  arrowKeysDisplayed.add(imgArrowDown);//put arrow pictures in the array
  arrowKeysDisplayed.add(imgArrowRight);//put arrow pictures in the array
  imgArrowUp.resize(150, 150);
  imgArrowLeft.resize(150, 150);
  imgArrowDown.resize(150, 150);
  imgArrowRight.resize(150, 150);
  for (int i = 0; i < cloudX.length; i++) {
    cloudX[i] = 0;
    cloudY[i] = random(0, height* 200/768);
    cloudSpeeds[i] = random(0.2, 1); //gives each cloud a random speed
  }
}


void draw() {
  if (screen == 0) {
    introScreen();
  }
  if (screen == 1) {
    instructions();
  }
  if (screen == 2) {
    inGame();
  }
  if (screen == 3) {
    endGame();
  }
}
void introScreen() {
  background(255);
  image (imgCar, carX, 5*height/6); 
  image (imgCar, car2X, 5*height/6); 
  carX -= 5; //moves the cars on the intro screen
  car2X -= 5;
  if (carX < -20) { //limits to how far the car can go before returning to its initial position and moving again
    carX = width;
  }
  if ( car2X < -20) { //limits to how far the car can go before returning to its initial position and moving again
    car2X = width;
  }
  fill(#FF9524);
  rect(0, 0, width, 3*height/4);

  //text
  fill(255);
  rect(width/2.1683, height/13.1333, width/2.15118, height/6.4); //play button
  rect(width/2.1683, height/2.1333, width/2.15118, height/6.4); //instructions button
  fill(0);
  textSize(height/5);
  text("RUSH", width/40, 3*height/7);
  textSize(height/7);
  text("Play", 3*width/5, height/5);
  textSize(height/8);
  text("Instructions", 7*width/15, 3*height/5);
}
void instructions() {
  background(255);
  fill(#FF9524);
  rect(-1, -1, width, height/6); //creates the header
  image(imgArrowKeys, 2*width/5, 2*height/3); //arrow key images
  fill(255);
  textSize(height/20);
  text("Azan Muhammad", 11*width/15, height/7);
  textSize(height/7);
  text("Instructions", width/30, height/7);
  fill(0);
  textSize(width/50);
  text("Press the arrow-keys in the correct order to get to gain 100 points (for each), \n" + //text for instructions screen
    " and get a new pattern of arrows. For each time you press the wrong arrow-key, \n" +
    "you will lose one health point (max health is 5), and 200 points. \n" +
    "Losing all 5 health points, and/or running out of the total 60 seconds \n" +
    "this game will run, will result in a game-over.", width/136.6, height/4);
  fill(#FF2E2E);
  rect(width* 40/1366, height* 619/768, width*150/1366, height* 55/768); //back button
  fill(#6BE865);
  rect(width* 1176/1366, height* 619/768, width*150/1366, height* 55/768); //play button
  fill(0);
  textSize(height/20);
  text("BACK", width* 40/1366, height* 662/768);
  text("PLAY", width* 1176/1366, height* 662/768);
}
void inGame() {
  if (inGameKeys.size() == 0) { 
    makeQuestions(); //generates the random order of the arrow keys to be pressed
  }
  background(#00A2E8);
  backgroundPicture();
  actualGame();

  strokeWeight(1);
  fill(#FF9524);
  rect(0, 0, width/5, height); 
  gameTimer();
  score();
  lifePoints();
}

void makeQuestions() {
  for (int k = 0; k < 5; k++) {
    inGameKeys.add(floor(random(4))); //generates the random order of the arrow keys to be pressed
  }
}
void backgroundPicture() {
  //clouds
  fill(255, 90);
  noStroke();
  for (int i = 0; i < cloudX.length; i++) {
    cloudX[i] += cloudSpeeds[i];
    ellipse(cloudX[i] + width/5- width*105/1366, cloudY[i], width*210/1366, width*119/1366);
    if (cloudX[i] > width ) {
      cloudX[i] = width/20;
    }
  }
  stroke(0);
  //ground
  fill(#743E3E);
  rect(width/6, 19*height/20, width, height);
  //car
  image (imgCar, 3*width/5, 6*height/7);
}
void actualGame() {
  fill(255);
  strokeWeight(15);
  rect(3*width/10, height* 200/768, 3*width/5, height*195/768);
  fill(0);
  stroke(0);

  for (int k = 0; k < inGameKeys.size(); k++) { //assigns the pictures of the arrow keys to their respective int value
    if (inGameKeys.get(k) == 0) {
      image(arrowKeysDisplayed.get(0), 3.25*width/10 + k*150, height*230/768);
    }
    if (inGameKeys.get(k) == 1) {
      image(arrowKeysDisplayed.get(1), 3.25*width/10 + k*150, height*230/768);
    }
    if (inGameKeys.get(k) == 2) {
      image(arrowKeysDisplayed.get(2), 3.25*width/10 + k*150, height*230/768);
    }
    if (inGameKeys.get(k) == 3) {
      image(arrowKeysDisplayed.get(3), 3.25*width/10 + k*150, height*230/768);
    }
  }

  checkAnswers();
}



void checkAnswers() {

  int k =arrowKeysDisplayedsPressed.size() - 1; 
  if (k < 5 && k >= 0) {
    if (inGameKeys.get(k) ==arrowKeysDisplayedsPressed.get(k) && buttonPressed && k < 5) { //if each button pressed is correct and matches
      score = score + 100;

      if (k == 4) {
        arrowKeysDisplayedsPressed.clear(); //clears array
        inGameKeys.clear(); //clears array
        makeQuestions();
      }
      buttonPressed = false;
    } else if (inGameKeys.get(k) !=arrowKeysDisplayedsPressed.get(k) && k < 5) { //if the button pressed is incorrect
      amountOfLives = amountOfLives -1;
      score -= 200;
      arrowKeysDisplayedsPressed.clear();//clears array
      inGameKeys.clear();//clears array
      makeQuestions();
    }
  }
}
void gameTimer() {
  timer = (startTime*60-frameCount)/60; //this is /60 because Processing defaults to 60 frames per second
  textSize(width/27.32);
  fill(0);
  text("TIMER", width/20, height/12.8);
  text(timer, width/20, height/6.4);
  if (timer <= 0) { //if the time goes to zero, show game over screen
    screen = 3;
  }
}
void score() {
  text("Score \n"+score, width/25, height* 304/768); //displays score
}
void lifePoints() {
  text("LIVES", width/20, height*535/768);
  text("" +amountOfLives, width/25, height* 650/768);
  if (amountOfLives <= 0) {
    screen = 3;
  }
}
void endGame() {
  background(0);
  textSize(height/5);
  fill(255, 0, 0);
  text("GAME OVER", 10, height/3);
  fill(255);
  text("Score \n" +score, 10, 2*height/3);
  fill(#467BFF);
  stroke(255);
  textSize(width/25);
  text("Re-run the game to play again", 10, height/10);
  stroke(0);
}
void mousePressed() {
  //intro screen to instructions
  if (screen == 0 && mouseY > height/2.1333 && mouseY < height/1.6 && mouseX > width/2.1683 && mouseX < width/1.07984) { 
    screen = 1;
  }
  if (screen ==1) { //when it is on instructions screen
    //instructions to introscreen
    if (mouseX > width* 40/1366 && mouseX < width * 190/1366 && mouseY > height*619/768 && mouseY < height*674/768 ) {
      screen = 0;
      ;
      //23/1200 86/1200 109/1200
    }
    //instructions to play game
    if (mouseX > width * 1176/1366 && mouseX < width* 1326/1366 && mouseY > height*619/768 && mouseY < height*674/768) {
      screen = 2;
      frameCount = 0;
    }
  }
  //intro to play game
  if (screen == 0 && mouseX > width/2.1683 && mouseX < width/1.07984 && mouseY > height/13.1333 && mouseY < height/4.30307 ) {
    screen = 2;
    frameCount = 0;
  }
}
void keyPressed() { //depending on what key is pressed, it fills array index with with that int value
  if (keyCode == UP) {
    arrowKeysDisplayedsPressed.add(0); 
    buttonPressed = true;
  }
  if (keyCode == LEFT) {
    arrowKeysDisplayedsPressed.add(1);
    buttonPressed = true;
  }
  if (keyCode == DOWN) {
    arrowKeysDisplayedsPressed.add(2);
    buttonPressed = true;
  }
  if (keyCode == RIGHT) {
    arrowKeysDisplayedsPressed.add(3);
    buttonPressed = true;
  }
}