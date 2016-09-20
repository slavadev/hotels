(function () {

  'use strict';

  angular.module('app')
    .controller('indexController', [
      'localStorageService',
      '$http',
      '$mdDialog',
      '$state',
      function (localStorageService, $http, $mdDialog, $state) {
        var vm = this;

        var token = localStorageService.get("token");
        if(!token){
          $state.go('login');
        }

        var showErrors = function (response) {
          if(response.status == 401) {
            localStorageService.remove("token");
            $state.go('login');
          } else {
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
          }
        };

        vm.bookings = [];
        function loadBookings() {
          $http.get('/api/v1/bookings/my?token=' + token)
            .then(function successCallback(response) {
              vm.bookings = response.data;
              vm.loaded = true;
            }, function errorCallback(response) {
              showErrors(response);
            });
        }
        loadBookings();


        vm.destroy = function (booking) {
          $http.delete('/api/v1/bookings/' + booking.id + '?token=' + token)
            .then(function successCallback() {
              loadBookings();
            }, function errorCallback(response) {
              showErrors(response);
            });
        };

        vm.logout = function () {
          localStorageService.remove("token");
          $state.go('login');
        }
      }
    ]);
})();