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
Location myloc;

/********* For Requests *********/
JSONObject datasJsonobject;

int currentsecond;

Requests requests = new Requests();

public void setup() {
	size(1000, 800, P3D);
	//requests.getBikeStation(this);
	requests.isLocationAtTime(this,"13:46",1);
	/************** UNFOLDING PART ***********/
	String tilesStr = sketchPath("data/Alexandre.mbtiles");
	map = new UnfoldingMap(this,new MBTilesMapProvider(tilesStr));
    MapUtils.createDefaultEventDispatcher(this, map);
    map.setZoomRange(13, 16);
    map.zoomAndPanTo(new Location(48.1134750f, -1.6757080f), 13);
    /*****************************/

}

public void draw() {

	myloc = new Location(48.1134750f, -1.6757080f);
	mymarker = new SimplePointMarker(myloc);

	//map.addMarkers(mymarker);
	background(255);
	map.draw();
	/* 3d line */
	// stroke(255);
	// line(width/2, height/2, 0, width/2, height/2, 200);
	//ExecuteEachSecondChange();

	camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

}

public void ExecuteEachSecondChange(){
  if (currentsecond != second()){
      currentsecond = second();
      println(hour()+":"+minute()+":"+second());
  }
}
class Cyclist {

 private String user;
 private int idUser;
 private int idTraject;
 private String beginTraject;
 private float[][] locations;
 
	 public Cyclist (){
	 	
	 }
}
class Requests {

    private String mainurl;
    private String mainhost;
    private String keolisurl;
    private int port;

    public Requests(){
        mainurl = "http://kalyptusprod.fr/api/getinfos.php";
        mainhost = "http://kalyptusprod.fr";
        keolisurl = "http://data.keolis-rennes.com/json/?version=2.0&key=8W28SF1V3D03O3V&cmd=getbikestations";
        port = 80;
    }


    public void isLocationAtTime(PApplet parentclass, String usertime, int iduser){

        String datas;
        Client myserveur;
        String finalurl = mainurl+"?iduser="+iduser+"&time="+usertime;
        println(finalurl);
        try {
            myserveur = new Client (parentclass,mainurl,port);
            myserveur.write("GET / HTTP/1.0\r\n");
            myserveur.write("Host: "+mainhost+"\r\n");
            myserveur.write("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36\r\n");
            myserveur.write("\r\n");
            if (myserveur.available() > 0) {
                datas = myserveur.readString();
                println(datas);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        //return datas;
    }

    public void getBikeStation(PApplet parentclass) {

        Client c;
        String data;

        try {
            c = new Client(parentclass, keolisurl, port);
            c.write("GET / HTTP/1.1\r\n");
            c.write("Host: http://data.keolis-rennes.com\r\n");
            c.write("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36\r\n");
            c.write("\r\n");

            if (c.available() > 0) {
                data = c.readString();
                println(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
