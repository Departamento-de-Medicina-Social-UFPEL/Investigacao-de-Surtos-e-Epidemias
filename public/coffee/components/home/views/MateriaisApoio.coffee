define [
  'backbone.marionette'
], (Marionette) ->
  class MateriaisView extends Marionette.ItemView
    template: '#home-materiais'
    className: 'container impressos-container'

    onRender: () ->

  MateriaisView