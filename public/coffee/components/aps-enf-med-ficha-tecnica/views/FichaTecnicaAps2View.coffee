define [
  'backbone.marionette'
], (Marionette) ->
  class FichaTecnicaAps2View extends Marionette.ItemView
    template: '#aps-enf-med-ficha-tecnica-main-2'
    className: 'container'
    onRender: () ->

  FichaTecnicaAps2View