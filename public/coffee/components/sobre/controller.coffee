define [
  './views/MainLayoutView'
  './views/TBSCarourel'
  'backbone'
], (MainLayoutView, Carousel, Backbone) ->

  "iniciaPagina": (callback) ->

    mainView = new MainLayoutView
    App.main.show mainView

    console.log "App.main.show mainView", mainView

    callback.apply @ if callback


