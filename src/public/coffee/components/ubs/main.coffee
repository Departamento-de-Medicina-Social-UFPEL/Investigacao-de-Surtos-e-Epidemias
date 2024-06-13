define [
  './lib/jsonStore'
  './controller'
  './lib/demo'
  './routes'
], (staticData, controller, Demografia, routes) ->

  UbsModule = (compoment, parentApp, Backbone, Marionette, $, _)->

    prefixedRoutes = {}
    for key, val of routes
      match = "comp/#{@moduleName}#{key}"
      prefixedRoutes[match] = val
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    parentApp.estados = staticData.estados
    parentApp.demo = new Demografia staticData.faixaPorUf, staticData.faixaPorRelSexo

  UbsModule