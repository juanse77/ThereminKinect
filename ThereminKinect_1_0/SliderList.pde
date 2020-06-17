


import java.util.Collections;

interface Item extends Comparable<Item> {
  
  public void draw(PGraphics pg, int x, int y);
  
  public int compareTo(Item i);
}

class SliderList extends Controller<SliderList> {
  
  private final PGraphics menu;
  
  private int scrollpos;
  private final int item_height;
  
  private ArrayList<Item> items;
  private color bg, scrollbar_color;
  
  private final String empty_message;
  
  public SliderList(ControlP5 cp5, String name, int w, int h, int item_height, color bg, color scrollbar_color, String empty_message) {
    super(cp5, name, 0, 0, w, h);
    cp5.register(this);
    menu = createGraphics(getWidth(), getHeight());
    
    scrollpos = 0;
    this.item_height = item_height;
    this.bg = bg;
    this.scrollbar_color = scrollbar_color;
    
    items = new ArrayList<Item>();
    
    this.empty_message = empty_message;
    
    setView(new ControllerView<SliderList>() {

      public void display(PGraphics pg, SliderList t ) {
        if(toggleScoreTableFlag) {
          updateList();
          pg.image(menu, 0, 0);
        } else {
          scrollpos = 0;
        }
      }
    });
  }
  
  public void toggleSliderView() {
    toggleScoreTableFlag = !toggleScoreTableFlag;
  }
    
  void updateList() {
    menu.beginDraw();
    menu.pushMatrix();
    
    menu.background(0,0,0,0);
    menu.fill(246, 249, 241);
    menu.rect(0,0,menu.width, menu.height, 10);
    
    
    if(items.isEmpty()) {
      menu.textAlign(CENTER);
      menu.textSize(12);
      menu.fill(0,0,0);
      menu.text(empty_message, menu.width/2, menu.height/2);
    } else {
    
      for(int i = 0; i < items.size(); i++) {
        //menu.text(i + "", 0, (i + npos)*15);
        menu.stroke(0, 0, 0, 0);
        menu.fill(bg);
        menu.rect(0, i + scrollpos, getWidth(), item_height, 10);
        
        items.get(i).draw(menu, 0, i + scrollpos);
        
        menu.translate(0, item_height);
      }
      
    }
    menu.popMatrix();
    
    menu.fill(scrollbar_color);
    float y = map(scrollpos, 0, -(item_height*items.size() - getHeight()), 0, getHeight());
    float r = 10;
    menu.circle(getWidth()-r/2, y, r);
    
    menu.endDraw();
  }
  
  void onScroll(int theAmount) {
    int new_scrollpos = scrollpos - 20 * Integer.signum(theAmount);
    
    if(new_scrollpos > 0) return;
    if(abs(new_scrollpos) + getHeight() > item_height*items.size()) return;
    
    scrollpos = new_scrollpos;
  }
  
  void keyEvent(KeyEvent ev) {
    
    int signo = 0;
    if(ev.getKeyCode() == UP) {
      signo = -1;
    } else if(ev.getKeyCode() == DOWN) {
      signo = +1;
    }
    int new_scrollpos = scrollpos - 20*signo;
    
    if(new_scrollpos > 0) return;
    if(abs(new_scrollpos) + getHeight() > item_height*items.size()) return;
    
    scrollpos = new_scrollpos;
  }
  
  void addItem(Item item) {
    items.add(item);
  }
  
  void removeItem(Item item) {
    items.remove(item);
  }
  
  void clearList() {
    items.clear();
  }
  
  void sortList() {
    Collections.sort(items);
    Collections.reverse(items);
  }
  
}
