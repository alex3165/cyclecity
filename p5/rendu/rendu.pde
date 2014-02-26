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
// import java.util.ArrayList;
// import java.util.List;

/********* For Map *********/
UnfoldingMap map;
MBTilesMapProvider mytiles;
SimplePointMarker mymarker;
Location myloc;

/********* For Requests *********/
//JSONObject datasJsonobject;

void setup() {
	size(800, 600, P3D);
	String tilesStr = sketchPath("data/Alexandre.mbtiles");

	map = new UnfoldingMap(this,new MBTilesMapProvider(tilesStr));

    MapUtils.createDefaultEventDispatcher(this, map);
    map.setZoomRange(12, 17);
    map.zoomAndPanTo(new Location(48.1134750f, -1.6757080f), 12);
    GetBikeStation();
}

void draw() {
	myloc = new Location(48.1134750, -1.6757080);
	mymarker = new SimplePointMarker(myloc);

	map.addMarkers(mymarker);
	background(255);
	stroke(255);
	line(width/2, height/2, 0, width/2, height/2, 200);
	camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
	map.draw();
}

void GetBikeStation() {
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

		// JSONTokener tokener = new JSONTokener(datas);
		// JSONArray finalResult = new JSONArray(tokener);
		// finalResult.getString(3);
	    // while ((datas = rd.readLine()) != null) {
	    // 	println("LINE");
	    //   System.out.println(datas);
	    // }

	} catch (Exception e) {
		e.printStackTrace();
	}
}




