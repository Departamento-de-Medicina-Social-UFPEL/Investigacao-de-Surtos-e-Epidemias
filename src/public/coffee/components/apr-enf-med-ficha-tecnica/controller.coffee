define [
  './views/FichaTecnicaView'
  'backbone'
], (FichaTecnicaView, Backbone) ->

  "iniciaPagina": (callback) ->

    mainView = new FichaTecnicaView
    App.main.show mainView

    callback.apply @ if callback