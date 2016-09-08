angular.module('Tally').controller(
  'VacationDaysController', [
  '$scope', 
  VacationDaysController
]);

function VacationDaysController($scope) {
  $scope.userId = null;
}