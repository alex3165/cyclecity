<?php
if (!empty($_SESSION)) {
?>

<!doctype html>
<html>

<div class="container">
<h2>Ajouter un nouvel utilisateur</h2>

<form class="form-horizontal" action='model/admin.php' method="POST" >
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
<?php 
}else{
  header("location: index.php?p=log");
} 

?>