define [
  './views/BibliografiaModuloView'
  'backbone'
], (BibliografiaModuloView, Backbone) ->

  "iniciaPagina": (callback) ->

    mainView = new BibliografiaModuloView
      model: App.bibliografia
    App.main.show mainView

    callback.apply @ if callback


