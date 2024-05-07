define [
  './routes'
  './controller'
], (routes, controller) ->

  cadernoModule = (component, parentApp, Backbone, Marionette, $, _) ->


    prefixedRoutes = {}
    for key, val of routes
      match = "comp/#{@moduleName}#{key}"
      console.log match
      prefixedRoutes[match] = val

    console.log controller, prefixedRoutes
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    doItAll = () ->
      console.log "#{component.moduleName} Loaded!"
      console.log 'arguments', arguments
      console.log 'context', @

    component.on "before:start", ()->
      console.log 'before:start', arguments

    component.on "start", ()->
      console.log 'start', arguments

    @addInitializer doItAll
    component.addFinalizer doItAll

    console.log """
O contexto (this) é o próprio componente (component)
@ is component = #{@ is component}
e como temos component não precisamos guardar o contexto (self = @)
"""
    # Backbone, Marionette, $, _ de brinde no contexto, mano
    console.log component



  cadernoModule