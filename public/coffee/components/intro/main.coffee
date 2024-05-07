define [
  './views/telaView'
], (TelaView) ->

  return (component, parentApp, Backbone, Marionette, $, _)->
    parentApp.hasIntro = true
    parentApp.introView = new TelaView





