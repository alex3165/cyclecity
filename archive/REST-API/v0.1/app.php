<?php
session_start();

require_once("../define.php");
require_once("../model/functions.php");


$sessionid = $_POST['key'];
$long = $_POST['long'];
$lat = $_POST['lat'];
$id = 13; // Test avec un ID en dur, mettre id de l'utilisateur sur le long terme

if ($sessionid == session_id()) {
    if (!empty($long) && !empty($lat)) {

        $dbh = connect();
        $req = $dbh -> prepare ("UPDATE localisation SET lat = :lat, lon = :long WHERE id_user = :id");
        $req -> execute(array(
              'lat' => $lat,
              'long' => $long,
              'id' => $id
        ));
        $req->closeCursor();

        $jsonstring = json_encode('Well, data has been added');
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
    }

}else{
    $jsonstring = json_encode('Fail, session_id not good');
    header('Content-Type: application/json; charset=utf-8');
    echo $jsonstring;
}

?>