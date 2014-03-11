class Requests {

    private String mainurl;
    private String mainhost;
    private String keolisurl;
    private int port;

    public Requests(){
        mainurl = "http://kalyptusprod.fr/api/getinfos.php";
        mainhost = "http://kalyptusprod.fr";
        keolisurl = "http://data.keolis-rennes.com/json/?version=2.0&key=8W28SF1V3D03O3V&cmd=getbikestations";
        port = 80;
    }


    public void isLocationAtTime(PApplet parentclass, String usertime, int iduser){

        String datas;
        Client myserveur;
        String finalurl = mainurl+"?iduser="+iduser+"&time="+usertime;
        println(finalurl);
        try {
            myserveur = new Client (parentclass,finalurl,port);
            myserveur.write("GET / HTTP/1.0\r\n");
            myserveur.write("Host: "+mainhost+"\r\n");
            myserveur.write("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36\r\n");
            myserveur.write("\r\n");
            if (myserveur.available() > 0) {
                datas = myserveur.readString();
                println(datas);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        //return datas;
    }

    void getBikeStation(PApplet parentclass) {

        Client c;
        String data;

        try {
            c = new Client(parentclass, keolisurl, port);
            c.write("GET / HTTP/1.1\r\n");
            c.write("Host: http://data.keolis-rennes.com\r\n");
            c.write("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36\r\n");
            c.write("\r\n");

            if (c.available() > 0) {
                data = c.readString();
                println(data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}