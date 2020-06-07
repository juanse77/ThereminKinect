class ThereminModel {
  
  private final PShape theremin;
  
  ThereminModel(float scale) {
    theremin = loadShape("./data/theremin_obj/theremin_simplificado_inv.obj");
    theremin.scale(scale);
  }
  
  void draw(float x, float y) {
    
    pushMatrix();
    
    ortho();
    translate(x, y, 200);
    
    rotateZ(PI);
    rotateY(PI);
    
    shape(theremin);
    
    popMatrix();
    
  }
  
}
