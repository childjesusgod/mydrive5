angular.module 'mydrive5App'
.config ($stateProvider) ->
  $stateProvider
  .state 'app.admin.sites.site.forms',
    url: '/forms'
    templateUrl:'app/admin/sites/site/forms/forms.html'
    controller: 'FormsCtrl'
    data:
      title: '{{site.siteName}} Forms'


      