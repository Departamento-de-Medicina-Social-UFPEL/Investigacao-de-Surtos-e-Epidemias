define [
  # '../../ProgressoCollection'
  './controller'
  './routes'
  './models/Caso'
  'utils'
], (controller, routes, Caso, utils) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"
      prefixedRoutes[path] = val

    # console.log prefixedRoutes, @moduleName, 'modulo selecao progresso'
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes
    appComponent = _.findWhere window.modulo.components, {folder: @moduleName}

    # ISSO TEM QUE IR PARA AS CONFIGURACOES DO COMPONENTE
    openItemsIn = 'caso-progresso'
    component.routeFactory = (id)-> "#comp/#{openItemsIn}/#{id}"

    appComponent.resource.casos = appComponent.resource.casos.map (c)->
      c.tipo = if c.tipo then c.tipo else 'caso'
      c

    parentApp.selecao = appComponent.resource
    # casosLean = appComponent.resource.casos

    # for c in casosLean
    #   parentApp.atividades.add c
    #   parentApp.casos.add c

    parentApp.selecao.titulo = appComponent.title
