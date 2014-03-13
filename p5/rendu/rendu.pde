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
Client test;
Requests requests = new Requests();

Location startLocation, endLocation, startLocation2, endLocation2;
SimpleLinesMarker connectionMarker, connectionMarker2;

void setup() {
	size(1000, 800, OPENGL);

	test = requests.getUsers(this);
	

	/************** UNFOLDING PART ***********/
	String tilesStr = sketchPath("data/Alexandre.mbtiles");
	map = new UnfoldingMap(this,new MBTilesMapProvider(tilesStr));
    MapUtils.createDefaultEventDispatcher(this, map);
    map.setZoomRange(13, 16);
    map.zoomAndPanTo(new Location(48.1134750f, -1.6757080f), 13);
    /*****************************/

    JSONArray object = parseJsonAsJSONArray("test.json","positions");
    //runJSONArray(object);
    startLocation = new Location(48.1138, -1.67773);
	endLocation = new Location(48.1087, -1.69524);
	connectionMarker = new SimpleLinesMarker(startLocation, endLocation);
    startLocation2 = new Location(48.1191, -1.70214);
	endLocation2 = new Location(48.1086, -1.69462);
	connectionMarker2 = new SimpleLinesMarker(startLocation2, endLocation2);
}

void draw() {
	
	if (test.available() > 0) {
        String datas = test.readString();
        println(datas);
        JSONObject json = loadJSONObject(datas);
        println(json);
    }
	//myloc = new Location(48.1134750, -1.6757080);
	//mymarker = new SimplePointMarker(myloc);

	background(255);
	
	/* 3d line */
	// stroke(255);
	// line(width/2, height/2, 0, width/2, height/2, 200);
	//---------------- executeEachSecondChange();
	//map.draw();
	fill(255);
	// map.addMarkers(connectionMarker);
	// map.addMarkers(connectionMarker2);
	//camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
}

void mouseMoved(){
	
}

void executeEachSecondChange(){
  if (currentsecond != second()){
      currentsecond = second();
      println(hour()+":"+minute()+":"+second());
  }
}

JSONArray parseJsonAsJSONArray(String jsonString, String selectTable){
	JSONArray datas = loadJSONObject(jsonString).getJSONArray(selectTable);
	return datas;
}

void runJSONArray(JSONArray datas){
	
	for (int i = 0; i < datas.size(); ++i) {
		JSONObject position = datas.getJSONObject(i);
		println(i+" "+position);
	}

}