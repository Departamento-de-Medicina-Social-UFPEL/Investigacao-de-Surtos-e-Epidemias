define [
  'backbone.marionette'
], (Marionette) ->
  class FichaTecnicaView extends Marionette.ItemView
    template: '#aps-enf-med-ficha-tecnica-main'
    className: 'container'
    onRender: () ->

  FichaTecnicaView