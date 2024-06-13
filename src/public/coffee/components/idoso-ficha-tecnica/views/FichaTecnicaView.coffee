define [
  'backbone.marionette'
], (Marionette) ->
  class FichaTecnicaView extends Marionette.ItemView
    template: '#idoso-ficha-tecnica-main'
    className: 'container'
    onRender: () ->

  FichaTecnicaView