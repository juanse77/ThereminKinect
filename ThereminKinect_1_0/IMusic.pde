public interface IMusic{
  
  void start_music(int mode);
  void stop_music();
  
  void executeBase();
  void executeMelody();
  
  boolean isRunning();
  
  float getCurrentNote();
  
}
