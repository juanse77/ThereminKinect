import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
import arb.soundcipher.*;
import processing.sound.*;

//import gifAnimation.*;

//GifMaker ficherogif;

PrintWriter output;

Theremin tm;
Game game;

int numPlayer = 0;

Point rightHand;
Point leftHand;

Kinect kinect;
ArrayList <SkeletonData> bodies;

String catalogue [] = {"sweet_dreams", "over_the_rainbow"};
int musicIndex = 0; 
 
String strMode; 
 
void setup()
{
  size(640, 480);
  frameRate(30);
  
  background(0);
    
  //ficherogif = new GifMaker( this, "ThereminKinect.gif");
  //ficherogif.setRepeat(0);
    
  rightHand = new Point(-30, -30);
  leftHand = new Point(-30, -30);
  
  kinect = new Kinect(this);
  bodies = new ArrayList<SkeletonData>();
  
  tm = new Theremin(new Point(600, 360), new Point(600, 60), new Point(60, 360), new Point(160, 360), new SinOsc(this));
  game = new Game(this, tm, catalogue[musicIndex]);
}
 
void draw()
{
  background(0);
  //Pinta las imágenes de entrada, profundidad y máscara
  //image(kinect.GetImage(), 320, 0, 320, 240);
  //image(kinect.GetDepth(), 320, 240, 320, 240);
  //image(kinect.GetMask(), 0, 240, 320, 240);
  //Dibuja esqueletos
  
  image(kinect.GetImage(), 0, 0);
  tm.drawTheremin();
  
  detectBody();
  
  String score = "0.0";
  
  switch(game.getMode()){
     
    case Mode.IDLE:
      strMode = "Idle";
      tm.muteTheremin();
      
      score = String.valueOf(game.getScore());

      break;
      
    case Mode.AUTOMATIC:
      strMode = "Automatic";
      game.drawMarks();    
      
      break;
      
    case Mode.FREE:
      strMode = "Free";
      
      tm.makeSound(leftHand, rightHand);
      
      break;
      
    case Mode.GAME_WITH_HELP:
      strMode = "Game with help";
      
      game.drawMarks();
      game.addPartiaScore();
  
      score = String.valueOf(game.getScore());
      
      tm.makeSound(leftHand, rightHand);
      
      break;
      
    case Mode.GAME_WITHOUT_HELP:
      strMode = "Game without help";
        
      game.drawMarks();
      tm.makeSound(leftHand, rightHand);
      
      break;
  }
  
  textSize(20);
  fill(0, 102, 153);
  text(strMode, 10, 30);
  
  fill(255, 255, 255);
  String musicName = catalogue[musicIndex].replace('_', ' ');
  String s1 = musicName.substring(0, 1).toUpperCase();
  musicName = s1 + musicName.substring(1);
  
  text(musicName, 10, 55);
  
  text("Score: " + score, width/2, 30);
    
  //ficherogif.addFrame();
}

void detectBody(){
  
  for (int i = 0; i < bodies.size(); i++) 
  {
    drawSkeleton(bodies.get(i));
    drawPosition(bodies.get(i));
    
    pushStyle();
    
    fill(255, 0, 0, 128);
    
    if (bodies.get(i).skeletonPositionTrackingState[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT]!=Kinect.NUI_SKELETON_POSITION_NOT_TRACKED)
    {
      rightHand.x = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x * width;
      rightHand.y = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y * height;
      
      ellipse(rightHand.x, rightHand.y, 30, 30);
    }
    
    if (bodies.get(i).skeletonPositionTrackingState[Kinect.NUI_SKELETON_POSITION_HAND_LEFT]!=Kinect.NUI_SKELETON_POSITION_NOT_TRACKED)
    {
      leftHand.x = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_LEFT].x * width;
      leftHand.y = bodies.get(i).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_LEFT].y * height;
      
      ellipse(leftHand.x, leftHand.y, 30, 30);
    }
    
    popStyle();
  
  }
  
}

void drawPosition(SkeletonData _s){
  noStroke();
  fill(0, 100, 255);
  String s1 = str(_s.dwTrackingID);
  text(s1, _s.position.x*width, _s.position.y*height);
}

void drawSkeleton(SkeletonData _s){
  // Cuerpo
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HEAD, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
  Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
  Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SPINE, 
  Kinect.NUI_SKELETON_POSITION_HIP_CENTER);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_CENTER, 
  Kinect.NUI_SKELETON_POSITION_HIP_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_CENTER, 
  Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_LEFT, 
  Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);
 
  // Brazo izquierdo
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT, 
  Kinect.NUI_SKELETON_POSITION_WRIST_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_WRIST_LEFT, 
  Kinect.NUI_SKELETON_POSITION_HAND_LEFT);
 
  // Brazo derecho
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_HAND_RIGHT);
 
  // Pierna izquierda
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_LEFT, 
  Kinect.NUI_SKELETON_POSITION_KNEE_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_KNEE_LEFT, 
  Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT, 
  Kinect.NUI_SKELETON_POSITION_FOOT_LEFT);
 
  // Pierna derecha
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_HIP_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_FOOT_RIGHT);
}

void DrawBone(SkeletonData _s, int _j1, int _j2){
  noFill();
  strokeWeight(4);
  stroke(255, 255, 0);
  //Comprueba validez del dato
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    line(_s.skeletonPositions[_j1].x*width, 
    _s.skeletonPositions[_j1].y*height, 
    _s.skeletonPositions[_j2].x*width, 
    _s.skeletonPositions[_j2].y*height);
  }
}
  
void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
}
 
void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
      }
    }
  }
}
 
void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}

void exit(){
  output = createWriter("Scores.txt");
  ArrayList<ScoreRegistry> scoreTable = game.getScoreTable();
  
  for(int i = 0; i < scoreTable.size(); i++){
    ScoreRegistry sr = scoreTable.get(i);
    output.println(sr.getName() + ":" + sr.getScore());
  }
  
  output.flush();
  output.close();
  
  super.exit();
}

void keyPressed(){
  
  if(key == 'a' || key == 'A'){
        
    if(game.isRunning()){
      game.stop_music();
    }
    
    game.runAutomaticMode();
    
  }
  
  if(key == 'h' || key == 'H'){
    
    if(game.isRunning()){
      game.stop_music();
    }
    
    numPlayer++;
    game.runGameWithHelpMode("Player" + numPlayer);
  }
  
  if(key == 'o' || key == 'O'){
    
    if(game.isRunning()){
      game.stop_music();
    }

    numPlayer++;
    game.runGameWithoutHelpMode("Player" + numPlayer);
    
  }

  
  if(key == 'f' || key == 'F'){
        
    if(game.isRunning()){
      game.stop_music();
    }
    
    game.runFree();
    
  }
  
  if(key == 's' || key == 'S'){
    
    if(game.isRunning()){
      game.stop_music();
    }
    
  }
    
  if(key == 'c' || key == 'C'){
    
    if(!game.isRunning()){
      musicIndex++;
      
      if(musicIndex > catalogue.length -1){
        musicIndex = 0;
      }
      
      game.setMusicFileName(catalogue[musicIndex]);
    }
  }  
  
}

// Threads
void executeBase(){
  game.executeBase();
}

void executeMelody(){
  game.executeMelody();
}
