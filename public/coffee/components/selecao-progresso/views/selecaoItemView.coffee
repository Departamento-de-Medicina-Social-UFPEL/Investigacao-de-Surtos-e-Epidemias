define [
  'marionette'
], (Marionette) ->
  class ItemListaCaso extends Marionette.ItemView

    template: '#selecao-progresso-itemView'
    className: 'col-md-6'
    initialize: ->
      if App.user
        rs = App.progresso.where('atividade': @model.get '_id').map (i)-> i.attributes
        @model.set 'respostas': rs || []
        @resolveBloqueado()

    events:
      'click': 'gotoCaso'

    gotoCaso: ->
      url = App['selecao-progresso'].routeFactory @model.get('_id')
      Backbone.history.navigate url, {trigger: yes}

    onRender: ->

    resolveBloqueado: ->
      cond = @model.get('bloqueado')
      if cond
        @.$el.css({'opacity': '0.3','pointer-events': 'none'})
      else
        @model.set('bloqueado', false)
