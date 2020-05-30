class Music implements IMusic{
  
  //float bpm = 92;

  private final Instrument i_cello;
  private final Sheet s_cello;
  private final Player p_cello;
  
  private final Instrument i_voice;
  private final Sheet s_voice;
  private final Player p_voice;
  
  private boolean run_music = false;
  
  public Music(PApplet applet, float bpm, int mode, String musicFileName){
    
    this.i_cello = new Instrument(applet, SoundCipher.CELLO, bpm, false, mode);
    this.i_voice = new Instrument(applet, SoundCipher.VOICE, bpm, true, mode);
    
    this.s_cello = new Sheet(".\\music\\"+ musicFileName + "_base.music");
    this.s_voice = new Sheet(".\\music\\"+ musicFileName + "_voice.music");
    
    this.p_cello = new Player(s_cello, i_cello);
    this.p_voice = new Player(s_voice, i_voice);
    
  }
  
  public void executeBase() {
    boolean hasNext = true;
    do {
      hasNext = p_cello.playNext();
    } while(hasNext && run_music);
    
    run_music = false;

  }
  
  public void executeMelody() {
    boolean hasNext = true;
    do{
      hasNext = p_voice.playNext();
    } while(hasNext && run_music);
    
    run_music = false;
    
  }
  
  public void start_music(int mode) {
    run_music = true;
    
    thread("executeBase");
    thread("executeMelody");
  }
  
  void stop_music() {
    run_music = false;
    s_cello.reset();
    s_voice.reset();
  }
  
  public boolean isRunning(){
    return this.run_music;
  }
 
  public float getCurrentNote(){
    return this.i_voice.getCurrentNote();
  }
  
  public float getCurrentVolume(){
    return this.i_voice.getCurrentVolume();
  }
  
}
