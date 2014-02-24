<?php

require_once __DIR__.'/../vendor/autoload.php';

$app = new Silex\Application();
$app['debug'] = true;

//Register services providers
$app->register(new DerAlex\Silex\YamlConfigServiceProvider(__DIR__ . '/settings.yml'));
$app->register(new Silex\Provider\TranslationServiceProvider(), array(
    'locale_fallbacks' => array('fr'),
    ));
$app->register(new Silex\Provider\DoctrineServiceProvider(), array('db.options' => $app['config']['database']));
$app['user.manager'] = $app->share(function($app) { return new SimpleUser\UserManager($app['db'], $app); });
$app->register(new Silex\Provider\SecurityServiceProvider(), array(
    'security.firewalls' => array(
        'login' => array(
            'pattern' => '^/login$',
            ),
        'secured' => array(
            'pattern' => '^.*$',
            'form' => array('login_path' => '/login', 'check_path' => '/login_check'),
            'logout' => array('logout_path' => '/logout'),
            'users' => $app['user.manager']
            ),
        )));
$app->register(new Silex\Provider\RememberMeServiceProvider());
$app->register(new Silex\Provider\SessionServiceProvider());
$app->register(new Silex\Provider\TwigServiceProvider(), array(
    'twig.path' => __DIR__.'/views',
    ));
$app->register(new Silex\Provider\UrlGeneratorServiceProvider());

use Symfony\Component\HttpFoundation\Request;
use Doctrine\DBAL\Schema\Table;
use Symfony\Component\Security\Core\Authentication\Token\UsernamePasswordToken;
use Symfony\Component\Translation\Loader\YamlFileLoader;

$app['translator'] = $app->share($app->extend('translator', function($translator, $app) {
    $translator->addLoader('yaml', new YamlFileLoader());
    $translator->addResource('yaml', __DIR__.'/locales/fr.yml', 'fr');
    return $translator;
}));

//Create shema
$schema = $app['db']->getSchemaManager();
if (!$schema->tablesExist('users')) {
    $users = new Table('users');
    $users->addColumn('id', 'integer', array('unsigned' => true, 'autoincrement' => true));
    $users->setPrimaryKey(array('id'));
    $users->addColumn('login', 'string', array('length' => 32));
    $users->addUniqueIndex(array('login'));
    $users->addColumn('name', 'string', array('length' => 100));
    $users->addColumn('password', 'string', array('length' => 255));
    $users->addColumn('salt', 'string', array('length' => 255));
    $users->addColumn('creation_time', 'integer', array('unsigned' => true));
    $users->addColumn('roles', 'string', array('length' => 255));

    $locations = new Table('location');
    $locations->addColumn('id', 'integer', array('unsigned' => true, 'autoincrement' => true));
    $locations->setPrimaryKey(array('id'));
    $locations->addColumn('lat', 'decimal', array('precision' => 65, 'scale' => 30));
    $locations->addColumn('long', 'decimal', array('precision' => 65, 'scale' => 30));
    $locations->addColumn('user_id', 'integer', array('unsigned' => true));
    $locations->addForeignKeyConstraint($users, array("user_id"), array("id"));

    $schema->createTable($users);
    $schema->createTable($locations);

    $user = $app['user.manager']->createUser('root', 'root', 'root', array('ROLE_ADMIN'));
    $app['user.manager']->insert($user);
}

//Controllers
$app->get('/login', function(Request $request) use ($app) {
    return $app['twig']->render('login.html.twig', array(
        'error'         => $app['security.last_error']($request),
        'last_username' => $app['session']->get('_security.last_username'),
        ));
});

$app->match('/', function(Request $request) use ($app) {
    if ($request->isMethod('POST')) {
        try {
            $user = $app['user.manager']->createUser(
                $request->request->get('login'),
                $request->request->get('password'),
                $request->request->get('name') ?: null,
                array('ROLE_ADMIN'));

            $errors = $app['user.manager']->validate($user);
            if (!empty($errors)) {
                throw new InvalidArgumentException(implode("\n", $errors));
            }
            $app['user.manager']->insert($user);
            $app['session']->getFlashBag()->set('alert', 'Account created.');

            // Log the user in to the new account.
            if (null !== ($current_token = $app['security']->getToken())) {
                $providerKey = method_exists($current_token, 'getProviderKey') ? $current_token->getProviderKey() : $current_token->getKey();
                $token = new UsernamePasswordToken($user, null, $providerKey);
                $app['security']->setToken($token);
            }

            return $app->redirect($app['url_generator']->generate('homepage'));

        } catch (InvalidArgumentException $e) {
            $error = $e->getMessage();
        }
    }

    return $app['twig']->render('register.html.twig', array(
        'error' => isset($error) ? $error : null,
        'name' => $request->request->get('name'),
        'login' => $request->request->get('login'),
        ));
})
->method('GET|POST')
->bind('homepage');

return $app;
