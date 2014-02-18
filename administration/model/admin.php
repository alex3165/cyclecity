<?php
session_start();
require_once("../define.php");
require_once(MODEL."functions.php");

if (!empty($_SESSION)) {

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
        header("location: ../index.php?p=admin");
      }else{
        echo '<div class="alert alert-danger">Veuillez remplir tous les champs</div>';
      }
  }
  else{
    header("location: ../index.php");
  }
}

?>