class Cyclist {

  public String username;
  public int userid;
  public JSONObject datas;
  public Trip [] usertrips;
  public String [][] debutrip;

	 public Cyclist (String username, int userid){
	 	this.userid = userid;
	 	this.username = username;
	 }

	 public void getTripWithId(){
	 	try {
			GetRequest getusers = new GetRequest("http://kalyptusprod.fr/api/getinfos.php?gettrips=all&iduser="+userid);
			getusers.send();
			datas = new JSONObject();
			datas = parseJSONObject(getusers.getContent());
			//println("Trips : "+datas+" for user : "+userid);
			
			usertrips = new Trip[datas.size()];
			debutrip = new String[datas.size()][datas.size()];
			for (int i = 0; i < usertrips.length; ++i) {
				debutrip[i] = split(datas.getJSONObject(str(i)).getString("debut"),":");
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

	 public void drawTrip(){
	 	for (int i = 0; i < usertrips.length; ++i) {
	 		for (int j = 0; j < usertrips[i].markerlength; ++j) {
	 			map.addMarkers(usertrips[i].markers[j]);
	 			//map.addMarkers(usertrips[i].threemarker[j]);
	 		}
	 	}
	}

	public int getBeginHours(){
		for (int i = 0; i < usertrips.length; ++i) {
	 		return int(usertrips[i].debutrip[i][0]);
	 	}
	}
}