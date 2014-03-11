class Requests {

    private String server;
    private String mainhost;
    private String endpoint;
    private String keolisurl;
    private int port;

    public Requests(){
        this.endpoint = "/api/getinfos.php";
        this.server = "kalyptusprod.fr";
        this.mainhost = "www.kalyptusprod.fr";
        this.port = 80;
    }

    public Client getUsers(PApplet parentclass){

        Client myserveur = new Client (parentclass,this.server,this.port);
        myserveur.write("GET "+this.endpoint+"?getusers=all HTTP/1.1\r\n");
        myserveur.write("Host: "+this.mainhost+"\r\n");
        myserveur.write("User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36\r\n");
        myserveur.write("Accept: application/json\r\n");
        myserveur.write("Accept-Language: en-us,en;q=0.5\r\n");
        myserveur.write("Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7\r\n");
        myserveur.write("\r\n");

        return myserveur;
    }

    public void isLocationAtTime(PApplet parentclass, String usertime, int iduser){

    }

    void getBikeStation(PApplet parentclass) {

        // Client c;
        // String data;

        // try {
        //     c = new Client(parentclass, keolisurl, port);
        //     c.write("GET / HTTP/1.1\r\n");
        //     c.write("Host: http://data.keolis-rennes.com\r\n");
        //     c.write("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36\r\n");
        //     c.write("\r\n");

        //     if (c.available() > 0) {
        //         data = c.readString();
        //         println(data);
        //     }
        // } catch (Exception e) {
        //     e.printStackTrace();
        // }

    }
}