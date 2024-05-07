define [
  './models/Caso'
  './views/MainCasoLayout'
  './views/NotFound'
], (CasoModel, MainCasoView, NotFoundView) ->

  "mostraCaso": (id) ->
    return unless App.user
    App.main.once 'show', () ->
      setTimeout (()-> do window.$.material.init), 10

    caso = App.casos.findWhere _id: id.toLowerCase()
    ViewType = NotFoundView
    if caso
      ViewType = MainCasoView
      opt = {model: caso}
    mainView = new ViewType opt
    App.main.show mainView

