
import java.util.Map;

static class AvatarIterator {
 
  private static AvatarIterator inst;
  private static PApplet papplet;
  
  private ArrayList<PImage> avatares;
 
  private AvatarIterator() {
    
    File avatar_dir = new File(papplet.sketchPath() + "/data/avatar/");
    avatares = new ArrayList<PImage>();
    
    File[] f = avatar_dir.listFiles();
    for(File file : f) {
      PImage img = papplet.loadImage(file.getPath());
      avatares.add(img);
    }
  } 
 
  static AvatarIterator getInstance(PApplet p) { 
    if (inst == null) {
      papplet = p;
      inst = new AvatarIterator();
    }
    return inst;
  }
 
  PImage getAvatar(int player) {
    /* 1 <= player <= n */
    assert 0 <= player - 1 : "Player <= 0";
    return this.avatares.get((player-1) % avatares.size());
  }
}

class ScoreItem implements Item {
  
  private final String name;
  private final float score;
  private final PFont titleFont, bodyFont;
  private final PImage avatar;
  
  public ScoreItem(String name, float score, PImage avatar) {
    this.name = name;
    this.score = score;
    this.titleFont = createFont("Consolas", 22);
    this.bodyFont = createFont("Consolas", 14);
    this.avatar = avatar;
  }
  
  public void draw(PGraphics pg, int x, int y) {
    pg.fill(46, 0, 20);
    pg.textFont(this.titleFont);
    pg.text(name, x+10, y + 30);
    pg.textFont(this.bodyFont);
    pg.text("Score : " + String.format("%.2f",score), x+10, y+50);
    pg.image(this.avatar, x + 125, y + 5, 70, 70);
  }
  
  public float getScore() {
    return this.score;
  }
  
  @Override
  public int compareTo(Item item) {
    assert item instanceof ScoreItem: "item no es instancia de ScoreItem";
    
    ScoreItem si = (ScoreItem) item;
    
    if(this.score > si.getScore()){
        return 1;
    } else if(this.score < si.getScore()) {
      return -1;
    } else {
      return 0;
    }
  }
}

class ScoreTable {
  
  private SliderList scoreTable;
  
  /**
   dim : width , height, item_height
   pos : x, y
   name : class name
   init : fill score table
  */
  ScoreTable(ControlP5 cp5, PVector dim, PVector pos, String name, ArrayList<ScoreRegistry> init, ArrayList<PImage> avatares) {
    assert avatares.size() == init.size(): "Lista avatares y lista init son de distinto tamaño";
    
    scoreTable = new SliderList(cp5, name, int(dim.x), int(dim.y), int(dim.z), color(176, 202, 135), color(128, 152, 72), "Play a game\n to see your score record");
    scoreTable.setPosition(pos.array());
    for(int i = 0; i < init.size(); i++) {
      scoreTable.addItem(new ScoreItem(init.get(i).getName(),
                                       init.get(i).getScore(),
                                       avatares.get(i)));
    }
    scoreTable.sortList();
  }
  
  ScoreTable(ControlP5 cp5, PVector dim, PVector pos, String name) {
    scoreTable = new SliderList(cp5, name, int(dim.x), int(dim.y), int(dim.z), color(176, 202, 135),
                                                                               color(128, 152, 72), "Play a game\n to see your score record");
    scoreTable.setPosition(pos.array());
  }
  
  void toggleView() {
    scoreTable.toggleSliderView();
  }
  
  void showView(boolean show) {
    scoreTable.showSlider(show);
  }
  
  void addItem(ScoreRegistry sr, PImage avatar) {
    scoreTable.addItem(new ScoreItem(sr.getName(),
                                     sr.getScore(),
                                     avatar));
    scoreTable.sortList();
  }
  
  void setItems(Map<ScoreRegistry, PImage> items) {
    for(Map.Entry<ScoreRegistry, PImage> item : items.entrySet()) {
      ScoreRegistry sr = (ScoreRegistry) item.getKey();
      PImage avatar = (PImage) item.getValue();
      scoreTable.addItem(new ScoreItem(sr.getName(), sr.getScore(), avatar));
    }
    scoreTable.sortList();
  }
  
  void clearTable() {
    scoreTable.clearList();
  }
  
}

boolean toggleScoreTableFlag = false;

class ScoreTableButton {
  
  private final Toggle toggle;
  private final ScoreTable stv;
  
  public ScoreTableButton(ControlP5 cp5, ScoreTable stv, PVector loc, PVector dim) {
    toggle = cp5.addToggle("toggleScoreTableFlag")
                .setPosition(loc.x, loc.y)
                .setSize(int(dim.x), int(dim.y))
                .setMode(ControlP5.SWITCH);
    this.stv = stv;
    Label l = toggle.getCaptionLabel();
    l.getStyle().marginTop = -int(dim.y); //move upwards (relative to button size)
    l.getStyle().marginLeft = int(dim.x); //move to the right
  }
  
  void update() {
    this.stv.showView(toggleScoreTableFlag);
    toggle.setLabel(toggleScoreTableFlag ? "Hide score table": "Show score table");
  }
}
