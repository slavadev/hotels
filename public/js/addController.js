(function () {

  'use strict';

  angular.module('app')
    .controller('addController', [
      'localStorageService',
      '$http',
      '$mdDialog',
      '$state',
      function (localStorageService, $http, $mdDialog, $state) {
        var vm = this;

        vm.hotels = [];

        $http.get('/api/v1/hotels').then(function (response) {
          vm.hotels = response.data;
        });

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

        vm.create = function () {
          var date = new Date(vm.date.getTime() - vm.date.getTimezoneOffset()*60*1000);
          var params = {token: token, hotel_id: vm.hotel_id, date: date};
          $http.post('/api/v1/bookings', params)
            .then(function successCallback() {
              $state.go('index');
            }, function errorCallback(response) {
              showErrors(response);
            });
        };
      }
    ]);
})();