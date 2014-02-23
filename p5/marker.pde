public class 3dmarker extends SimplePointMarker {
 
  public 3dmarker(Location location) {
    super(location);
  }
 
  public void draw(PGraphics pg, float x, float y) {
    pg.pushStyle();
    pg.noStroke();
    //pg.line(x, y, 0, x, y, 10);
    pg.popStyle();
  }
}