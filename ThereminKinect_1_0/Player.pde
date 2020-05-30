class Player {
  
  private final Sheet sheet;
  private final Instrument instrument;
  
  Player(Sheet sheet, Instrument instrument)
  {
    this.sheet = sheet;
    this.instrument = instrument;
  }
  
  boolean playNext()
  {    
    String[] note = this.sheet.getNext();
    
    if(note == null){
      return false;
    }
        
    boolean dot = note[1].endsWith(".");
    String sym = dot ? note[1].substring(0, note[1].length()-1) : note[1];
    
    float dur = this.instrument.play(note[0].isEmpty() ? new String[0] : note[0].split(" "), sym, dot, Double.parseDouble(note[2]));
    
    this.instrument.waitNote(dur);
    //println(sym, Arrays.toString(note));
    
    return true;
  }
  
}
