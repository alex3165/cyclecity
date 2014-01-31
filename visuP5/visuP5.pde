import de.bezier.data.sql.*;

float latitude, longitude;
MySQL msql;

void setup() {
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
            latitude = float(msql.getString("lat"));
            longitude = float(msql.getString("long"));
            println(latitude + "   " + longitude);
        }
    }
    else
    {
        println("Erreur de connection");
    }
}

void draw() {
	
}