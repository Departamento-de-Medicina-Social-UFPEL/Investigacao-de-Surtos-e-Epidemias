define [
  './views/MainSelecaoView'
  './models/Caso'
  'backbone'
], (MainSelecaoView, Caso, Backbone) ->

  "mostraSelecaoCasos": (callback) ->
    return unless App.user
    coll = Backbone.Collection.extend
      model: Caso
    mainView = new MainSelecaoView
      collection: new coll(App.selecao.casos)
    App.main.show mainView

    callback.apply @ if callback
