$(document).ready(function () {
    

    var idmap = 'alex3165.h4m66jp2';
    MakeMap(idmap);

    // Requete API Keolis en ajax à finir
    $('#request').on('click', function(event) {
        var button = $(this);
        event.preventDefault();

        KeolisRequest();
        //console.log(datas);
        /* idéalement traitement de l'objet 'response' ici */
    });

});


/*****************************
        FUNCTIONS
*****************************/


function MakeMap(id) {
    var tiles = L.mapbox.tileLayer(id);
    var map = L.mapbox.map('map',id);
}

function KeolisRequest(){
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


    var success = function( ResponseObject ) {
        response = ResponseObject.opendata.answer.data;
    };

    var err = function( req, status, err ) {
        response = err;
    };

    req.then( success, err );
    // return response;
}

