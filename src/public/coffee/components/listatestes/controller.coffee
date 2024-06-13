define [
  './views/TestesView'
  'backbone'
], (TestesView, Backbone) ->

  "iniciaPagina": (callback) ->

    mainView = new TestesView()
    App.main.show mainView

    console.log "App.main.show mainView", mainView

    callback.apply @ if callback


