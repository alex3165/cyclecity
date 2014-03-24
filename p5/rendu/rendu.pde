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
//SimplePointMarker mymarker;
//Location [] locations;
int falsesecond, falseminute, falsehours;
int currentsecond, currentminute;
int nbmarkertodisplay;
//Location startLocation, endLocation, startLocation2, endLocation2;
//SimpleLinesMarker connectionMarker, connectionMarker2;

JSONObject users;

Cyclist [] cyclist;

void setup() {
	size(displayWidth, displayHeight, OPENGL);
	falsesecond = 0;
	falseminute = 0;
	falsehours = 16;

	/************** UNFOLDING PART ***********/
	String tilesStr = sketchPath("data/Alexandre.mbtiles");
	map = new UnfoldingMap(this,new MBTilesMapProvider(tilesStr));
    MapUtils.createDefaultEventDispatcher(this, map);
    map.setZoomRange(13, 14);
    map.zoomAndPanTo(new Location(48.1134750f, -1.6757080f), 13);
    /*****************************/

	getUsers();
}

void draw() {

	//executeEachSecondChange();
    background(255);
	map.draw();
	stroke(255);
	fill(255);
	textSize(26);
	text("Cyclecity", width/2, 100);
    for (int i = 0; i < cyclist.length; ++i) {
		cyclist[i].drawTrip();
		//cyclist[i].;
	}
	executeEachSecondChange();
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

void fakeTime(){
	falseminute++;
	if (falseminute>=60) {
		falseminute = 0;
		falsehours++;
		if (falsehours>24) {
			falsehours = 0;
		}
	}
}


void executeEachSecondChange(){

  if (currentsecond != second()){
      currentsecond = second();
      fakeTime();

  }

  if (currentminute != minute()) {
  	  currentminute = minute();
  }

}