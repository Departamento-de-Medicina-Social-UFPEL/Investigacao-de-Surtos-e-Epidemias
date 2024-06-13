define [
  'marionette'
], (Marionette) ->

  class MainLayoutView extends Marionette.LayoutView

    'template': '#ubs-lista-layout'
    'regions':
      'selUf': '#selUf'
      'selMun': '#selMun'
      'selUbs': '#selUbs'

  MainLayoutView