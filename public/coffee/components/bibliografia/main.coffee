define [
  './controller'
  './routes'
], (controller, routes) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    parentApp.bibliografia = new Backbone.Collection _.findWhere(modulo.components, {folder: @moduleName}).resource

    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"
      prefixedRoutes[path] = val

    parentApp.appRouter.processAppRoutes controller, prefixedRoutes






