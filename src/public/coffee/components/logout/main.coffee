define [
  './controller'
  './routes'
], (controller, routes, TelaView) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"
      prefixedRoutes[path] = val

    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    parentApp.on 'beforeStart', () ->
      menuEntry =
        'style':'link'
        'link':'#comp/logout'
        'icone':'logout'
        'texto': "Sair"
      App.menuEntries.push menuEntry