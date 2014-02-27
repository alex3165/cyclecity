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
import java.io.*; 
import java.util.*; 
import de.bezier.data.sql.*; 

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





/********* For Map *********/
UnfoldingMap map;
MBTilesMapProvider mytiles;
SimplePointMarker mymarker;
Location myloc;

/********* For Requests *********/
JSONObject datasJsonobject;

public void setup() {
	size(800, 600, P3D);

	/************** UNFOLDING PART ***********/

	String tilesStr = sketchPath("data/Alexandre.mbtiles");
	map = new UnfoldingMap(this,new MBTilesMapProvider(tilesStr));
    MapUtils.createDefaultEventDispatcher(this, map);
    map.setZoomRange(12, 16);
    map.zoomAndPanTo(new Location(48.1134750f, -1.6757080f), 12);

    /*****************************/

    GetBikeStation(); // Fonction pour affichage des stations de v\u00e9lo de la ville de Rennes
}

public void draw() {

	myloc = new Location(48.1134750f, -1.6757080f);
	mymarker = new SimplePointMarker(myloc);

	map.addMarkers(mymarker);
	background(255);
	stroke(255);
	line(width/2, height/2, 0, width/2, height/2, 200);
	camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
	//map.draw();
}


class VelocityMySQL {

	MySQL dbconnection;
	 //= new MySQL(this,"db511651757.db.1and1.com","db511651757","dbo511651757","12ldhbh07");
	String host, database, user, pass;
	PApplet applet;

	VelocityMySQL (PApplet applet) {
		this.applet = applet;
		host = "db511651757.db.1and1.com";
		database = "db511651757";
		user ="dbo511651757";
		pass = "12ldhbh07";
	}

	public void connection() {
		dbconnection = new MySQL(applet, host, database, user, pass);
		//println(host+" "+database);
	}

	public void getTrajectWithUser(){
		connection();
		// if ( dbconnection.connect() )
	 //    {

	 //        // Faire la requ\u00eate
	 //        println("connexion successed");
	 //        // dbconnection.query( "SELECT * FROM file_uploads" );
	 //        // while (dbconnection.next())
	 //        // {
	 //        //     String s = dbconnection.getString("name");
	 //        //     int n = dbconnection.getInt("fuid");
	 //        //     println(s + "   " + n);
	 //        // }
	 //    }
	 //    else
	 //    {
	 //    	println("connexion failed");
	 //        // connection failed !
	 //    }
	}
}
public void GetBikeStation() {

    Client c;
    String data;


    try {
        c = new Client(this, "http://data.keolis-rennes.com/json/?version=2.0&key=8W28SF1V3D03O3V&cmd=getbikestations", 80);
        c.write("GET / HTTP/1.0\r\n");
        c.write("\r\n");    
        // http://data.keolis-rennes.com/json/?version=2.0&key=8W28SF1V3D03O3V&cmd=getbikestations
        if (c.available() > 0) {
            data = c.readString();
            println(data);
        }
    } catch (Exception e) {
        e.printStackTrace();
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
