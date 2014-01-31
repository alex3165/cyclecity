<?php

function hash_password($password){
  $salt = bin2hex(mcrypt_create_iv(32, MCRYPT_DEV_URANDOM));
  $hash = hash("sha256", $password . $salt);
  return $salt . $hash;
}


function check_password($password, $dbhash){
  $salt = substr($dbhash, 0, 64);
  $valid_hash = substr($dbhash, 64, 64);
  $test_hash = hash("sha256", $password . $salt);
  return $test_hash === $valid_hash;
}



function connect($hostname,$dbname,$username,$password){
	try {
		$dbh = new PDO("mysql:host=$hostname;dbname=$dbname", $username, $password);
		return $dbh;
	}
	catch(PDOException $e)
	{
		$connexion = false;
		return $connexion;
	}
}

?>