
requirejs.config
  'baseUrl': '/casca'
  'waitSeconds': 100
  'paths':
    'utils': 'js/lib/utils'
    'jquery': 'lib/jquery/dist/jquery'
    'underscore': 'lib/lodash/lodash'
    'backbone': 'lib/backbone/backbone'
    'backbone.marionette': 'lib/backbone.marionette/lib/backbone.marionette'
    'bootstrap': 'lib/bootstrap/dist/js/bootstrap'

  'map': '*': 'marionette': 'backbone.marionette'

  'shim':
    'bootstrap': 'deps': ['jquery']
    'backbone.marionette': 'deps': ['jquery', 'backbone']

require ['marionette'], (Marionette)->

  class InfoBiblio extends Marionette.View
    'initialize': ()-> @bindUIElements()
    'events':
      'mouseup': 'checkSelection'

    'ui':
      'content': '.content'
      'externo': '.externo'
      'local': '.local'

    'checkSelection': (evt) ->
      sel = do @getSelection
      if sel
        console.log sel
      else
        console.log 'nada'

    'getSelection': (evt) ->
        if window.getSelection
          window.getSelection().toString()
        else if (document.selection && document.selection.type != "Control")
          document.selection.createRange().text
        else null


  class InputBiblioIn extends Marionette.View
    'events':
      'change': 'updateInfo'

    'updateInfo': (evt) ->
      try
        obj = (new Function("return #{@$el.val()}"))()

      if obj
        App.info.$el.show()
        App.info.ui.content.text obj.linkTitulo
        App.info.ui.externo.attr 'href', obj.urlExterno
        App.info.ui.local.attr 'href', obj.urlLocal

  class Biblio extends Marionette.Application
    'start': () ->
      @input = new InputBiblioIn
        'el': '.bib-in'

      @output = new Marionette.View
        'el': '.bib-out'

      @info = new InfoBiblio
        'el': '.bib-info'

      do @info.$el.hide

      console.log 'start'

  window.App = new Biblio

  do App.start



# arr = [
#   {
#     "ano": "2004"
#     "autor": "BRASIL. Ministério da Saúde. Secretaria de Atenção à Saúde. Instituto Nacional de Câncer."
#     "titulo": "TNM: classificação de tumores malignos."
#     "etc":"281p. 6 ed. Rio de Janeiro: INCA/UICC,"
#     "url": "TNM.pdf"
#   }
# ]