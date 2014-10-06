@controllers.controller('ProjectShowCtrl', [
  '$scope'
  'Restangular'

  ($scope, Restangular) ->

    colorArray = ['red', 'green']

    $scope.chartOpts = {
      chart: {
        type: 'pieChart',
        donut: true,
        x: (d) -> d.key,
        y: (d) -> d.y,
        height: 70,
        width: 70,
        showLegend: false,
        showLabels: false,
        tooltips: false,
        donutRatio: 1
        margin: {
          top: 2,
          left: 2,
          bottom: 2,
          right: 2
        },
        color: (d, i) -> d.data.color
      }
    }

])