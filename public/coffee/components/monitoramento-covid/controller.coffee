define [
  'backbone'
  './views/HomeView'
  './views/FormularioView'
  './views/FormularioLocalView'
  './views/LocalView'
  './collections/Monitoramentos'
  './models/Monitoramento'
], ( Backbone, HomeLayout, FormularioView, FormularioLocalView, LocalView, MonitoramentosColl,Monitoramento) ->
  "before":(next)->
    if not App.user
      window.location.href = '#comp/cadastro'
    {socket} = App
    App.monitoramentos = new MonitoramentosColl()
    if socket.connected
      socket.emit 'monitoramentos', {user: App.user.cpf}, (resposta) ->
        if resposta.ok 
          App.monitoramentos.reset(resposta.monitoramentos)
          App.monitoramentos.saveLocal()
          next() if next
    else
      monitoramentos = App.local.get "monitoramento-#{App.user.cpf}"
      App.monitoramentos = new MonitoramentosColl(monitoramentos)
      next() if next

  "main": () ->
    @before ()->
      mainView = new HomeLayout 
        collection: App.monitoramentos
      App.main.show mainView

  "local": (id) ->
    #console.log App.monitoramentos.get(id), id, 'local find'
    @before ()->
      mainView = new FormularioLocalView
        model: App.monitoramentos.get(id)
      App.main.show mainView

  "monitorar":(id)->
    @before ()->
      console.log 'monitorar', id, App.monitoramentos.get(id),App.monitoramentos
      mainView = new LocalView
        model: App.monitoramentos.get(id)
      App.main.show mainView

  "novaAmostragem": (id) ->
    @before ()->
      f = new Monitoramento({id_local:id})
      #console.log f, id, 'nova'
      mainView = new FormularioView
        model: f
      App.main.show mainView

  "amostragem": (id, idAmostragem) ->
    @before ()->
      a = _.findWhere(App.monitoramentos.get(id).get('dados'), {id:idAmostragem})
      #console.log a, id, idAmostragem, 'dados'
      mainView = new FormularioView
        model: new Monitoramento a
      App.main.show mainView




    





