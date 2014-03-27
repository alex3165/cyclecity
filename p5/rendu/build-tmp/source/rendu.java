import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import de.fhpotsdam.unfolding.*; 
import de.fhpotsdam.unfolding.providers.*; 
import de.fhpotsdam.unfolding.geo.*; 
import de.fhpotsdam.unfolding.utils.*; 
import de.fhpotsdam.unfolding.marker.*; 
import processing.net.*; 
import http.requests.*; 
import java.util.*; 

import org.apache.http.*; 
import org.apache.http.impl.io.*; 
import org.apache.http.client.cache.*; 
import org.apache.http.client.params.*; 
import org.apache.http.impl.client.cache.ehcache.*; 
import org.apache.commons.codec.language.*; 
import org.apache.http.impl.client.*; 
import org.apache.http.annotation.*; 
import org.apache.http.client.protocol.*; 
import org.apache.http.util.*; 
import org.apache.http.impl.auth.*; 
import org.apache.http.client.methods.*; 
import org.apache.http.protocol.*; 
import org.apache.http.cookie.params.*; 
import org.apache.http.entity.*; 
import org.apache.http.auth.*; 
import org.apache.http.client.fluent.*; 
import org.apache.commons.codec.*; 
import org.apache.commons.codec.digest.*; 
import org.apache.http.client.entity.*; 
import org.apache.http.conn.socket.*; 
import org.apache.http.conn.params.*; 
import org.sqlite.*; 
import org.apache.http.cookie.*; 
import org.apache.http.conn.routing.*; 
import org.apache.commons.logging.*; 
import org.apache.http.impl.conn.*; 
import org.apache.http.impl.client.cache.*; 
import org.apache.http.entity.mime.content.*; 
import org.apache.http.impl.pool.*; 
import org.apache.http.config.*; 
import org.apache.http.impl.entity.*; 
import org.apache.http.conn.util.*; 
import org.apache.commons.logging.impl.*; 
import org.apache.http.concurrent.*; 
import org.apache.http.conn.*; 
import org.apache.http.client.config.*; 
import org.apache.commons.codec.net.*; 
import org.sqlite.javax.*; 
import org.apache.http.pool.*; 
import org.apache.http.io.*; 
import org.apache.http.client.*; 
import org.apache.commons.codec.language.bm.*; 
import org.apache.http.impl.*; 
import org.apache.http.impl.conn.tsccm.*; 
import org.apache.http.client.utils.*; 
import org.apache.http.impl.cookie.*; 
import org.apache.http.auth.params.*; 
import org.apache.http.impl.client.cache.memcached.*; 
import org.apache.commons.codec.binary.*; 
import org.apache.http.conn.ssl.*; 
import org.apache.http.entity.mime.*; 
import org.apache.http.params.*; 
import org.apache.http.message.*; 
import org.apache.http.impl.execchain.*; 
import org.apache.http.conn.scheme.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class rendu extends PApplet {








 // Shiffman lib for http requests



/********* For Map *********/
UnfoldingMap map;
//DebugDisplay debugDisplay;
MBTilesMapProvider mytiles;
//SimplePointMarker mymarker;
//Location [] locations;
int falsesecond, falseminute, falsehours;
int currentsecond, currentminute;
//int nbmarkertodisplay;
boolean all;
JSONObject users;

Cyclist [] cyclist;

public void setup() {
	size(displayWidth, displayHeight);
	falsesecond = 0;
	falseminute = 0;
	falsehours = 16;

	/************** UNFOLDING PART ***********/
	String tilesStr = sketchPath("data/cyclecity.mbtiles");
	map = new UnfoldingMap(this,new MBTilesMapProvider(tilesStr));
    map.setZoomRange(13, 13);
    map.zoomAndPanTo(new Location(48.1134750f, -1.6757080f), 13);
    MapUtils.createDefaultEventDispatcher(this, map);
    /*****************************/
	all = false;
	getUsers();
}

public void draw() {

	background(0);
	map.draw();
	stroke(255);
	fill(255);
	textSize(40);
	text("Cyclecity", width/2, 100);
	if (keyPressed) {
		if (key == 'b' || key == 'B') {
	  		all = true;
		}
	}
	for (int i = 0; i < cyclist.length; ++i) {
		if (all) {
			cyclist[i].drawAllTrip();
		}else {
			textSize(20);
			text("Time : "+falsehours+":"+falseminute, 200, 100);
			cyclist[i].drawTrip();
		}
	}
	executeEachSecondChange();
}

public boolean sketchFullScreen() {
  return true;
}

public void getUsers(){
	try {
		GetRequest getusers = new GetRequest("http://kalyptusprod.fr/api/getinfos.php?getusers=all");
		getusers.send();
		users = new JSONObject();
		users = parseJSONObject(getusers.getContent());
	} catch (Exception e) {
		println(e);
	}

	cyclist = new Cyclist[users.size()];

	for (int i = 0; i < cyclist.length; ++i) {
		cyclist[i] = new Cyclist (users.getJSONObject(str(i)).getString("prenom"), PApplet.parseInt(users.getJSONObject(str(i)).getString("id")));
		cyclist[i].getTripWithId();
	}
}


public void fakeTime(){
	falseminute++;
	if (falseminute>=60) {
		falseminute = 0;
		falsehours++;
		if (falsehours>24) {
			falsehours = 0;
		}
	}
}


public void executeEachSecondChange(){

  if (currentsecond != second()){
      currentsecond = second();
      fakeTime();
    for (int i = 0; i < cyclist.length; ++i) {
		cyclist[i].tripAtTime(falsehours,falseminute);
	}
  }

  if (currentminute != minute()) {
  	  currentminute = minute();
  }

}
class Cyclist {

  public String username;
  public int userid;
  //public JSONObject datas;
  public Trip [] usertrips; // Stockage de tous les trajets r\u00e9cup\u00e9r\u00e9s du serveur
  public ArrayList<Trip> tripsOk; // Trajets finaux dessin\u00e9s 
  //public String [][] debutrip;

	 public Cyclist (String username, int userid){
	 	this.userid = userid;
	 	this.username = username;
	 	tripsOk = new ArrayList<Trip>();
	 }

	 public void getTripWithId(){
	 	try {
			GetRequest getusers = new GetRequest("http://kalyptusprod.fr/api/getinfos.php?gettrips=all&iduser="+userid);
			getusers.send();
			JSONObject datas = new JSONObject();
			datas = parseJSONObject(getusers.getContent());
			//println("Trips : "+datas+" for user : "+userid);
			usertrips = new Trip[datas.size()];
			//debutrip = new String[datas.size()][datas.size()];
			for (int i = 0; i < usertrips.length; ++i) {
				//debutrip[i] = split(datas.getJSONObject(str(i)).getString("debut"),":");
				//println(debutrip[i][0]);
				usertrips[i] = new Trip (PApplet.parseInt(datas.getJSONObject(str(i)).getString("id")), 
										datas.getJSONObject(str(i)).getString("debut"),
										datas.getJSONObject(str(i)).getString("fin"));

				usertrips[i].getLocationForTrip(userid);
			}
		} catch (Exception e) {
			println(e);
		}
	 }

	 // Test si il y a un trajet \u00e0 heure / minute pass\u00e9 en argument
	 // Si oui on ajoute le trajet \u00e0 tripOk
	 public void tripAtTime(int heure, int mn){
	 	String heur = str(heure);
	 	String minut = str(mn);
	 	if (heure<10) {
	 		heur = "0"+heure;
	 	}if (mn<10) {
	 		minut = "0"+mn;
	 	}
	 	//println(minut+" : "+heur);
	 	for (int i = 0; i < usertrips.length; ++i) {
	 		//println(usertrips[i].begintrip+"   "+heur+":"+minut); // Debug mode
	 		//println(usertrips[i].begintrip.equals(heur+":"+minut));
	 		if (usertrips[i].begintrip.equals(heur+":"+minut)) {
	 			tripsOk.add(usertrips[i]);
	 		}
	 		//println(usertrips[i].begintrip);
	 	}
	 }

	 // Affiche les trajets de tripsOk
	 public void drawTrip(){
	 	for (int i = 0; i < tripsOk.size(); ++i) {
	 		for (int j = 0; j < tripsOk.get(i).markerlength; ++j) {
	 			map.addMarkers(tripsOk.get(i).markers[j]);
	 		}
	 	}
	}

	public void drawAllTrip(){
	 	for (int i = 0; i < usertrips.length; ++i) {
	 		for (int j = 0; j < usertrips[i].markerlength; ++j) {
	 			map.addMarkers(usertrips[i].markers[j]);
	 		}
	 	}
	}
}
public class ThreeLinesMaker extends SimpleLinesMarker {
 	
  public float vitesse1;
  public float vitesse2;
  public int c = (0xffffffff);

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

    public void setColor(int col){
      this.c = col;
    }
  }
class Trip {

    public int idtrip;
    public String begintrip;
    public String endtrip;
    public Location [] locations;
    public float [] vitesse;
    public SimpleLinesMarker [] markers; //public SimpleLinesMarker [] markers;
    //public ThreeLinesMaker [] threemarker; // option
    public int markerlength;
    public int [] tripcolor = {0xffEBEBBC,0xff52E3AC,0xffF21D41};
    public int indexcolor;
    public float vit1,vit2;

    public Trip(int idtrip, String begintrip, String endtrip){
        this.idtrip = idtrip;
        this.begintrip = begintrip;
        this.endtrip = endtrip;
    }

    /**********
    ***
    *** R\u00e9cup\u00e9ration des positions pour chaque trajets
    ***
    ***********/
    public void getLocationForTrip(int userid){
        try {

        	println("http://kalyptusprod.fr/api/getinfos.php?iduser="+userid+"&time="+begintrip);
            GetRequest getlocations = new GetRequest("http://kalyptusprod.fr/api/getinfos.php?iduser="+userid+"&time="+begintrip);
            getlocations.send();
            JSONObject datas = new JSONObject();
            datas = parseJSONObject(getlocations.getContent());
            vitesse = new float[datas.size()];
            locations = new Location[datas.size()];

            //println(datas.getJSONObject("0"));

            for (int i = 0; i < locations.length; ++i) {
                locations [i] = new Location (PApplet.parseFloat(datas.getJSONObject(str(i)).getString("lat")),PApplet.parseFloat(datas.getJSONObject(str(i)).getString("long")));
                vitesse [i] = PApplet.parseFloat(datas.getJSONObject(str(i)).getString("vitesse"));
            }

        } catch (Exception e) {
            println(e);
        }
        setMarkersWithLocations();
    }

    /**********
    ***
    *** Initialisation des markers avec les positions
    ***
    ***********/
	 public void setMarkersWithLocations(){
        markers = new SimpleLinesMarker[locations.length];
	 	int k = 0;
        int vi;
	 	markerlength = locations.length;
        println("length : "+locations.length);
	 	for (int i = 0; i < locations.length; i++) {
            println(locations[i]+" : "+i);
            vi = i+1;
            if (vi>=locations.length)
                vi = locations.length-1;
            this.vit1 = map(vitesse[i], -2, 12, 0, 300);
            //this.vit2 = map(vitesse[vi], -2, 12, 0, 300);
            //println("vitesse 1 : "+vit1+"vitesse 2 : "+vit2);
            if (this.vit1<70) {
                indexcolor = 2; // rouge 
            }else if (this.vit1>70 && this.vit1<120){
                indexcolor = 1; // vert
            }else if (this.vit1>120) {
                indexcolor = 0; // jaune
            }
            //println("index : "+indexcolor);
            // threemarker[k] = new ThreeLinesMaker (locations[i],locations[vi],this.vit1,this.vit2);
            // threemarker[k].setColor(tripcolor[indexcolor]);
            //println("vitesse \u00e0 "+i+" : "+vitesse[i]);
	 		markers[k] = new SimpleLinesMarker (locations[i],locations[vi]);
            markers[k].setColor(tripcolor[indexcolor]);
	 		k++;
	 	}
	 }

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "rendu" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
