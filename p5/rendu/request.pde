void GetBikeStation() {

    Client c;
    String data;


    try {
        c = new Client(this, "http://data.keolis-rennes.com/json/?version=2.0&key=8W28SF1V3D03O3V&cmd=getbikestations", 80);
        c.write("GET / HTTP/1.0\r\n");
        c.write("\r\n");    
        // http://data.keolis-rennes.com/json/?version=2.0&key=8W28SF1V3D03O3V&cmd=getbikestations
        if (c.available() > 0) {
            data = c.readString();
            println(data);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

}