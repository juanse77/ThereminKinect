class Theremin {

  private final Point toneBottom;
  private final Point toneUp;
  private final Point volumeLeft;
  private final Point volumeRight;
  private final int lengthLineTones = 300;
  private final int lengthLineVolume = 200;
  private final float minTone = 48f; //C3
  private final float maxTone = 84f; //C6
  private float currentTone = 0;
  private float currentVolume = 0;
  private SinOsc sound;
  
  private PApplet p;
  private ThereminModel tm;
  
  public Theremin(PApplet p, Point toneBottom, Point toneUp, Point volumeLeft, Point volumeRight, SinOsc sound){
    
    this.p = p;
    
    this.toneBottom = toneBottom;
    this.toneUp = toneUp;
    
    this.volumeLeft = volumeLeft;
    this.volumeRight =volumeRight;
    
    this.sound = sound;
    
    this.tm = new ThereminModel(8);
    
    sound.set(0, 1.e-4, 0, 0);
    sound.play();
  }
  
  public void drawTheremin(){
    strokeWeight(10);
  
    stroke(0, 255, 0);
    line(toneBottom.x, toneBottom.y, toneUp.x, toneUp.y);

    stroke(255, 0, 0);
    line(volumeLeft.x, volumeLeft.y, volumeRight.x, volumeRight.y);
    
    // theremin model
    ambientLight(255, 255, 255);
    directionalLight(200, 200, 200,
                          -1, 1, -1);
                     
    tm.draw(50+(p.width/2), 180+(p.height/2));
    noLights();
    
  }
  
  private float detectFrec(Point rightHand){
 
    if(rightHand.x > toneBottom.x - lengthLineTones && rightHand.x < toneBottom.x){
      if(rightHand.y < toneBottom.y && rightHand.y > toneUp.y){
        currentTone = maxTone - (toneBottom.x - rightHand.x)/(float)lengthLineTones * (maxTone - minTone);
        return getFrecuency(currentTone);
      }
    }
    
    return 0;
  }
  
  private float detectVolume(Point leftHand){
    
    if(leftHand.y > volumeLeft.y - lengthLineVolume && leftHand.y < volumeLeft.y){
      if(leftHand.x > volumeLeft.x && leftHand.x < volumeRight.x){
        return (volumeLeft.y - leftHand.y)/lengthLineVolume;      
      }
    }
    
    return 1.e-4;
  }
  
  private float getFrecuency(float tone){
    return pow(2, (tone - 69)/12) * 440; //https://www.youtube.com/watch?v=vh_FG71t5Zc&feature=youtu.be
  }
  
  private float getPosX(float tone){

    if(tone >= minTone && tone <= maxTone){
      return toneBottom.x - lengthLineTones + (tone - minTone)/(maxTone - minTone) * lengthLineTones;
    }else{
      return 0;
    }
    
  }
  
  private float getPosY(float volume){
    return volumeLeft.y - lengthLineVolume * volume;
  }
  
  public void makeSound(Point leftHand, Point rightHand){
    float frec = detectFrec(rightHand);

    if(frec != 0){
      
      currentVolume = detectVolume(leftHand);
      sound.set(frec, currentVolume, 0, 0);
    }
  }
  
  public void drawMarks(Point hand){
    ellipse(hand.x, hand.y, 30, 30);
  }
  
  public void drawLineMarks(float tone, float volume){
    
    if(tone == 0) return;
    
    float x = getPosX(tone);
    
    float range = (toneBottom.y - toneUp.y) * 0.2;
    Point bottom = new Point(x, toneBottom.y - range);
    Point up = new Point(x, toneUp.y + range);
    
    stroke(0, 255, 0, 128);
    strokeWeight(8);
    line(bottom.x, bottom.y, up.x, up.y);

    float y = getPosY(volume);
    
    range = (volumeRight.x - volumeLeft.x) * 0.2;
    Point left = new Point(volumeLeft.x + range, y);
    Point right = new Point(volumeRight.x - range, y);
    
    stroke(255, 0, 0, 128);
    strokeWeight(8);
    line(left.x, left.y, right.x, right.y);
    
  }
  
  public void muteTheremin(){
    sound.set(0, 1.e-4, 0, 0);
  }
  
  public float getMinTone(){
    return minTone;
  }
  
  public float getMaxTone(){
    return maxTone;
  }
  
  public float getCurrentTone(){
    return currentTone;
  }
  
  public float getCurrentVolume(){
    return currentVolume;
  }
  
}
