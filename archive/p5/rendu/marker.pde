public class ThreeLinesMaker extends SimpleLinesMarker {
 	
  public float vitesse1;
  public float vitesse2;
  public color c = (#ffffff);

  public ThreeLinesMaker(Location startLocation,Location endLocation,float vit1,float vit2) {
    super(startLocation, endLocation);
    this.vitesse1 = vit1;
    this.vitesse2 = vit2;
  }

// @Override
  public void draw(PGraphics pg, List<MapPosition> mapPositions) {
    	if (mapPositions.isEmpty() || isHidden())
      return;

      pg.pushStyle();
      pg.noFill();

      if (isSelected()) {
        pg.stroke(highlightColor);
      } else {
        pg.stroke(c);
      }

      pg.strokeWeight(strokeWeight);
      pg.smooth();

      pg.beginShape(PConstants.LINES);
      MapPosition last = mapPositions.get(0);
      for (int i = 1; i < mapPositions.size(); ++i) {
        MapPosition mp = mapPositions.get(i);
        pg.vertex(last.x, last.y,this.vitesse1);
        pg.vertex(mp.x, mp.y,this.vitesse2);
        last = mp;
      }

      pg.endShape();
      pg.popStyle();
    }

    public void setColor(color col){
      this.c = col;
    }
  }