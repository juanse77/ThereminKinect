
class GameOverPanel {
  
  private final PApplet p;
  private final PGraphics pg;
  private final PShader gameover;
  
  GameOverPanel(PApplet p) {
    this.p = p;
    
    pg = createGraphics(p.width, p.height, P3D);
    pg.beginDraw();
    gameover = pg.loadShader("./data/shader/gameover_wave.glsl");
    gameover.set("resolution", float(p.height)/float(p.width));
    pg.endDraw();
  }
  
  void show(PImage img, float score) {
    pg.beginDraw();
    pg.image(img, 0, 0);
    gameover.set("time", float(millis())/float(1000));
    gameover.set("score", score);
    pg.shader(gameover);
    pg.endDraw();
    p.image(pg, 0, 0);
  }
  
}
