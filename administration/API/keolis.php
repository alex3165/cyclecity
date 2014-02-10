<?php
	include ("../functions.php");

	$url = "http://data.keolis-rennes.com/xml/";
	$keoliskey = '8W28SF1V3D03O3V';
	$numberstation = '16';

	$parameter = array(
		'version' 			=> 	'2.0',
		'key' 				=> 	$keoliskey,
		'cmd' 				=> 	'getbikestations',
		'param[request]' 	=> 	'number',
		'param[value]' 		=> 	$numberstation
	);

	$data = post_it($parameter,$url);
	print_r($data);

	// http://data.keolis-rennes.com/xml/?version=1.0&key=xxxxxxxxxxxxxxxx&cmd=getstation&param[request]=number&param[value]=5
?>