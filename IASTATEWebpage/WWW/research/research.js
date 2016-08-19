'use strict';

(function (){
    var researchModule = angular.module('calebLogemann.research', [
        'ngRoute'
    ]);

    researchModule.config(['$routeProvider', function($routeProvider) {
        $routeProvider.when('/research', {
            templateUrl: 'research/research.html',
            controller: 'researchController'
        });
    }]);

    researchModule.controller('researchController', [function() {

    }]);
})();
