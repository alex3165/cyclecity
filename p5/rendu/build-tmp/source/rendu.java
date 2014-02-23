import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import de.fhpotsdam.unfolding.*; 
import de.fhpotsdam.unfolding.providers.*; 
import de.fhpotsdam.unfolding.geo.*; 
import de.fhpotsdam.unfolding.utils.*; 
import de.fhpotsdam.unfolding.marker.*; 
import de.bezier.data.sql.*; 
import org.apache.http.client.*; 
import org.apache.http.impl.client.DefaultHttpClient; 
import org.apache.http.client.HttpClient; 
import org.apache.http.client.methods.HttpGet; 
import org.apache.http.HttpResponse; 
import org.apache.http.HttpEntity; 
import org.json.*; 
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



















// import java.util.ArrayList;
// import java.util.List;

/********* For Map *********/
UnfoldingMap map;
MBTilesMapProvider mytiles;
SimplePointMarker mymarker;
Location myloc;

/********* For Requests *********/
//JSONObject datasJsonobject;

public void setup() {
	size(800, 600, P3D); // displayWidth, displayHeight-120, P3D
	String tilesStr = sketchPath("data/Alexandre.mbtiles");

	map = new UnfoldingMap(this,new MBTilesMapProvider(tilesStr));

    MapUtils.createDefaultEventDispatcher(this, map);
    map.setZoomRange(12, 17);
    map.zoomAndPanTo(new Location(48.1134750f, -1.6757080f), 12);
    GetBikeStation();
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

public void GetBikeStation() {
	try {
		HttpClient client = new DefaultHttpClient();
		HttpPost post = new HttpPost("http://data.keolis-rennes.com/json/");
		List<NameValuePair> params = new ArrayList<NameValuePair>(1);
		HttpResponse response;
		BufferedReader rd;

		params.add(new BasicNameValuePair("version", "2.0"));
		params.add(new BasicNameValuePair("key", "8W28SF1V3D03O3V"));
		params.add(new BasicNameValuePair("cmd", "getbikestations"));
		
		post.setEntity(new UrlEncodedFormEntity(params));
		response = client.execute(post);
		rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
		String datas = rd.readLine();

		JSONTokener tokener = new JSONTokener(datas);
		JSONArray finalResult = new JSONArray(tokener);
		finalResult.getString(3);
	    // while ((datas = rd.readLine()) != null) {
	    // 	println("LINE");
	    //   System.out.println(datas);
	    // }

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
