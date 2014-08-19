<?php
/*
* 
* Cyclecity API V0.1
*
*/

/* Php service configuration */
require_once __DIR__.'/../vendor/autoload.php';

$app = new Silex\Application();

$app['debug'] = true;

/* DB Register configuration */
$app->register(new Silex\Provider\DoctrineServiceProvider(), array(
    'db.options' => array(
        'driver' => 'pdo_mysql',
        'dbhost' => 'localhost',
        'dbname' => 'cyclecity',
        'user' => 'root',
        'password' => '',
    ),
));

$app->register(new Silex\Provider\TwigServiceProvider(), array(
    'twig.path' => __DIR__.'/views',
));


$app->get('/', function() use ($app){
	return $app['twig']->render('index.html.twig');
});

$app->run();