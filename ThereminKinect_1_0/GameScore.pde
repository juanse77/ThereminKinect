import java.util.Collections;

class GameScore{
  
  private final Theremin tm;
  private float score;
  private final ArrayList<ScoreRegistry> scoreTable;
  
  public GameScore(Theremin tm){
    this.tm = tm;
    scoreTable = new ArrayList<ScoreRegistry>();
    readScoresFile(); 
  }
  
  private void readScoresFile(){
    String[] lines = loadStrings("Scores.txt");
    
    if(lines == null) return;
    
    println("there are " + lines.length + " lines");
    
    for (int i = 0 ; i < lines.length; i++) {
      String registry[] = split(lines[i], ':');
      
      if(registry.length != 2){
        print("Loading scores error.");
        exit();
      }
      
      scoreTable.add(new ScoreRegistry(registry[0], Float.parseFloat(registry[1])));
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
    Collections.reverse(scoreTable);
  }
  
  public ArrayList<ScoreRegistry> getScoreTable(){
    return scoreTable;
  }
  
}
