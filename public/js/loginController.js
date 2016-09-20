(function () {

  'use strict';

  angular.module('app')
    .controller('loginController', [
      'localStorageService',
      '$http',
      '$mdDialog',
      '$state',
      function (localStorageService, $http, $mdDialog, $state) {
        var vm      = this;
        vm.email    = '';
        vm.password = '';

        var showErrors = function (response) {
          var text = '';
          angular.forEach(response.data, function (errors, name) {
            text = text + name + ': ' + errors.join(', ') + '; ';
          });
          $mdDialog.show(
            $mdDialog.alert()
              .parent(angular.element(document.querySelector('body')))
              .clickOutsideToClose(true)
              .title('There are some errors:')
              .textContent(text)
              .ok('OK')
          );
        };

        vm.login = function () {
          var params = {email: vm.email, password: vm.password};
          $http.post('/api/v1/user/login', params)
            .then(function successCallback(response) {
              localStorageService.set("token", response.data.token);
              $state.go('index');
            }, function errorCallback(response) {
              showErrors(response);
            });
        };

        vm.register = function () {
          var params = {email: vm.email, password: vm.password};
          $http.post('/api/v1/user/register', params)
            .then(function successCallback() {
              vm.login();
            }, function errorCallback(response) {
              showErrors(response);
            });
        };
      }
    ]);
})();