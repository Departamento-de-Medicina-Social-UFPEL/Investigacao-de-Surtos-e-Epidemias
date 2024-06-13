define [
  'marionette'
], (Marionette) ->
  class ItemListaCaso extends Marionette.ItemView

    template: '#unidade-progresso-itemView'
    className: 'col-md-6'
    initialize: ->
      if App.user
        rs = App.progresso.where('atividade': @model.get '_id').map (i)-> i.attributes
        @model.set 'respostas': rs || []
        if @model.get('bloqueado')
          @.$el.css({'opacity': '0.3','pointer-events': 'none'})
        else
          @model.set('bloqueado', false)

    events:
      'click': 'gotoCaso'
    gotoCaso: ->
      console.log 'goto', @model
      openItemsIn = if @model.get('tipo') is 'saibamais' then 'saiba-mais' else 'caso-progresso'
      id = @model.get('_id')
      Backbone.history.navigate "#comp/#{openItemsIn}/#{id}", {trigger: yes}
    onRender: ->
