'use strict'

describe 'Directive: myNavbar', ->

  # load the directive's module and view
  beforeEach module 'mydrive5App'
  beforeEach module 'components/mysite/myNavbar/myNavbar.html'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<my-navbar></my-navbar>'
    element = $compile(element) scope
    scope.$apply()
    expect(element.text()).toBe 'this is the myNavbar directive'

