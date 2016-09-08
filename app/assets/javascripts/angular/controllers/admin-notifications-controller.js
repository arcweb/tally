angular.module('Tally').controller('AdminNotificationsController', [
  'TimeRequestService',
  AdminNotificationsController
]);

function AdminNotificationsController(TimeRequestService) {

  var self = this;
  self.timeAgo = timeAgo;
  self.clearRequest = clearRequest;
  self.needsApproval = needsApproval;

  self.pending_requests = [];

  TimeRequestService.pending()
    .success(function(data) {
      self.pending_requests = data;
      // if (!$scope.$$phase) {
      //   $scope.$apply();
      // }
    });

  function timeAgo(date) {
    return moment(date).fromNow();
  }

  function clearRequest($event, request) {
    var el = $event.currentTarget;
    $(el).closest('li').slideUp();
    TimeRequestService.clear(request.id);
  }

  function needsApproval(request) {
    return request.class_name === 'PtoTimeRequest' || request.class_name === 'CancelPtoTimeRequest';
  }
}
