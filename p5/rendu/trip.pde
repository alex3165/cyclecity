class Trip {

    public int idtrip;
    public String begintrip;
    public String endtrip;
	public JSONObject datas;
    public Location [] locations;
    public float [] vitesse;
    public SimpleLinesMarker [] markers;
    public int markerlength;

    public Trip(int idtrip, String begintrip, String endtrip){
        this.idtrip = idtrip;
        this.begintrip = begintrip;
        this.endtrip = endtrip;
    }

    public void getLocationForTrip(int userid){
        try {
        	println("http://kalyptusprod.fr/api/getinfos.php?iduser="+userid+"&time="+begintrip);
            GetRequest getlocations = new GetRequest("http://kalyptusprod.fr/api/getinfos.php?iduser="+userid+"&time="+begintrip);
            getlocations.send();
            datas = new JSONObject();
            datas = parseJSONObject(getlocations.getContent());
            // if (datas.getJSONObject(str(i)).getString("lat")) {
            	
            // }
            vitesse = new float[datas.size()];
            locations = new Location[datas.size()];

            //println(datas.getJSONObject("0"));

            for (int i = 0; i < locations.length; ++i) {
                locations [i] = new Location (float(datas.getJSONObject(str(i)).getString("lat")),float(datas.getJSONObject(str(i)).getString("long")));
                vitesse [i] = float(datas.getJSONObject(str(i)).getString("vitesse"));
            }

        } catch (Exception e) {
            println(e);
        }
        setMarkersWithLocations();
    }

	 public void setMarkersWithLocations(){
	 	markers = new SimpleLinesMarker[locations.length/2]; //markers = new SimpleLinesMarker[locations.length/2];
	 	int k = 0;
	 	markerlength = locations.length/2;
	 	for (int i = 0; i < locations.length - 1; i=i+2) {
	 		markers[k] = new SimpleLinesMarker (locations[i],locations[i+1]); //markers[k] = new SimpleLinesMarker (locations[i],locations[i+1]);
	 		markers[k].setColor(255);
	 		k++;
	 	}
	 }

}