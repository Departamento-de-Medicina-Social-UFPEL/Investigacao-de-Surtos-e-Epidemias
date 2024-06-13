define [
  './ItemView'
  '../collections/Monitoramentos'
], (ItemView, MonitoramentosColl) ->

  class HomeLayout extends Marionette.CompositeView
    childView: ItemView,
    childViewContainer: '.list-group'
    initialize: ->
      {user, local} = App
      #list = if local.get("monitoramento-#{user.cpf}") then local.get("monitoramento-#{user.cpf}") else [] 
      #App.monitoramentos = @collection
      #@collection = App.monitoramentos
      #console.log @collection.at(0), 'col1'

    className: ' container'

    template: '#monitoramento-covid-home'
    
    ui:
     'locais': '.list-group'

    onRender: ->
      self = @
      #console.log @collection, 'collection'
      if @collection.length is 0
        @ui.locais.append '<li class="list-group-item"><h2><small>Você ainda não tem locais a serem exibidos. Clique em "Inserir Local"</small></h2></li>'


    events:{}

  HomeLayout