define [
  'backbone.marionette'
], (Marionette) ->
  class CalculadorasView extends Marionette.ItemView
    template: '#calculadoras-main'
    className: 'container impressos-container'

    onRender: () ->
    	console.log @model, 'model'

  CalculadorasView