define [
  './home/HomeComp'
  './interna/AmbienteView'
  'backbone'
], (HomeCompositeView, AmbienteView, Backbone) ->

  "iniciaPagina": (callback) ->

    mainView = new HomeCompositeView
    App.main.show mainView

    callback.apply @ if callback

  "carregaAmbiente": (ambiente) ->
    model = App.quedas.findWhere 'folder': ambiente
    App.main.show new AmbienteView {model}


