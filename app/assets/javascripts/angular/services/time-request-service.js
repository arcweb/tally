angular.module('Tally').service('TimeRequestService', [
  '$http',
  TimeRequestService
]);

function TimeRequestService($http) {
  var time_requests = [];

  return {
    pending: function() {
      return $http.get('/time_requests/pending');
    },
    clear: function(id) {
      return $http.get("/time_requests/" + id + "/clear");
    }
  }
}
