define [
  './views/FichaTecnicaView'
  './views/FichaTecnicaAps2View'
  'backbone'
], (FichaTecnicaView, FichaTecnicaAps2View, Backbone) ->

  "iniciaPagina": (callback) ->

    mainView = new FichaTecnicaView
    App.main.show mainView

    callback.apply @ if callback

  "iniciaPagina2": (callback) ->

    mainView = new FichaTecnicaAps2View
    App.main.show mainView

    callback.apply @ if callback