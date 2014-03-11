class Cyclist {

 private String username;
 private int userid;
 private int tripid;
 private String tripbegining;
 private Location[] locations;
 
	 public Cyclist (String username, int userid){
	 	this.userid = userid;
	 	this.username = username;
	 }

	 public void setNewTraject(int tripid, String tripbegining, Location[] locations){
	 	this.tripid = tripid;
	 	this.tripbegining = tripbegining;
	 	this.locations = locations;
	 }
}