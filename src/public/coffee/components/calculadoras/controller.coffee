define [
  './views/CalculadorasModuloView'
  'backbone'
], (CalculadorasModuloView, Backbone) ->

  "iniciaPagina": (callback) ->
    appComponent = _.findWhere(window.modulo.components, {folder: 'calculadoras'})
    m = new Backbone.Model appComponent
    console.log appComponent, 'calculadoras', m

    mainView = new CalculadorasModuloView
      model: m
    App.main.show mainView

    callback.apply @ if callback
 