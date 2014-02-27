import de.bezier.data.sql.*;

class VelocityMySQL {

	MySQL dbconnection;
	 //= new MySQL(this,"db511651757.db.1and1.com","db511651757","dbo511651757","12ldhbh07");
	String host, database, user, pass;
	PApplet applet;

	VelocityMySQL (PApplet applet) {
		this.applet = applet;
		host = "db511651757.db.1and1.com";
		database = "db511651757";
		user ="dbo511651757";
		pass = "12ldhbh07";
	}

	void connection() {
		dbconnection = new MySQL(applet, host, database, user, pass);
		//println(host+" "+database);
	}

	void getTrajectWithUser(){
		connection();
		// if ( dbconnection.connect() )
	 //    {

	 //        // Faire la requête
	 //        println("connexion successed");
	 //        // dbconnection.query( "SELECT * FROM file_uploads" );
	 //        // while (dbconnection.next())
	 //        // {
	 //        //     String s = dbconnection.getString("name");
	 //        //     int n = dbconnection.getInt("fuid");
	 //        //     println(s + "   " + n);
	 //        // }
	 //    }
	 //    else
	 //    {
	 //    	println("connexion failed");
	 //        // connection failed !
	 //    }
	}
}