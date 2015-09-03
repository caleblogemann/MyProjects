'use strict';

(function (){
    var courseworkModule = angular.module('calebLogemann.coursework', [
        'ngRoute'
    ]);

    courseworkModule.config(['$routeProvider', function($routeProvider) {
        $routeProvider.when('/coursework', {
            templateUrl: 'coursework/coursework.html',
            controller: 'courseworkController'
        });
    }]);

    courseworkModule.controller('courseworkController', [function() {

    }]);
})();
