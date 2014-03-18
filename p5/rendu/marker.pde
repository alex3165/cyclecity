public class ThreeLinesMaker extends SimpleLinesMarker {
 	
  public float vitesse1;
  public float vitesse2;

  public ThreeLinesMaker(Location startLocation,Location endLocation,float vit1,float vit2) {
    super(startLocation, endLocation);
    this.vitesse1 = vit1;
    this.vitesse2 = vit2;
  }
 
  public void draw(PGraphics pg, List<MapPosition> mapPositions) {
    	MapPosition from = mapPositions.get(0);
		MapPosition to = mapPositions.get(1);
		pg.line(from.x, from.y, this.vitesse1, to.x, to.y, this.vitesse2);
  }
}