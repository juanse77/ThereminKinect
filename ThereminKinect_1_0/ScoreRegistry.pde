public class ScoreRegistry implements Comparable<ScoreRegistry>{
    private final String name;
    private final float score;
    
    public ScoreRegistry(String name, float score){
      this.name = name;
      this.score = score;
    }
    
    public String getName() {
        return name;
    }
    
    public float getScore() {
        return score;
    }

    @Override
    public int compareTo(ScoreRegistry sr) {
      
      if(this.score > sr.getScore()){
        return 1;
      }else if(this.score < sr.getScore()){
        return -1;
      }else{
        return 0;
      }
    }
}
