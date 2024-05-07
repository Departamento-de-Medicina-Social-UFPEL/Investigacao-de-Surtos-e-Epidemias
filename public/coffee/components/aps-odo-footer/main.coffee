define [
  './views/FooterView'
], (TelaView) ->

  return (component, parentApp, Backbone, Marionette, $, _)->
    parentApp.hasFooter = on
    parentApp.footerView = new TelaView





