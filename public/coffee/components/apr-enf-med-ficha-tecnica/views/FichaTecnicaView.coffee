define [
  'backbone.marionette'
], (Marionette) ->
  class FichaTecnicaView extends Marionette.ItemView
    template: '#apr-enf-med-ficha-tecnica-main'
    className: 'container'
    onRender: () ->

  FichaTecnicaView