'use strict';

(function (){
    var teachingModule = angular.module('calebLogemann.teaching', [
        'ngRoute'
    ]);

    teachingModule.config(['$routeProvider', function($routeProvider) {
        $routeProvider.when('/teaching', {
            templateUrl: 'teaching/teaching.html',
            controller: 'teachingController'
        });
    }]);

    teachingModule.controller('teachingController', [function() {

    }]);
})();
