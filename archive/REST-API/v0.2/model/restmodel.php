<?php

class RestModel {
	
	function response($response){
		if(!empty($response)){
			$jsonstring = json_encode($response);
	        header('Content-Type: application/json; charset=utf-8');
	        echo $jsonstring;
        }
	}
	
}

?>					