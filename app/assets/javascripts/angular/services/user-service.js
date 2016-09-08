angular.module('UserProfile').service('UserService', [
  '$http',
  UserService
]);

function UserService($http) {
  return {
    update: function(id, params) {
      return $http.put(id, { 'user': params });
    }
  }
}