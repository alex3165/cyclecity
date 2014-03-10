<?php

class Database {

private $dbh = '';


public function __construct(){ 
	$info = parse_ini_file("config.ini");

	$login = $info['login'];
	$pass = $info['pass'];
	$dbname = $info['dbname'];
	$host = $info['host'];
	
	try {
		$this->dbh = new PDO("mysql:host=$host;dbname=$dbname", $login, $pass);
	}
	catch(PDOException $e)
	{
		$jsonstring = json_encode('Connexion à la base de donnée impossible');
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
	}
}

public function reqLogin($login){
	
	$donnees = '';
	
	if(!empty($this->dbh)){
		$reqlogin = $this->dbh -> prepare('select * from user where login = ?');
	    $reqlogin -> execute(array($login));
	    $donnees = $reqlogin->fetch();
	    $reqlogin->closeCursor();
    }else{
	    $jsonstring = json_encode('erreur, il faut se connecter a la base de donnee');
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
        
    }
	
	if (empty($donnees['login']) && empty($donnees['mdp'])) {
        $jsonstring = json_encode('No login or passwords in database');
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
     }
     
     return $donnees;
	
}

public function reqBeginTraject($iduser){
	
	$donnees = '';
	
	if(!empty($this->dbh)){
	
		$reqtraject = $this -> dbh -> prepare("INSERT INTO trajet(id_user) VALUES(:iduser)");
	    $reqtraject -> execute(array(':iduser' => $iduser));
	    $donnees = $this->dbh->lastInsertId(); 
	    $reqtraject->closeCursor();
	    
    }
    else{
	    $jsonstring = json_encode('erreur, il faut se connecter a la base de donnee');
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
        
    }
    
    return $donnees;
}

public function reqEndTraject($idtraject, $time){
	
	$donnees = '';
	
	if(!empty($this->dbh)){
		$reqendtraject = $this -> dbh -> prepare("UPDATE trajet SET `fin` = :time where `id` = :idtraject");
	    $reqendtraject -> execute(array(
		    'time' => $time,
		    'idtraject' => $idtraject
	    ));
	    
	    $donnees = 'success'; 
	    $reqendtraject->closeCursor();
	    
    }
    else{
	    $jsonstring = json_encode('erreur, il faut se connecter a la base de donnee');
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
        
    }
    
    return $donnees;
}

public function reqLocation($idtraject, $longitude, $latitude, $vitesse){

	$donnees = '';

	if(!empty($this -> dbh)){
		
		$req = $this -> dbh -> prepare ("INSERT INTO localisation (`idtrajet`,`long`,`lat`,`vitesse`) VALUES(:idtraject, :long, :lat, :vitesse)");
        $req -> execute(array(
              'idtraject' => $idtraject,
              'long' => $longitude,
              'lat' => $latitude,
              'vitesse' => $vitesse
        ));
        
        $req->closeCursor();
        
        $donnees = 'success';
        
	}else{
		$jsonstring = json_encode('erreur, il faut se connecter a la base de donnee');
        header('Content-Type: application/json; charset=utf-8');
        echo $jsonstring;
	}
	
	return $donnees;
	
}

// Get id way(s) with 'iduser' and 'time' settings.
public function getInfos($iduser,$time){

	$donnees = '';

	if(!empty($this -> dbh)){
		
		$req = $this -> dbh -> prepare ("SELECT DISTINCT `id` FROM `trajet` WHERE `id_user` = :iduser AND DATE_FORMAT(`debut`,'%H:%i') = :time");
		// SELECT DISTINCT id FROM trajet WHERE id_user =1 AND DATE_FORMAT(  `debut` ,  '%H:%i' ) =  '18:42'
        $req -> execute(array(
        	"iduser" => $iduser,
        	"time" => $time
        ));
        $trajet = $req->fetch();
        //echo 'test';
        if(!empty($trajet)){
	        $req2 = $this -> dbh -> prepare ("SELECT DISTINCT `lat`, `long`, `vitesse` FROM `localisation` WHERE `idtrajet` = :idtrajet LIMIT 0,50");
	        $req2 -> execute(array("idtrajet" => $trajet['id']));
	        $donnees = $req2->fetchAll();
	        //print_r($donnees);
        }else{
	        $donnees = json_encode(array("status" => "no way at this time"));
        }
        // test $donnees et récupération de localisation si $donnees !empty puis return $donnee
        $req->closeCursor();
        
	}else{
		header('Content-Type: application/json; charset=utf-8');
		$jsonstring = json_encode(array("status" => "error"));
        echo $jsonstring;
	}
	
	return $donnees;
	
}


}


?>