import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;

// import org.json.*;
import processing.net.*;

// import for SQLite JDBC : storage map
import de.bezier.data.sql.*;

import java.io.*;
import java.util.*;

/********* For Map *********/
UnfoldingMap map;
MBTilesMapProvider mytiles;
SimplePointMarker mymarker;
Location [] locations;

int currentsecond;

Requests requests = new Requests();

void setup() {
	size(1000, 800, P3D);
	//requests.getBikeStation(this);

	/* Error : java.net.UnknownHostException: http://kalyptusprod.fr/api/getinfos.php?iduser=1&time=13:46 */
	requests.isLocationAtTime(this,"13:46",1);

	/************** UNFOLDING PART ***********/
	String tilesStr = sketchPath("data/Alexandre.mbtiles");
	map = new UnfoldingMap(this,new MBTilesMapProvider(tilesStr));
    MapUtils.createDefaultEventDispatcher(this, map);
    map.setZoomRange(13, 16);
    map.zoomAndPanTo(new Location(48.1134750f, -1.6757080f), 13);
    /*****************************/
    
    JSONArray object = parseJsonAsJSONArray();
    //runJSONArray(object);
}

void draw() {

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

void mouseMoved(){
	
}

void executeEachSecondChange(){
  if (currentsecond != second()){
      currentsecond = second();
      println(hour()+":"+minute()+":"+second());
  }
}

JSONArray parseJsonAsJSONArray(){
	JSONArray datas = loadJSONObject("test.json").getJSONArray("positions");
	return datas;
}

void runJSONArray(JSONArray datas){
	
	for (int i = 0; i < datas.size(); ++i) {
		JSONObject position = datas.getJSONObject(i);
		println(i+" "+position);
	}

}