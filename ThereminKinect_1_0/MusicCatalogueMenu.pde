
class MusicCatalogueMenu {
  
  private final String[] cat;
  private final ScrollableList sl;
  
  MusicCatalogueMenu(ControlP5 cp5) {
    cat = new String[catalogue.length];
    
    for(int i = 0; i < catalogue.length; i++) {
      cat[i] = catalogue[i].replace("_", " ");
    }
    this.sl = cp5.addScrollableList("chooseSong")
       .setLabel("Choose song")
       .setPosition(10, 60)
       .setBarHeight(20)
       .setItemHeight(20)
       .addItems(cat)
       .setOpen(false)
       .setValue(musicIndex);
  }
  
  void disable() {
    sl.clear();
    sl.close();
  }
  
  void enable() {
    sl.addItems(cat);
    sl.close();
  }
}

void chooseSong(int n) {
  musicIndex = n;
  game.setMusicFileName(catalogue[musicIndex]);
}
