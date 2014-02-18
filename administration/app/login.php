<?php
	session_start();
	//echo session_id()." ".session_name();
	require_once("../define.php");
	require_once(MODEL."functions.php");

	if (!empty($_POST) && isset($_POST["login"]) && isset($_POST["mdp"])) {
		$login = $_POST['login'];
		$mdp = $_POST['mdp'];
		$dbh = connect();
		$reqlogin = $dbh -> prepare('select * from user where login = ?');
		$reqlogin -> execute(array($login));
		$donnees = $reqlogin->fetch();
		$reqlogin->closeCursor();
		if ($dbh == 0) {
			//echo '<div class="alert alert-danger">Connexion à la bdd impossible</div>';
		}
		if (empty($donnees['login']) && empty($donnees['mdp'])) {
			//echo '<div class="alert alert-danger">impossible de récupérer le login et le mdp</div>';
		}
		if ($login == $donnees['login'] && $mdp == $donnees['mdp']) {
			$_SESSION['name'] = $donnees['prenom'];
			$_SESSION['id'] = $donnees['id'];
			$_SESSION['login'] = $donnees['login'];
			$_SESSION['mdp'] = $donnees['mdp'];
			$_SESSION['key'] = session_id();//generateKey();
			$json[]= array(
       			'id' => $_SESSION['id'],
       			'name' => $_SESSION['name'],
     			'key' => $_SESSION['key']
    		);
			$jsonstring = json_encode($json);
			header('Content-Type: application/json; charset=utf-8');
			echo $jsonstring;
		}else{
			//echo '<div class="alert alert-danger">Mauvais identifiant ou mot de passe</div>';
		}
	}
?>