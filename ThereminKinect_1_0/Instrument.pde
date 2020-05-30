class Instrument
{
  
  private final SoundCipher sc;
  private final float max_bpm;
  private final MusicConversion mc;
  private float currentNote;
  private float currentVolume;
  private boolean melody;
  private int mode;
  
  /**
   *
   * bmp : beats per minute 1/bpm = crotchet 
   *
   */
  Instrument(PApplet applet, float instrument, float max_bpm, boolean melody, int mode) {
    
    this.sc = new SoundCipher(applet);
    this.sc.instrument = instrument;
    
    this.max_bpm = max_bpm;
    this.mc = new MusicConversion();
    
    this.melody = melody;
    this.mode = mode;
  }
  
  void waitNote(float dur)
  {
    //delay((int)(dur*1000));
    int start = millis();
    while(dur*1000.0 > (float)(millis() - start))
    {}
  }
  
  float play(String[] notes, String symbol, boolean dot, double dynamic)
  {
    float[] pitches = new float[notes.length];
    for(int i = 0; i < notes.length; i++) pitches[i] = this.mc.note2Midi(notes[i]);
    float dur = this.mc.symbol2Time(symbol, max_bpm);
    
    if(dot) dur *= 1.5; 
    
    if(pitches.length > 0) {
      if(!(melody && mode == Mode.GAME_WITHOUT_HELP)){
        this.sc.playChord(pitches, dynamic, dur);
      }
      this.currentNote = pitches[0];
    } else {
      this.sc.playNote(0, 0, dur);
      this.currentNote = 0;
    }

    this.currentVolume = (float)dynamic/100f;
    return dur;   
  }
  
  public float getCurrentNote(){
    return currentNote;
  }
  
  public float getCurrentVolume(){
    return currentVolume;
  }
  
}
