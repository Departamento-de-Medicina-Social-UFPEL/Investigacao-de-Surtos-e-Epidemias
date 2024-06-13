define [
  'backbone.marionette'
], (Marionette) ->
  class FichaTecnicaView extends Marionette.ItemView
    template: '#investigacao-surtos-ficha-tecnica-main'
    className: 'container'
    onRender: () ->

  FichaTecnicaView