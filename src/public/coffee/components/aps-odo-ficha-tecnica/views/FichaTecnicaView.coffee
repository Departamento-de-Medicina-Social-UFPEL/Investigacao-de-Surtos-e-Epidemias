define [
  'backbone.marionette'
], (Marionette) ->
  class FichaTecnicaView extends Marionette.ItemView
    template: '#aps-odo-ficha-tecnica-main'
    className: 'container'
    onRender: () ->

  FichaTecnicaView