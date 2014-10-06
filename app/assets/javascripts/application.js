// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// Require basic js libs:
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require underscore/underscore-min
//
// Require bower components
//= require angular/angular
//= require restangular/dist/restangular.min
//= require angular-ui-select/dist/select.min
//= require d3/d3.min
//= require nvd3/nv.d3.min
//= require angular-nvd3/dist/angular-nvd3.min
//
// Require angular app itself:
//= require ./application/rubbbyApp

$(document).on('ready page:load', function() {
  angular.bootstrap('body', ['rubbbyApp'])
})