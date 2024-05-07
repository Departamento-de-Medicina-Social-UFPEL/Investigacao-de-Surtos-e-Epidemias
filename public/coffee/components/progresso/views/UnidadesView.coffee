define [
  './ConteudoView'
], (ConteudoView) ->

  class ConteudoCollView extends Marionette.CollectionView
    className: 'row'

    initialize: ->
      console.log @collection, 'colecao1'

    childView: ConteudoView
    childViewContainer: '.lista-unidades'
    template: '#progresso-unidades'
    
    onRender: ->
      console.log @collection, 'coleçao', @childView, 'x'

  ConteudoCollView