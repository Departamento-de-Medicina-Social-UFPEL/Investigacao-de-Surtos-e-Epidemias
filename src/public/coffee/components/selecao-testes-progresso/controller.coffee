define [
  './views/MainSelecaoView'
  'backbone'
], (MainSelecaoView, Backbone) ->

  "mostraSelecaoCasos": (callback) ->
    console.log "mostraSelecaoCasos"
    return unless App.user
    mainView = new MainSelecaoView
      collection: App.testes
    App.main.show mainView

    callback.apply @ if callback
