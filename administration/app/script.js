// Créer une classe utilisateur (name, id, sessionkey, long, lat)

var mypos ={
    latitude : '',
    longitude : ''
};

var id;
var _key;

var actualuser = new Person();


/*******************************

    Test de localisation en JS

*******************************/

$(document).ready(function() {

    // Dès que le document est chargé on récupère la position de l'utilisateur et on la stock dans mypos

    var showLocation = function(position){
        // mypos.latitude = position.coords.latitude;
        // mypos.longitude = position.coords.longitude;
        actualuser.localisation = {
            latitude : position.coords.latitude,
            longitude : position.coords.longitude
        };
        //console.log(mypos.latitude+" "+mypos.longitude);
    };
    
    if(navigator.geolocation)
    {
        navigator.geolocation.getCurrentPosition(showLocation, errorHandler, {enableHighAccuracy:false, maximumAge:60000, timeout:27000});
    }
    else
    {
        alert('Votre navigateur ne prend malheureusement pas en charge la géolocalisation.');
    }

});

/*****************************************************************************************/


$('#reqlog .btn').on('click', function(event) {
    event.preventDefault();

    var _params = {
        login : 'ohoh',
        mdp : 'uhuh'
    };
    //console.log ($('#login').val);
    var success = function(data){

        actualuser.setIdentity(data[0].id,data[0].name,data[0].key); // Fonction setIdentity de user.js avec les datas de la requête POST

        $('#reqapp').html('<button type="button" class="btn btn-default">ReqApp</button>');
        $('#user h1').html('Bonjour '+ actualuser.name + ' vous pouvez faire une nouvelle requête');
        
        $('#reqapp .btn').on('click', function(event) {
            event.preventDefault();
            console.log(actualuser);
            var _paramsapp = {
                key : actualuser.token,
                long : actualuser.localisation.longitude,
                lat : actualuser.localisation.latitude
            };

            var successapp = function(data){
                console.log(data);
            };

            postRequest('app.php',_paramsapp, successapp);

        });
    };

    postRequest('login.php',_params, success);


});




/*******************************

        LES FONCTIONS

********************************/


// Fonction de gestion des erreurs
function errorHandler(error)
{
    console.log('Geolocation error : code '+ error.code +' - '+ error.message);
    alert('Une erreur est survenue durant la géolocalisation. Veuillez réessayer plus tard ou contacter le support.');
}



function postRequest(page, params, success){

var req = $.ajax({
    type: 'POST',
    url: page,
    timeout: 3000,
    dataType: "json",
    data: params
});

var error = function(err){
    console.log(err);
};

req.then( success, error );

}


