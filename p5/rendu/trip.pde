class Trip {

    public int idtrip;
    public String begintrip;
    public String endtrip;
    public Location [] locations;
    public float [] vitesse;
    public SimpleLinesMarker [] markers; //public SimpleLinesMarker [] markers;
    //public ThreeLinesMaker [] threemarker; // option
    public int markerlength;
    public color [] tripcolor = {#EBEBBC,#52E3AC,#F21D41};
    public int indexcolor;
    public float vit1,vit2;

    public Trip(int idtrip, String begintrip, String endtrip){
        this.idtrip = idtrip;
        this.begintrip = begintrip;
        this.endtrip = endtrip;
    }

    /**********
    ***
    *** Récupération des positions pour chaque trajets
    ***
    ***********/
    public void getLocationForTrip(int userid){
        try {

        	println("http://kalyptusprod.fr/api/getinfos.php?iduser="+userid+"&time="+begintrip);
            GetRequest getlocations = new GetRequest("http://kalyptusprod.fr/api/getinfos.php?iduser="+userid+"&time="+begintrip);
            getlocations.send();
            JSONObject datas = new JSONObject();
            datas = parseJSONObject(getlocations.getContent());
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

    /**********
    ***
    *** Initialisation des markers avec les positions
    ***
    ***********/
	 public void setMarkersWithLocations(){
        markers = new SimpleLinesMarker[locations.length];
	 	int k = 0;
        int vi;
	 	markerlength = locations.length;
        println("length : "+locations.length);
	 	for (int i = 0; i < locations.length; i++) {
            println(locations[i]+" : "+i);
            vi = i+1;
            if (vi>=locations.length)
                vi = locations.length-1;
            this.vit1 = map(vitesse[i], -2, 12, 0, 300);
            //this.vit2 = map(vitesse[vi], -2, 12, 0, 300);
            //println("vitesse 1 : "+vit1+"vitesse 2 : "+vit2);
            if (this.vit1<70) {
                indexcolor = 2; // rouge 
            }else if (this.vit1>70 && this.vit1<120){
                indexcolor = 1; // vert
            }else if (this.vit1>120) {
                indexcolor = 0; // jaune
            }
            //println("index : "+indexcolor);
            // threemarker[k] = new ThreeLinesMaker (locations[i],locations[vi],this.vit1,this.vit2);
            // threemarker[k].setColor(tripcolor[indexcolor]);
            //println("vitesse à "+i+" : "+vitesse[i]);
	 		markers[k] = new SimpleLinesMarker (locations[i],locations[vi]);
            markers[k].setColor(tripcolor[indexcolor]);
	 		k++;
	 	}
	 }

}