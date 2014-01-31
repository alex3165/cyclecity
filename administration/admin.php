<?php session_start(); ?>
<!doctype html>
<html>
<?php  
include ("head.php");
include ("functions.php");
?>

<div class="container">
<h2>Ajouter de nouveaux utilisateurs</h2>

<?php

  $dbh = connect('localhost','duracity','root','root');

  if (!empty($_POST) && $dbh != 0){

      $prenom = $_POST['prenom'];
      $login = $_POST['login'];
      $mdp = $_POST['mdp'];

      if (!empty($prenom) && !empty($mdp) && !empty($login)) {

        $req = $dbh -> prepare ("INSERT INTO user(prenom, login, mdp) VALUES(:prenom, :login, :mdp)");
        $req -> execute(array(
          'prenom' => $prenom,
          'login' => $login,
          'mdp' => $mdp
        ));
        echo '<div class="alert alert-success">Utilisateur ajouté avec succès</div>';
      }else{
        echo '<div class="alert alert-danger">Veuillez remplir tous les champs</div>';
      }
  }
?>

<form class="form-horizontal" action="admin.php" method="POST" >
  <div class="input-group">
  	<input class="form-control" type="text" name="prenom" placeholder="prenom">
  	<input class="form-control" type="text" name="login" placeholder="login">
  	<input class="form-control" type="text" name="mdp" placeholder="mdp">
  	
    <div class="input-prepend">
      <button type="submit" class="btn btn-primary">Valider</button>
    </div>
  </div>
</form>

<br>
<a href="deco.php">deconnecter</a>

</div>
</html>