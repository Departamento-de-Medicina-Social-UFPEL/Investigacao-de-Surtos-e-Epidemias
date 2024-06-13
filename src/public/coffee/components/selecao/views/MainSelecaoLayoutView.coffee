define [
  'marionette'
], (Marionette) ->
  class MainSelecaoLayout extends Marionette.LayoutView
    template: '#selecao-main'
    className: 'container selecao-main'
    onRender: ->
      console.log "MainSelecaoLayout::onRender"
