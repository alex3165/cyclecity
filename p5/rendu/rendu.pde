import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;

// import org.json.*;
import processing.net.*;

import java.io.*;
import java.util.*;

/********* For Map *********/
UnfoldingMap map;
MBTilesMapProvider mytiles;
SimplePointMarker mymarker;
Location myloc;

/********* For Requests *********/
JSONObject datasJsonobject;

void setup() {
	size(800, 600, P3D);

	/************** UNFOLDING PART ***********/

	String tilesStr = sketchPath("data/Alexandre.mbtiles");
	map = new UnfoldingMap(this,new MBTilesMapProvider(tilesStr));
    MapUtils.createDefaultEventDispatcher(this, map);
    map.setZoomRange(12, 16);
    map.zoomAndPanTo(new Location(48.1134750f, -1.6757080f), 12);

    /*****************************/

    GetBikeStation(); // Fonction pour affichage des stations de vélo de la ville de Rennes
}

void draw() {

	myloc = new Location(48.1134750, -1.6757080);
	mymarker = new SimplePointMarker(myloc);

	map.addMarkers(mymarker);
	background(255);
	stroke(255);
	line(width/2, height/2, 0, width/2, height/2, 200);
	camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
	//map.draw();
}