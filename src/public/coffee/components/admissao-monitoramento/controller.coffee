define [
  './views/admissao'
  'backbone'
], (AdmissaoView, Backbone) ->

  "iniciaPagina": (callback) ->
    {user, progresso} = App
     

    mainView = new AdmissaoView
      model: new Backbone.Model 
    App.main.once 'show', () ->
      setTimeout (()-> do window.$.material.init), 10
    App.main.show mainView

    callback.apply @ if callback

