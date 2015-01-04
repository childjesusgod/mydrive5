'use strict'

# USING THE BOWER COMPONENT FOR HTE MOMENT!!!!!

angular.module 'mydrive5App'
# directive for compiling html
.directive "compileHtml", ($parse, $sce, $compile)->
  restrict: "A"
  scope:
    'message':'=compileHtml'
  link: (scope, element, attributes)->
    expression = $sce.trustAsHtml(scope.message).toString()
    element.append expression



.directive 'editorContainer', ->
  template:"<div class='editor-container'>"+
    "<div class='editor-vline right'></div>"+
    "<div class='editor-vline'></div>"+
    "<div class='editor-hline bottom'></div>"+
    "<div class='editor-hline'></div>"+
    "<div ng-transclude='true'></div>"+
    "</div>"
  transclude:true
  restrict:'EA'
  scope:true
  link: (scope,element,attrs)->



# directive for the CKE editor
.directive 'ckedit', ($parse)->
  
  CKEDITOR.disableAutoInline = true
  counter = 0
  prefix = '__ckd_'
  

  template: '<div></div>'
  restrict: 'EA'
  link: (scope, element, attrs) ->
    getter = $parse(attrs.ckedit)
    setter = getter.assign;

    attrs.$set 'contenteditable', true
    if !attrs.id
      attrs.$set 'id', prefix + (++counter)


    CKEDITOR.plugins.registered['save'] =
      init:(editor)->
        editor.addCommand 'save',
          modes: { wysiwyg: 1, source: 1 },
          exec: (editor)->
            if (editor.checkDirty())
              ckValue = editor.getData()
              scope.$apply ->
                setter(scope, ckValue)
              ckValue = null
              editor.resetDirty()
        editor.ui.addButton 'Save',
          label: 'Save'
          command: 'save'
          toolbar: 'document'
    
    options = {}
    options.on =
      blur: (e) ->
        if (e.editor.checkDirty())
          ckValue = e.editor.getData()
          scope.$apply ->
            setter(scope, ckValue)
          ckValue = null
          e.editor.resetDirty()

    options.extraPlugins = 'sourcedialog'
    options.removePlugins = 'sourcearea'
    editorangular = CKEDITOR.inline element[0], options

    scope.$watch attrs.ckedit, (value)->
      editorangular.setData(value)