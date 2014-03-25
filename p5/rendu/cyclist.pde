class Cyclist {

  public String username;
  public int userid;
  //public JSONObject datas;
  public Trip [] usertrips; // Stockage de tous les trajets récupérés du serveur
  public ArrayList<Trip> tripsOk; // Trajets finaux dessinés 
  //public String [][] debutrip;

	 public Cyclist (String username, int userid){
	 	this.userid = userid;
	 	this.username = username;
	 	tripsOk = new ArrayList<Trip>();
	 }

	 public void getTripWithId(){
	 	try {
			GetRequest getusers = new GetRequest("http://kalyptusprod.fr/api/getinfos.php?gettrips=all&iduser="+userid);
			getusers.send();
			JSONObject datas = new JSONObject();
			datas = parseJSONObject(getusers.getContent());
			//println("Trips : "+datas+" for user : "+userid);
			usertrips = new Trip[datas.size()];
			//debutrip = new String[datas.size()][datas.size()];
			for (int i = 0; i < usertrips.length; ++i) {
				//debutrip[i] = split(datas.getJSONObject(str(i)).getString("debut"),":");
				//println(debutrip[i][0]);
				usertrips[i] = new Trip (int(datas.getJSONObject(str(i)).getString("id")), 
										datas.getJSONObject(str(i)).getString("debut"),
										datas.getJSONObject(str(i)).getString("fin"));

				usertrips[i].getLocationForTrip(userid);
			}
		} catch (Exception e) {
			println(e);
		}
	 }

	 // Test si il y a un trajet à heure / minute passé en argument
	 // Si oui on ajoute le trajet à tripOk
	 public void tripAtTime(int heure, int mn){
	 	String heur = str(heure);
	 	String minut = str(mn);
	 	if (heure<10) {
	 		heur = "0"+heure;
	 	}if (mn<10) {
	 		minut = "0"+mn;
	 	}
	 	//println(minut+" : "+heur);
	 	for (int i = 0; i < usertrips.length; ++i) {
	 		println(usertrips[i].begintrip+"   "+heur+":"+minut); // Debug mode
	 		//println(usertrips[i].begintrip.equals(heur+":"+minut));
	 		if (usertrips[i].begintrip.equals(heur+":"+minut)) {
	 			tripsOk.add(usertrips[i]);
	 		}
	 		//println(usertrips[i].begintrip);
	 	}
	 }

	 // Affiche les trajets de tripsOk
	 public void drawTrip(){
	 	for (int i = 0; i < tripsOk.size(); ++i) {
	 		for (int j = 0; j < tripsOk.get(i).markerlength; ++j) {
	 			map.addMarkers(tripsOk.get(i).markers[j]);
	 		}
	 	}
	}
}