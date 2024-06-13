define [
  './ErrorView'
  './ConteudoView'
], (ErrorView) ->

  class ConteudoCollView extends Marionette.CollectionView

    initialize: ->

    className: 'enf-med-main panel panel-default'

    childView: ConteudoView

    template: '#progresso-unidades'

    ui:
      'unidades': '.unidades'
    
    onRender: ->

  ConteudoCollViews