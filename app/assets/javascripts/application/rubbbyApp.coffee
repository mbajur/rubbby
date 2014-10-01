#= require_self
#= require_tree ./controllers

rubbbyApp = angular.module "rubbbyApp", [
  'restangular'
  'ui.select'

  'rubbbyApp.controllers'
]

# Config
rubbbyApp.config([
  'RestangularProvider'

  (RestangularProvider) ->

    # Config API base url
    RestangularProvider.setBaseUrl('/api/v1/')
])

# Controllers
@controllers = angular.module('rubbbyApp.controllers', [])