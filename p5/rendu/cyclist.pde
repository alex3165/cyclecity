class Cyclist {

  public String username;
  public int userid;
  public JSONObject datas;
  public Trip [] usertrips;

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
			println("Trips : "+datas+" for user : "+userid);
			
			usertrips = new Trip[datas.size()];

			for (int i = 0; i < usertrips.length; ++i) {
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
	 		}
	 	}
	 }
}// fin de class