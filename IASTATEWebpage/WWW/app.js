'use strict';

(function(){
    // Declare app level module which depends on views, and components
    var app = angular.module('calebLogemann', [
        'ngRoute', 
        'calebLogemann.home', 
        'calebLogemann.coursework', 
        'calebLogemann.research',
        'calebLogemann.teaching'
    ]);

    app.config(['$routeProvider', function($routeProvider) {
        $routeProvider.otherwise({redirectTo: '/home'});
    }]);
})();
