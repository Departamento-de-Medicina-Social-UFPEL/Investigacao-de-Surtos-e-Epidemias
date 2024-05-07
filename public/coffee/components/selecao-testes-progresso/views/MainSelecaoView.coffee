define [
  './selecaoItemView'
  'marionette'
], (ItemView, Marionette) ->
  class MainSelecaoLayout extends Marionette.CompositeView
    template: '#selecao-testes-progresso-main'
    childView: ItemView
    childViewContainer: '.listaCasos'
    className: 'container selecao-main'


