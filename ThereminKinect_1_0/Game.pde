class Game implements IMusic{
  
  private final Theremin tm;
  private final PApplet applet;
  
  private Music music;
  private int mode;
  private String musicFileName;
  private GameScore gs;
  private String name = "";
    
  public Game(PApplet applet, Theremin tm, String musicFileName){
    this.applet = applet;
    this.tm = tm;
    
    this.mode = Mode.IDLE;
    this.musicFileName = musicFileName;
    
    this.gs = new GameScore(tm);
  }
  
  public void runAutomaticMode(){
    this.mode = Mode.AUTOMATIC;
    music = new Music(applet, 92, mode, musicFileName);
    music.start_music(mode);
  }
  
  public void runGameWithHelpMode(String name){
    this.name = name;
    this.mode = Mode.GAME_WITH_HELP;
    
    gs.startMeasuring();
    
    music = new Music(applet, 92, mode, musicFileName);
    music.start_music(mode);
  }
  
  public void runGameWithoutHelpMode(String name){
    this.name = name;
    this.mode = Mode.GAME_WITHOUT_HELP;

    gs.startMeasuring();    
    
    music = new Music(applet, 92, mode, musicFileName);
    music.start_music(mode);
  }
  
  public void runFree(){
    this.mode = Mode.FREE;
  }
  
  public void drawMarks(){
    if(music.isRunning()){
      tm.drawLineMarks(music.getCurrentNote(), music.getCurrentVolume());
    }else{
      if(mode == Mode.GAME_WITH_HELP || mode == Mode.GAME_WITHOUT_HELP){
        gs.addScoreTable(this.name);
      }
      this.mode = Mode.IDLE;
    }
  }
  
  public void start_music(int mode){
    this.mode = mode;
    music.start_music(mode);
  }
  
  public void stop_music(){
    music.stop_music();
    this.mode = Mode.IDLE;
  }

  public void executeMelody(){
    music.executeMelody();
  }
  
  public void executeBase(){
    music.executeBase();
  }
  
  public boolean isRunning(){
    if(music != null){
      return music.isRunning();
    }else{
      return false;
    }
  }

  public float getCurrentNote(){
    return music.getCurrentNote();
  }
  
  public int getMode(){
    return this.mode;
  }
  
  public void setMusicFileName(String musicFileName){
    this.musicFileName = musicFileName;
  }
  
  public void addPartiaScore(){
    gs.addPartialPoints(music);
  }
  
  public float getScore(){
    return gs.getScore();
  }
  
  public ArrayList<ScoreRegistry> getScoreTable(){
    return gs.getScoreTable();
  }
  
}
