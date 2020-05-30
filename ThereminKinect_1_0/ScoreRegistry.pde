public class ScoreRegistry implements Comparable{
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
    public int compareTo(Object o) {
      ScoreRegistry sr = (ThereminKinect_0_3.ScoreRegistry)o;
      
      if(this.score > sr.getScore()){
        return 1;
      }else if(this.score < sr.getScore()){
        return -1;
      }else{
        return 0;
      }
    }
}
