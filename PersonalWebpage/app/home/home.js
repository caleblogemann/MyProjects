'use strict';

(function (){
    var homeModule = angular.module('calebLogemann.home', [
        'ngRoute'
    ]);

    homeModule.config(['$routeProvider', function($routeProvider) {
        $routeProvider.when('/home', {
            templateUrl: 'home/home.html',
            controller: 'homeController'
        });
    }]);

    homeModule.controller('homeController', [function() {

    }]);
})();
