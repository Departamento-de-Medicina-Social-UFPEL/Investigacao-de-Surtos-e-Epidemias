define [
  './UnidadeItemView'
], (UnidadeItemView) ->

  class ConteudoCollView extends Marionette.CompositeView
    tagName: 'div'
    className: 'timeline-main'

    initialize: ->
      #console.log @collection, 'colecao1'
    childView: UnidadeItemView
    childViewContainer: '.timeline'
    template: '#progresso-unidades'


    onRender: ->
      #console.log @collection.models, 'coleçao', @childView, 'x'

  ConteudoCollView
  