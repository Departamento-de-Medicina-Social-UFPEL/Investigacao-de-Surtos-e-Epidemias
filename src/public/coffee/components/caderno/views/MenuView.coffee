define [
  './MenuItemAcaoView'
  'marionette'
], (MenuItemAcaoView, Marionette) ->

  class MenuView extends Marionette.CompositeView

    'template': '#caderno-menuAcoes'

    'className': 'container'

    'childView': MenuItemAcaoView

    'childViewContainer': '#lista-acoes'

    'initialize': () ->
      console.log arguments



