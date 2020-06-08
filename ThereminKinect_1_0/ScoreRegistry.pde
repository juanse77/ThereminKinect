public class ScoreRegistry implements Comparable<ScoreRegistry>{
    
    private final int player;
    private final String name;
    private final float score;
    
    public ScoreRegistry(int player, String name, float score){
      this.player = player;
      this.name = name;
      this.score = score;
    }
    
    public int getPlayer() {
      return player;
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
