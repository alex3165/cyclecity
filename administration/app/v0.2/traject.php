<?php
	session_start();

	require_once("model/database.php");
	
	$database = new Database();

    if (!empty($_POST) && isset($_POST["id"])) // D�but de trajet avec id de l'utilisateur, un timestamp automatique cr�� l'heure de d�but
    {
	    $iduser = $_POST['id'];
	    $database -> connexion();
	    $datas = $database -> reqBeginTraject($iduser);
        
        $json = array( 'idtraject' => $datas );
        $jsonstring = json_encode($json);
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
        
    }else if(!empty($_POST) && isset($_POST["idtraject"])) // Fin de trajet on re�oit l'id du trajet, on clos le trajet avec l'heure
    {
	    $iduser = $_POST['idtraject'];
	    $time = date("H:i:s");
	    	
	    $database -> connexion();
	    $datas = $database -> reqEndTraject($iduser, $time);
        
        $json = array( $datas );
        $jsonstring = json_encode($json);
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
        
    }else // erreur aucune donn�e re�ue
    {
	    $jsonstring = json_encode('datas not received');
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
    }


?>