define [
  'marionette'
], (Marionette) ->

  class MainLayoutView extends Marionette.LayoutView

    'template': '#ubs-nova-layout'
    'regions':
      'passoBox': '#passoBox'
  MainLayoutView