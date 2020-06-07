import java.util.Collections;

class GameScore{
  
  private final Theremin tm;
  private float score;
  private final ArrayList<ScoreRegistry> scoreTable;
  
  private final ScoreTable scoreTableView;
  
  private final PApplet applet;
  
  public GameScore(PApplet applet, Theremin tm, ScoreTable st){
    this.applet = applet;
    
    this.tm = tm;
    this.scoreTable = new ArrayList<ScoreRegistry>();
    this.score = 0.f;
    
    readScoresFile();
    
    this.scoreTableView = st;
    Map<ScoreRegistry, PImage> items = new HashMap<ScoreRegistry, PImage>(); 
    for(ScoreRegistry sr: scoreTable) {
      items.put(sr, AvatarIterator.getInstance(this.applet).getAvatar(sr.getPlayer()));
    }
    this.scoreTableView.setItems(items);
  }
    
  private void readScoresFile(){
    File f = dataFile("scores.json");
    
    print(f.isFile());
    if(f.isFile()){
    
      JSONArray values = loadJSONArray("data/scores.json");
      
      for (int i = 0; i < values.size(); i++) {  
        JSONObject reg = values.getJSONObject(i); 
      
        int player = reg.getInt("player");
        String name = reg.getString("name");
        float score = reg.getFloat("score");
    
        scoreTable.add(new ScoreRegistry(player, name, score));
      }
      
    }
    
  }
  
  public void startMeasuring(){
    score = 0;
  }
  
  public void addPartialPoints(Music ms){
    float expectedTone = ms.getCurrentNote();
    float expectedVolume = ms.getCurrentVolume();
    
    if(expectedTone == 0){
      return;
    }
    
    float tmTone = tm.getCurrentTone();
    float tmVolume = tm.getCurrentVolume();
    
    
    if(abs(tmTone - expectedTone) < 1.5){
      score += 0.25f;
    
      if(abs(tmVolume - expectedVolume) < 0.2){
        score += 0.25f;
      }
  
    }
    
  }
  
  public float getScore(){
    return score;
  }
  
  public void addScoreTable(int player, String name){
    ScoreRegistry sr = new ScoreRegistry(player, name, score);
    scoreTable.add(sr);
    Collections.sort(scoreTable);
    Collections.reverse(scoreTable);
    
    scoreTableView.addItem(sr, AvatarIterator.getInstance(applet).getAvatar(player));
  }
  
  public ArrayList<ScoreRegistry> getScoreTable(){
    return scoreTable;
  }
  
}
