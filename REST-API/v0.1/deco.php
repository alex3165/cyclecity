<?php

$deco = $_POST['deco'];

if (isset($_POST) && $deco) {
	session_start();
	session_unset();
	session_destroy();
	$jsonstring = json_encode('Good, vous avez été déconnecté');
    header('Content-Type: application/json; charset=utf-8');
    echo $jsonstring;
}else{
	$jsonstring = json_encode('Erreur, on rentre pas dans la boucle');
    header('Content-Type: application/json; charset=utf-8');
    echo $jsonstring;
}


?>