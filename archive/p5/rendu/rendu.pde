import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;

import processing.net.*;
import http.requests.*; // Shiffman lib for http requests

import java.util.*;

/********* For Map *********/
UnfoldingMap map;
//DebugDisplay debugDisplay;
MBTilesMapProvider mytiles;
//SimplePointMarker mymarker;
//Location [] locations;
int falsesecond, falseminute, falsehours;
int currentsecond, currentminute;
//int nbmarkertodisplay;
boolean all;
JSONObject users;

Cyclist [] cyclist;

void setup() {
	size(displayWidth, displayHeight);
	falsesecond = 0;
	falseminute = 0;
	falsehours = 16;

	/************** UNFOLDING PART ***********/
	String tilesStr = sketchPath("data/cyclecity.mbtiles");
	map = new UnfoldingMap(this,new MBTilesMapProvider(tilesStr));
    map.setZoomRange(13, 13);
    map.zoomAndPanTo(new Location(48.1134750f, -1.6757080f), 13);
    MapUtils.createDefaultEventDispatcher(this, map);
    /*****************************/
	all = false;
	getUsers();
}

void draw() {

	background(0);
	map.draw();
	stroke(255);
	fill(255);
	textSize(40);
	text("Cyclecity", width/2, 100);
	if (keyPressed) {
		if (key == 'b' || key == 'B') {
	  		all = true;
		}
	}
	for (int i = 0; i < cyclist.length; ++i) {
		if (all) {
			cyclist[i].drawAllTrip();
		}else {
			textSize(20);
			text("Time : "+falsehours+":"+falseminute, 200, 100);
			cyclist[i].drawTrip();
		}
	}
	executeEachSecondChange();
}

boolean sketchFullScreen() {
  return true;
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
    for (int i = 0; i < cyclist.length; ++i) {
		cyclist[i].tripAtTime(falsehours,falseminute);
	}
  }

  if (currentminute != minute()) {
  	  currentminute = minute();
  }

}