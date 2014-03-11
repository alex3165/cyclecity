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
import de.bezier.data.sql.*; 
import java.io.*; 
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







// import org.json.*;


// import for SQLite JDBC : storage map





/********* For Map *********/
UnfoldingMap map;
MBTilesMapProvider mytiles;
SimplePointMarker mymarker;
Location [] locations;

int currentsecond;
Client test;
Requests requests = new Requests();


public void setup() {
	size(1000, 800, P3D);

	test = requests.getUsers(this);
	if (test.available() > 0) {
        String datas = test.readString();
        println(datas);
        //JSONArray test = loadJSONObject(datas).getJSONArray("1");
    }

	/************** UNFOLDING PART ***********/
	String tilesStr = sketchPath("data/Alexandre.mbtiles");
	map = new UnfoldingMap(this,new MBTilesMapProvider(tilesStr));
    MapUtils.createDefaultEventDispatcher(this, map);
    map.setZoomRange(13, 16);
    map.zoomAndPanTo(new Location(48.1134750f, -1.6757080f), 13);
    /*****************************/

    JSONArray object = parseJsonAsJSONArray("test.json","positions");
    //runJSONArray(object);
}

public void draw() {

	//myloc = new Location(48.1134750, -1.6757080);
	//mymarker = new SimplePointMarker(myloc);

	//map.addMarkers(mymarker);
	//background(255);
	
	/* 3d line */
	// stroke(255);
	// line(width/2, height/2, 0, width/2, height/2, 200);
	//---------------- executeEachSecondChange();
	//---------------- map.draw();
	camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
}

public void mouseMoved(){
	
}

public void executeEachSecondChange(){
  if (currentsecond != second()){
      currentsecond = second();
      println(hour()+":"+minute()+":"+second());
  }
}

public JSONArray parseJsonAsJSONArray(String jsonString, String selectTable){
	JSONArray datas = loadJSONObject(jsonString).getJSONArray(selectTable);
	return datas;
}

public void runJSONArray(JSONArray datas){
	
	for (int i = 0; i < datas.size(); ++i) {
		JSONObject position = datas.getJSONObject(i);
		println(i+" "+position);
	}

}
class Cyclist {

 private String username;
 private int userid;
 private int tripid;
 private String tripbegining;
 private Location[] locations;
 
	 public Cyclist (String username, int userid){
	 	this.userid = userid;
	 	this.username = username;
	 }

	 public void setNewTraject(int tripid, String tripbegining, Location[] locations){
	 	this.tripid = tripid;
	 	this.tripbegining = tripbegining;
	 	this.locations = locations;
	 }
}
class Requests {

    private String server;
    private String mainhost;
    private String endpoint;
    private String keolisurl;
    private int port;

    public Requests(){
        this.endpoint = "/api/getinfos.php";
        this.server = "kalyptusprod.fr";
        this.mainhost = "www.kalyptusprod.fr";
        this.port = 80;
    }

    public Client getUsers(PApplet parentclass){

        Client myserveur = new Client (parentclass,this.server,this.port);
        myserveur.write("GET "+this.endpoint+"?getusers=all HTTP/1.1\r\n");
        myserveur.write("Host: "+this.mainhost+"\r\n");
        myserveur.write("User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36\r\n");
        myserveur.write("Accept: application/json\r\n");
        myserveur.write("Accept-Language: en-us,en;q=0.5\r\n");
        myserveur.write("Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7\r\n");
        myserveur.write("\r\n");

        return myserveur;
    }

    public void isLocationAtTime(PApplet parentclass, String usertime, int iduser){

    }

    public void getBikeStation(PApplet parentclass) {

        // Client c;
        // String data;

        // try {
        //     c = new Client(parentclass, keolisurl, port);
        //     c.write("GET / HTTP/1.1\r\n");
        //     c.write("Host: http://data.keolis-rennes.com\r\n");
        //     c.write("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36\r\n");
        //     c.write("\r\n");

        //     if (c.available() > 0) {
        //         data = c.readString();
        //         println(data);
        //     }
        // } catch (Exception e) {
        //     e.printStackTrace();
        // }

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
