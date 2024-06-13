define [
  './views/FooterView'
], (TelaView) ->

  return (component, parentApp, Backbone, Marionette, $, _)->
    parentApp.hasFooter = true
    parentApp.footerView = new TelaView





