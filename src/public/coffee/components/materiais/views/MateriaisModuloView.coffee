define [
  'backbone.marionette'
], (Marionette) ->
  class MateriaisView extends Marionette.ItemView
    template: '#materiais-main'
    className: 'container impressos-container'

    onRender: () ->

  MateriaisView