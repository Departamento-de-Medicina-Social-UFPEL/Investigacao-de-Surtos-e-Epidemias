define [
  './controller'
  './routes'
], (controller, routes) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"
      # console.log path
      prefixedRoutes[path] = val
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    # console.log parentApp.appRouter