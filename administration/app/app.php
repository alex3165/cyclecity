<?php

include ("../functions.php");

$long = $_POST['long'];
$lat = $_POST['lat'];
$id = 13;

// UPDATE localisation SET lat = 12, long = 3 WHERE id_user = 13
// echo $long." ".$lat;
//$long = 42.2222;
//$lat = -2;

if (!empty($long) && !empty($lat)) {
	$req = $dbh -> prepare ("UPDATE localisation SET lat = :lat, lon = :long WHERE id_user = :id");
	$req -> execute(array(
	      'lat' => $lat,
	      'long' => $long,
	      'id' => $id
	));
	$req->closeCursor();
}

?>
</html>