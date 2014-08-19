<?php
	session_start();
	
	require_once("model/database.php");
	
	$database = new Database();
	
	if (!empty($_GET)) {
	
		$idUser = $_GET['iduser'];
		$time = $_GET['time'];
		//echo 'test';
		$datas = $database -> getInfos($idUser,$time);
	}
	if(!empty($datas) || !strcmp($datas['status'],"no way at this time") ){
		header('Content-Type: application/json; charset=utf-8');
		echo json_encode($datas);
	}
	/* Set informations here */
?>
						