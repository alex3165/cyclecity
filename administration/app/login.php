<?php
	session_start();
	include ("../functions.php");

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
			$_SESSION['id'] = $donnees['id'];
			$_SESSION['login'] = $donnees['login'];
			$_SESSION['mdp'] = $donnees['mdp'];
			$_SESSION['key'] = generateKey();
			$json[]= array(
       			'id' => $_SESSION['id'],
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