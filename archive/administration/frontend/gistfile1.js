$(document).ready(function () {
    

    var idmap = 'alex3165.h4m66jp2';
    var tiles = L.mapbox.tileLayer(idmap);
    var map = L.mapbox.map('map',idmap);
    //MakeMap(idmap);
    var data;

    // Requete API Keolis en ajax à finir
    $('#request').on('click', function(event) {
        var button = $(this);
        event.preventDefault();
        
        var success = function( ResponseObject ) {
            data = ResponseObject.opendata.answer.data;
            for (var i = 0; i < data.station.length; i++) {
                //console.log(data.station[i].latitude);
                L.marker([data.station[i].latitude, data.station[i].longitude]).addTo(map);
            }
            //console.log(data.station[0].latitude);
        };

        KeolisRequest(success);

        // setTimeout(function() {
        //     console.log(data);
        // }, 2000);
        //console.log(datas);
        /* idéalement traitement de l'objet 'response' ici */
    });

});


/*****************************
        FUNCTIONS
*****************************/


// function MakeMap(id) {
    
// }

function KeolisRequest(success){
    var response;
    var urlrequest = "http://data.keolis-rennes.com/json/";
    var value = ["2.0", "8W28SF1V3D03O3V", "getbikestations"];
    var req = $.ajax({
        url: urlrequest,
        crossDomain: true,
        type: "post",
        dataType: "json",
        data: {
            version : value[0],
            key : value[1],
            cmd : value[2]
        }
    });

    var err = function( req, status, err ) {
        response = err;
    };

    req.then( success, err );
    // return response;
}
