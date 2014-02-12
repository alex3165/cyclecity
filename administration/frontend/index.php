<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>interactive map visualisation</title>
                                <!--      javascripts      -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="../dist/js/bootstrap.min.js"></script>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.2/underscore-min.js"></script>
        <script src='//api.tiles.mapbox.com/mapbox.js/v1.6.1/mapbox.js'></script>
                                <!--      stylesheets      -->
        <link rel="stylesheet" href="../dist/css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="../dist/css/bootstrap.min.css">
        <link href='//api.tiles.mapbox.com/mapbox.js/v1.6.1/mapbox.css' rel='stylesheet' />
        <link rel="stylesheet" href="style.css">

    </head>
    <body>
        <style>
            body { margin:0; padding:0; }
            #map { position:absolute; top:0; bottom:0; width:100%; }
        </style>
        <div id="map"></div>
        
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6 col-md-offset-3 text-center"> 
                    <button type="button" class="btn btn-default" id="request">requete</button>
                </div>
            </div>
        </div>
        
        
        <script src="rest.js"></script>
        <script src="mymap.js"></script>
    </body>
</html>