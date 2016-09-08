angular.module('UserProfile').directive('editableField', 
  [
    'UserService',
    EditableField
  ]);

function EditableField(UserService) {
  return {
    restrict: 'E',
    template: '<b>{{value}}</b><input type="text" value="{{value}}" style="display: none" />',
    scope: {
        value: '@',
        field: '@',
        id: '@'
    },
    link: function($scope, element, attrs) {
      var label = element.find('b');
      var field = element.find('input');

      element.click(function() {
        label.hide();
        field.show();
        field.focus();
      });

      element.find('input').focusout(function() {
        var newValue = field.val();
        if (newValue) {
          $scope.value = newValue; 
          label.text($scope.value);
          field.hide();
          label.show();

          params = {} 
          params[$scope.field] = $scope.value;
          UserService.update($scope.id, params);
        }
      });
    }
  }
}