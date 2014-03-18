import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;

import processing.net.*;
import http.requests.*; // Shiffman lib for http requests

import codeanticode.syphon.*; // syphon pour sortie vidéo

// import for SQLite JDBC : storage map
import de.bezier.data.sql.*;

// import java.io.*;
import java.util.*;

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

void setup() {
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

void draw() {
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

void mouseMoved(){
	
}

void getUsers(){
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
		cyclist[i] = new Cyclist (users.getJSONObject(str(i)).getString("prenom"), int(users.getJSONObject(str(i)).getString("id")));
		cyclist[i].getTripWithId();
	}
}

void executeEachSecondChange(){

  if (currentsecond != second()){
      currentsecond = second();

  }

  if (currentminute != minute()) {
  	  currentminute = minute();
  }

}