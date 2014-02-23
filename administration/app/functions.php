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

function generateKey() {
	$length = 10;
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, strlen($characters) - 1)];
    }
    return $randomString;
}

function connect(){
	$info = parse_ini_file("config.ini");

	$login = $info['login'];
	$pass = $info['pass'];
	$dbname = $info['dbname'];
	$host = $info['host'];
	
	try {
		$dbh = new PDO("mysql:host=$host;dbname=$dbname", $login, $pass);
		return $dbh;
	}
	catch(PDOException $e)
	{
		$connexion = false;
		return $connexion;
	}
}

function post_it($datastream, $url) { 

	$url = preg_replace("@^http://@i", "", $url);
	$host = substr($url, 0, strpos($url, "/"));
	$uri = strstr($url, "/"); 

      $reqbody = "";
      foreach($datastream as $key=>$val) {
          if (!empty($reqbody)) $reqbody.= "&";
      $reqbody.= $key."=".urlencode($val);
      } 

	$contentlength = strlen($reqbody);
	     $reqheader =  "POST $uri HTTP/1.1\r\n".
	                   "Host: $host\n". "User-Agent: PostIt\r\n".
	     "Content-Type: application/x-www-form-urlencoded\r\n".
	     "Content-Length: $contentlength\r\n\r\n".
	     "$reqbody\r\n"; 

	$socket = fsockopen($host, 80, $errno, $errstr);

	if (!$socket) {
	   $result["errno"] = $errno;
	   $result["errstr"] = $errstr;
	   return $result;
	}

	fputs($socket, $reqheader);

	while (!feof($socket)) {
	   $result[] = fgets($socket, 4096);
	}

	fclose($socket);

	return $result;
}


?>