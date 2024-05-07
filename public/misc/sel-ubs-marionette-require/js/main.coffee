define [
  'js/ubsFormLayout'
  'uf_municipios'
], (UbsFormLayout)->

  class ExemploAppUbs extends Marionette.Application
    regions:
      container: '.local-form-container'
    initialize: ->
      @container.show new UbsFormLayout