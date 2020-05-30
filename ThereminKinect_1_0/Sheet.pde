class Sheet {
  
  private String[] sheet;
  private int line;
  
  Sheet(String file) {
    this.sheet = loadStrings(file);
    this.line = 0;
  }
  
  public String[] getNext() {
    
    if(this.line >= this.sheet.length){
      return null;
    }
    
    while(this.sheet[this.line].isEmpty() || this.sheet[this.line].startsWith("#")) { // Ignore empty or comments
      this.line++;
      if(this.line >= this.sheet.length) return null;
    }
    
    String[] note = this.sheet[this.line++].split("\\|");
    
    return note;
  }
  
  public void reset() {
    this.line = 0;
  }
  
}
