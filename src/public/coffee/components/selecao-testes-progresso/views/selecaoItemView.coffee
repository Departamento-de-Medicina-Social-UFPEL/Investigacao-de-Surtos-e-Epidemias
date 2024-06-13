define [
  'marionette'
], (Marionette) ->
  class ItemListaCaso extends Marionette.ItemView

    template: '#selecao-testes-progresso-itemView'
    className: 'item-lista-caso-selecao-progresso'
    initialize: ->
      {user, progresso} = App
      if user
        rs = progresso.where('atividade': @model.get '_id').map (i)-> i.attributes
        g = progresso.geral
        lockTesteFinal = off
        unless (g.percCasosConcluTotal >= 70) and (g.percGeralAcertoCasos >= 70)
          lockTesteFinal = yes
      @model.set 'respostas': rs || []
      @model.set {lockTesteFinal}

    events:
      'click': 'gotoCaso'

    gotoCaso: ->
      url = App['selecao-testes-progresso'].routeFactory @model.get('_id')
      Backbone.history.navigate url, {trigger: on}



    onRender: ->
