define [
  './collections/Progresso'
  './models/Caso'
  './controller'
  './routes'
  'backbone'
], (Progresso, Caso, controller, routes, Backbone) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"
      prefixedRoutes[path] = val
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    ListaAtividades = Backbone.Collection.extend
      model: Caso

    parentApp.atividades = new ListaAtividades
    parentApp.casos = new ListaAtividades
    parentApp.testes = new ListaAtividades
    parentApp.progresso = new Progresso

    parentApp.on 'beforeHistoryStart', () ->
      {progresso, local} = App
      if local
        respostas = local.get "respostas-standalone"
        console.log respostas
        if respostas and respostas.length > 0
          progresso.reset respostas
        #   progresso.temNovosBadges yes
