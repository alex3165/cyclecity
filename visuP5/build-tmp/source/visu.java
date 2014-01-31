import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import de.bezier.data.sql.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class visu extends PApplet {



float latitude, longitude;
MySQL msql;

public void setup() {
	size(displayWidth, displayHeight);
	String user     = "root";
    String pass     = "root";
    String database = "duracity";
    msql = new MySQL( this, "localhost:8889", database, user, pass );

    if ( msql.connect() )
    {
        msql.query( "SELECT * FROM localisation WHERE id_user=1" );
        while (msql.next())
        {
            latitude = PApplet.parseFloat(msql.getString("lat"));
            longitude = PApplet.parseFloat(msql.getString("long"));
            println(latitude + "   " + longitude);
        }
    }
    else
    {
        println("Erreur de connection");
    }
}

public void draw() {
	
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "visu" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
