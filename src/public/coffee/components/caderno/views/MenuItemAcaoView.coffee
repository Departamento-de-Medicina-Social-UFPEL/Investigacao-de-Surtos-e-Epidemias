define [
  'marionette'
], (Marionette) ->

  class MenuItemAcaoView extends Marionette.ItemView

    'tagName': 'li'

    'template': '#caderno-menuAcoes-item'

    'onRender': () ->
      console.log @model

  MenuItemAcaoView



