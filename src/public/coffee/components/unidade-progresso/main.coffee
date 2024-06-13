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

    # console.log prefixedRoutes, @moduleName, 'modulo unidade progresso', val, key
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    appComponents = _.where window.modulo.components, {folder: @moduleName}
    for appC in appComponents
      if not appC.resource
        break
      appC.resource.casos = appC.resource.casos.map (c)->
        c.unidade = appC.unidade if appC.unidade
        c.tipo = if c.tipo then c.tipo else 'caso'
        c
      # casosLean = appC.resource.casos
      # console.log appC.unidade, 'unidade progresso', casosLean

      # for c in casosLean
      #   parentApp.atividades.add c
      #   parentApp.casos.add c

    # parentApp.selecao.titulo = appComponent.title
