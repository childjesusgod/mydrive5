'use strict'

describe 'Directive: myPage', ->

  # load the directive's module
  beforeEach module 'mydrive5App'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<my-page></my-page>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the myPage directive'
