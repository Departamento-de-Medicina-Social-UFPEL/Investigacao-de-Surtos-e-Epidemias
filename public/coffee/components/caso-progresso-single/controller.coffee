define [
  './models/Caso'
  './views/MainCasoLayout'
  './views/NotFound'
], (CasoModel, MainCasoView, NotFoundView) ->

  "mostraCaso": () ->

    App.main.once 'show', () ->
      setTimeout (()-> do window.$.material.init), 10


    caso = App.casos.findWhere _id: App.caso._id

    ViewType = NotFoundView

    if caso
      ViewType = MainCasoView
      opt = {model: caso}

    mainView = new ViewType opt
    App.main.show mainView

