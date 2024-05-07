define [
  './views/MainSelecaoLayoutView'
], (MainSelecaoView) ->

  "mostraSelecaoCasos": (callback) ->
    console.log this
    mainView = new MainSelecaoView
    App.main.show mainView

    callback.apply @ if callback
