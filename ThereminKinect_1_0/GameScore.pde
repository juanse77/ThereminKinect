import java.util.Collections;

class GameScore{
  
  private final Theremin tm;
  private float score;
  private final ArrayList<ScoreRegistry> scoreTable;
  
  public GameScore(Theremin tm){
    this.tm = tm;
    this.scoreTable = new ArrayList<ScoreRegistry>();
    this.score = 0.f;
    
    readScoresFile(); 
  }
    
  private void readScoresFile(){
    File f = dataFile("scores.json");
    
    print(f.isFile());
    if(f.isFile()){
    
      JSONArray values = loadJSONArray("data/scores.json");
      
      for (int i = 0; i < values.size(); i++) {  
        JSONObject reg = values.getJSONObject(i); 
    
        String name = reg.getString("name");
        float score = reg.getFloat("score");
    
        scoreTable.add(new ScoreRegistry(name, score));
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
  
  public void addScoreTable(String name){
    scoreTable.add(new ScoreRegistry(name, score));
    Collections.sort(scoreTable);
    Collections.reverse(scoreTable);
  }
  
  public ArrayList<ScoreRegistry> getScoreTable(){
    return scoreTable;
  }
  
}
