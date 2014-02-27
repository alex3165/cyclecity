<?php
    session_start();

    require_once("../functions.php");

    if (!empty($_POST) && isset($_POST["login"]) && isset($_POST["mdp"])) {
        $login = $_POST['login'];
        $mdp = $_POST['mdp'];
        $dbh = connect();
        $reqlogin = $dbh -> prepare('select * from user where login = ?');
        $reqlogin -> execute(array($login));
        $donnees = $reqlogin->fetch();
        $reqlogin->closeCursor();
        if ($dbh == 0) {
            $jsonstring = json_encode('Database connection impossible');
            header('Content-Type: application/json; charset=utf-8');
            echo $jsonstring;
            echo $donnees;
        }
        if (empty($donnees['login']) && empty($donnees['mdp'])) {
            $jsonstring = json_encode('No login or passwords in database');
            header('Content-Type: application/json; charset=utf-8');
            echo $jsonstring;
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
        }
    }else{
        $jsonstring = json_encode('Fail, datas not received');
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
    }
?>