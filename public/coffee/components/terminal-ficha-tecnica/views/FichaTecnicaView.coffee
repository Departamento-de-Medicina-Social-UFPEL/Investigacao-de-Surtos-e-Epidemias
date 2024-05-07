define [
  'backbone.marionette'
], (Marionette) ->
  class FichaTecnicaView extends Marionette.ItemView
    template: '#terminal-ficha-tecnica-main'
    className: 'container'
    onRender: () ->

  FichaTecnicaView