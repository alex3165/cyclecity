<?php
session_start();
include('define.php');

// On récupère la page souhaitée par l'utilisateur
$p = (!empty($_GET['p'])) ? htmlentities($_GET['p']) : 'log';

 // if (!empty($_GET['p'])) {
 // 	echo $_GET['p'];
 // }

// On répertorie les pages accessibles
$array_pages = array(
	'index' => 'index.php',
	'log' 	=> VIEW.'logview.php',
	'admin' => VIEW.'adminview.php'
);

// On dirige l'utilisateur
if(!array_key_exists($p, $array_pages)) $page = 'index.php';
elseif(!is_file($array_pages[$p])) $page = 'erreur.php';
else $page = $array_pages[$p];


if ($page == 'rest.php') {
	include($page);
}else{
	include(MODEL.'functions.php'); // Insertion du fichier de configuration
	include(VIEW.'head.php');   	// Insertion de l'en-tête commun à toutes les pages
	include($page);	   				// Insertion de la page requise
}




?>