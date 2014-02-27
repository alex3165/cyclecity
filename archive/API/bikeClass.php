<?php 

/**
* Infos des vélos disponibles dans la station
*/
class bikestation {
	var $station;

	function create($numberstation,$long,$lat,$slotavailable,$bikeavailable) {
		this -> $station = array (
			'number' => $numberstation,
			'longitude' => $long,
			'latitude' => $lat,
			'slotavailable' => $slotavailable,
			'station_bikeavailable' => $bikeavailable
		);
	}

	function get_coordination() {
		return $station['longitude']." ".$station['latitude'];
	}
}

 ?>