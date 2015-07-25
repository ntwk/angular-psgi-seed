angular.module('app', ['ngRoute'])

.config(function ($locationProvider) {
    $locationProvider.html5Mode(true);
});
