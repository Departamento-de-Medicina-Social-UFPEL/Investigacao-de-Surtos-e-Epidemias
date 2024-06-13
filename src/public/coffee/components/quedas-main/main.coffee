define [
  './controller'
  './routes'
  'backbone'
], (controller, routes, Backbone) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"
      prefixedRoutes[path] = val
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    parentApp.quedas = new Backbone.Collection _.findWhere(modulo.components, {folder:'quedas-main'}).payload