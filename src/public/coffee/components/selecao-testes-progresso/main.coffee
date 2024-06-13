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
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    appComponent = _.findWhere window.modulo.components, {folder: @moduleName}

    # ISSO TEM QUE IR PARA AS CONFIGURACOES DO COMPONENTE
    itemModule = '#comp/teste-progresso'
    component.routeFactory = (id)-> "#{itemModule}/#{id}"
    referenceModule = '#comp/caso-progresso'
    component.refRouteFactory = (id)-> "#{referenceModule}/#{id}"

    console.log appComponent.resource.casos
    appComponent.resource.casos = appComponent.resource.casos.map (c)->
      c.tipo = 'teste'
      c.posTeste = !(/inicial/img.test c.titulo)
      console.log c.posTeste
      c

    parentApp.selecaoTestes = appComponent.resource
    # testesLean = appComponent.resource.casos

    # for t in testesLean
    #   parentApp.atividades.add t
    #   parentApp.testes.add t

    parentApp.selecaoTestes.titulo = appComponent.title
