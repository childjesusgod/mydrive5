'use strict'

angular.module 'mydrive5App'
.directive 'analytics', ->
  restrict: 'A',
  scope:
    id: '@analytics'
  link: (scope, element, attrs)->
    ((i, s, o, g, r, a, m) ->
      i["GoogleAnalyticsObject"] = r
      i[r] = i[r] or ->
        (i[r].q = i[r].q or []).push arguments
        return
      i[r].l = 1 * new Date()
      a = s.createElement(o)
      m = s.getElementsByTagName(o)[0]
      a.async = 1
      a.src = g
      m.parentNode.insertBefore a, m
      return
    ) window, document, "script", "//www.google-analytics.com/analytics.js", "ga"

    setGoogleId=(id)->
      ga('create', id, { 'cookieDomain': 'none' })

    attrs.$observe 'id', (newId)->
      if (newId)
        setGoogleId(newId)

    if typeof scope.id != 'undefined' then setGoogleId(scope.id)