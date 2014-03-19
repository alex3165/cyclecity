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
import codeanticode.syphon.*; 
import de.bezier.data.sql.*; 
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

 // syphon pour sortie vid\u00e9o

// import for SQLite JDBC : storage map


// import java.io.*;


/********* For Map *********/
UnfoldingMap map;
MBTilesMapProvider mytiles;
SimplePointMarker mymarker;
Location [] locations;

int currentsecond, currentminute;
int nbmarkertodisplay;
Location startLocation, endLocation, startLocation2, endLocation2;
SimpleLinesMarker connectionMarker, connectionMarker2;


JSONObject users;

Cyclist [] cyclist;

PGraphics canvas;
SyphonServer server;

public void setup() {
	size(displayWidth, displayHeight, P3D);
	//canvas = createGraphics(displayWidth, displayHeight, P3D);

	/************** UNFOLDING PART ***********/
	String tilesStr = sketchPath("data/Alexandre.mbtiles");
	map = new UnfoldingMap(this,new MBTilesMapProvider(tilesStr));
    MapUtils.createDefaultEventDispatcher(this, map);
    map.setZoomRange(12, 15);
    map.zoomAndPanTo(new Location(48.1134750f, -1.6757080f), 13);
    /*****************************/

    server = new SyphonServer(this, "Processing Syphon");

	getUsers();
}

public void draw() {
	//canvas.beginDraw();
	executeEachSecondChange();
	background(255);
	stroke(255);
	//line(width/2, height/2, 0, width/2, height/2, 200);
	map.draw();
	fill(255);
	for (int i = 0; i < cyclist.length; ++i) {
		cyclist[i].drawTrip();
	}
	//canvas.endDraw();
	//image(canvas, 0, 0);
	//server.sendImage(canvas);
	//camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
}

public void mouseMoved(){
	
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

public void executeEachSecondChange(){

  if (currentsecond != second()){
      currentsecond = second();

  }

  if (currentminute != minute()) {
  	  currentminute = minute();
  }

}
class Cyclist {

  public String username;
  public int userid;
  public JSONObject datas;
  public Trip [] usertrips;

	 public Cyclist (String username, int userid){
	 	this.userid = userid;
	 	this.username = username;
	 }

	 public void getTripWithId(){
	 	try {
			GetRequest getusers = new GetRequest("http://kalyptusprod.fr/api/getinfos.php?gettrips=all&iduser="+userid);
			getusers.send();
			datas = new JSONObject();
			datas = parseJSONObject(getusers.getContent());
			//println("Trips : "+datas+" for user : "+userid);
			
			usertrips = new Trip[datas.size()];

			for (int i = 0; i < usertrips.length; ++i) {
				usertrips[i] = new Trip (PApplet.parseInt(datas.getJSONObject(str(i)).getString("id")), 
										datas.getJSONObject(str(i)).getString("debut"),
										datas.getJSONObject(str(i)).getString("fin"));

				usertrips[i].getLocationForTrip(userid);
			}
		} catch (Exception e) {
			println(e);
		}
	 }

	 public void drawTrip(){
	 	for (int i = 0; i < usertrips.length; ++i) {
	 		for (int j = 0; j < usertrips[i].markerlength; ++j) {
	 			map.addMarkers(usertrips[i].markers[j]);
	 		}
	 	}
	 }
}// fin de class
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
class Trip {

    public int idtrip;
    public String begintrip;
    public String endtrip;
	public JSONObject datas;
    public Location [] locations;
    public float [] vitesse;
    public SimpleLinesMarker [] markers; //public SimpleLinesMarker [] markers;
    public ThreeLinesMaker [] threemarker; // option
    public int markerlength;
    //public color tripcolor;

    public Trip(int idtrip, String begintrip, String endtrip){
        this.idtrip = idtrip;
        this.begintrip = begintrip;
        this.endtrip = endtrip;
    }

    public void getLocationForTrip(int userid){
        try {
        	println("http://kalyptusprod.fr/api/getinfos.php?iduser="+userid+"&time="+begintrip);
            GetRequest getlocations = new GetRequest("http://kalyptusprod.fr/api/getinfos.php?iduser="+userid+"&time="+begintrip);
            getlocations.send();
            datas = new JSONObject();
            datas = parseJSONObject(getlocations.getContent());
            // if (datas.getJSONObject(str(i)).getString("lat")) {
            	
            // }
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
	 		markers[k] = new SimpleLinesMarker (locations[i],locations[vi]);
            markers[k].setColor(255);
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
