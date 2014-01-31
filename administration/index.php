<?php
	session_start();
	include ("functions.php");
	if (!empty($_POST) && isset($_POST["login"]) && isset($_POST["mdp"])) {
		$login = $_POST['login'];
		$mdp = $_POST['mdp'];
		$dbh = connect('localhost','duracity','root','root');
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
			header("location: admin.php");
		}else{
			echo '<div class="alert alert-danger">Mauvais identifiant ou mot de passe</div>';
		}
	}
	include ("head.php");
?>
<!doctype html>
<html>
	<body>
	<div class="container center">
		<h1>Duracity | Administration connexion</h1>
		<form class="form-horizontal" method="post" action="index.php">
			<div class="input-group center">
				<input type="text" class="form-control" name="login" placeholder="Login" required>
				<input type="password" class="form-control" name="mdp" placeholder="Mot de passe" required>
				<button type="submit" class="btn btn-primary">Valider</button>
			</div>
		</form>
	</div>
	</body>

</html>