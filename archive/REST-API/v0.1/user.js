var Person = function () {

    /*******************
        Constructor JS
    *******************/
    this.id = '';
    this.name = '';
    this.token = '';

    var localisation = {
        latitude : '',
        longitude : ''
    };

    /************************************
        Functions de la Class JS
    *************************************/
    this.setIdentity = function(id, name, token){
        this.id = id;
        this.name = name;
        this.token = token;
    };

};