<?php
    session_start();

    require_once("model/database.php");
    
    $database = new Database();
    
    if (!empty($_POST) && isset($_POST["login"]) && isset($_POST["mdp"])) {
    	
        $login = $_POST['login'];
        $mdp = $_POST['mdp'];
        
        $database -> connexion();
        $datas = $database -> reqLogin($login);
        
        if ($login == $datas['login'] && $mdp == $datas['mdp']) {
        
            $_SESSION['name'] = $datas['prenom'];
            $_SESSION['id'] = $datas['id'];
            $_SESSION['login'] = $datas['login'];
            $_SESSION['mdp'] = $datas['mdp'];
            
            $json = array(
                'id' => $_SESSION['id'],
                'name' => $_SESSION['name']
            );
            
            $jsonstring = json_encode($json);
            header('Content-Type: application/json; charset=utf-8');
            echo $jsonstring;
        }
    }else{
    	$jsonstring = json_encode('datas not received');
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
    }
?>