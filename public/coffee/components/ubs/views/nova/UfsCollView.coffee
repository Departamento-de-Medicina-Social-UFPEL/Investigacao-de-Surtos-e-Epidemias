define [
  'marionette'
], (Marionette) ->
  class UfsCollView extends Marionette.ItemView
    'className': 'container'
    'template': '#ubs-nova-passo-1-uf'
    'onRender': () ->
      console.log 'UfsCollView::render Done'

  UfsCollView