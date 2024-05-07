define [
  './controller'
  './collections/Monitoramentos'
  './routes'
  'utils'
  'backbone'
], (controller, MonitoramentosColl, routes, utils, Backbone) ->

  
  return (component, parentApp, Backbone, Marionette, $, _)->
    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"

      prefixedRoutes[path] = val

    parentApp.appRouter.processAppRoutes controller, prefixedRoutes
