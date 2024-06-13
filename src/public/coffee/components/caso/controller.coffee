define [
  './models/Caso'
  './views/MainCasoLayout'
  './views/NotFound'
], (CasoModel, MainCasoView, NotFoundView) ->

  "mostraCaso": (id) ->

    App.main.once 'show', () ->
      setTimeout (()-> do window.$.material.init), 10
    casosColl = App.casos || window.casos
    caso = _.findWhere casosColl, _id: id.toLowerCase()
    ViewType = NotFoundView
    if caso
      ViewType = MainCasoView
      opt = {model: new CasoModel caso}
    mainView = new ViewType opt
    App.main.show mainView

