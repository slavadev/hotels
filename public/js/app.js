(function () {

  'use strict';

  angular.module('app', ['ngResource', 'ngMaterial', 'ui.router', 'LocalStorageModule'])
    .config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
      var loginState = {
        name: 'login',
        url: '/login',
        controller  : "loginController",
        controllerAs: "loginCtrl",
        templateUrl: '/templates/login.html'
      };

      var indexState = {
        name: 'index',
        url: '/index',
        controller  : "indexController",
        controllerAs: "indexCtrl",
        templateUrl: '/templates/index.html'
      };

      var addState = {
        name: 'add',
        url: '/add',
        controller  : "addController",
        controllerAs: "addCtrl",
        templateUrl: '/templates/add.html'
      };

      $urlRouterProvider.otherwise('/login');
      $stateProvider.state(loginState);
      $stateProvider.state(indexState);
      $stateProvider.state(addState);
    }]);
})();