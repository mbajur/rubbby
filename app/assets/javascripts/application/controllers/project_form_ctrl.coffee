@controllers.controller('ProjectFormCtrl', [
  '$scope'
  'Restangular'

  ($scope, Restangular) ->

    $scope.item = {}
    $scope.tags = []

    Restangular.one('tags').get().then (results) ->
      $scope.tags = results

    $scope.setTags = (tagIds) ->
      console.log tagIds

])