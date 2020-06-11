public interface IMusic{
  
  void start_music(Mode mode);
  void stop_music();
  
  void executeBase();
  void executeMelody();
  
  boolean isRunning();
  
  float getCurrentNote();
  
}
