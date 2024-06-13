define [
  './views/MateriaisModuloView'
  'backbone'
], (MateriaisModuloView, Backbone) ->

  "iniciaPagina": (callback) ->

    mainView = new MateriaisModuloView
      model: (new Backbone.Model App.materiais)
    App.main.show mainView

    callback.apply @ if callback


