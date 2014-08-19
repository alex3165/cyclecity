<?php
	session_start();
	
	require_once("model/database.php");
	
	$database = new Database();
	
	if (!empty($_POST)) {
		
        $idtraject = $_POST['idtraject'];
		$longitude = $_POST['long'];
		$latitude = $_POST['lat'];
		$vitesse = $_POST['vitesse'];
        
        $datas = $database -> reqLocation($idtraject, $longitude, $latitude, $vitesse);
        
        $jsonstring = json_encode(array(
        	
        	"status" => $datas
        
        ));
        
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
        
    }
    else{
	    $jsonstring = json_encode('Aucune donnée reçue');
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
    }
?>
						