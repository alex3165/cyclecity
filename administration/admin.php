<?php session_start(); 
if (!empty($_SESSION)) {
?>
<!doctype html>
<html>
<?php
include ("head.php");
include ("functions.php");
?>

<div class="container">
<h2>Ajouter un nouvel utilisateur</h2>

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
<?php 
    $reqloc = $dbh -> prepare('select * from localisation');
    $reqloc -> execute();
    $dataloc = $reqloc->fetch();
    $reqloc->closeCursor();

    //$requser = $dbh -> prepare('select * from user');
    //$requser -> execute();
    // while ($user = $requser->fetch())
    // {
    //   foreach ($user as $value) {
    //     echo $value."<br>";
    //   }
    // }
    //$requser->closeCursor();

    //print_r($dataloc['long']);
    //foreach ($datauser as $user => $value) {
      //foreach ($dataloc as $loc) {
        //$chiffre = $user['id'];
        //print_r($value['prenom']); 
        //echo $value['prenom'];
      //}
    //}
?>
<br>
<a href="deco.php">deconnecter</a>

</div>
</html>
<?php 
}else{
  header("location: index.php");
} ?>