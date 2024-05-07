define [
  'backbone.marionette'
], (Marionette) ->
  class FichaTecnicaView extends Marionette.ItemView
    template: '#covid-ficha-tecnica-main'
    className: 'container'
    onRender: () ->

  FichaTecnicaView