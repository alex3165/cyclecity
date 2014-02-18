<?php
session_start();
include('../define.php');
include('../model/functions.php');

	if (!empty($_POST) && isset($_POST["login"]) && isset($_POST["mdp"])) {
		$login = $_POST['login'];
		$mdp = $_POST['mdp'];
		$dbh = connect();
		$reqlogin = $dbh -> prepare('select * from user where login = ?');
		$reqlogin -> execute(array($login));
		$donnees = $reqlogin->fetch();
		$reqlogin->closeCursor();
		if ($dbh == 0) {
			echo '<div class="alert alert-danger">Connexion à la bdd impossible</div>';
		}
		//print_r($donnees['mdp']." ".$mdp);
		if ($login == $donnees['login'] && $mdp == $donnees['mdp']) {
			$_SESSION['id'] = $donnees['id'];
			$_SESSION['login'] = $donnees['login'];
			$_SESSION['mdp'] = $donnees['mdp'];
			header("location: ../index.php?p=admin");
		}else{
			echo '<div class="alert alert-danger">Mauvais identifiant ou mot de passe</div>';
		}
	}
?>