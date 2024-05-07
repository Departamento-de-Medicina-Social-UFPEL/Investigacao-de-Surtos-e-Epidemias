define [
  './controller'
  './routes'
  'utils'
], (controller, routes, utils) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"
      prefixedRoutes[path] = val

    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    component = _.findWhere window.modulo.components, {folder: @moduleName}
    parentApp.casos = component.resource.casos.map (caso) ->
      oid = caso._id
      tsPart = oid.slice 0, 8
      unixTs = parseInt tsPart, 16
      dataBr = (new utils.databr(unixTs, {charMes: 0})).fabricate()
      caso.dataBr = dataBr
      caso

    parentApp.selecao = component.resource
    parentApp.selecao.titulo = component.title
