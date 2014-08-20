var ccApp = angular.module('numeractive', ['ui.router']);

ccApp.config(['$urlRouterProvider', '$stateProvider', '$provide',
	function($urlRouterProvider, $stateProvider, $provide) {
		$urlRouterProvider.otherwise('/');

		$stateProvider
		.state('timeline',{
			url: '/timeline',
			templateUrl: '/timeline',
			controller: 'timeline'
		})
		.state('slide',{
			url: '/slide/:id',
			templateUrl: '/slide/id',
			controller: 'slide'
		})

	}
]);

ccApp.controller('timeline', ['$scope', function($scope){



}]);