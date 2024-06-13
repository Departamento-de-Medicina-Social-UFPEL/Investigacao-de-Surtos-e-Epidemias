define [
  './controller'
  './routes'
], (controller, routes) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    prefixedRoutes = {}

    for key, val of routes
      path = "comp/#{@moduleName}#{key}"
      prefixedRoutes[path] = val


    console.log prefixedRoutes, controller

    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    appComponent = _.findWhere window.modulo.components, {folder: @moduleName}

    # ISSO TEM QUE IR PARA AS CONFIGURACOES DO COMPONENTE
    parentApp.caso = appComponent.resource[0]

    parentApp.on 'beforeHistoryStart', () ->
      parentApp.appRouter.on "route", (route, params)->
        logo_ufpel = $('.logo-ufpel-cabeca')
        unless logo_ufpel.length > 0
          caixa = $('<li/>').addClass('logo-ufpel-cabeca').css
            'background-image': "url('#{window.defaultStaticFileService}/img/marcas/dms_branco.svg')"
          caixa.on 'click', () ->
            window.open('//'+window.location.host)


          $('.user-menu').append caixa

    casoLean = appComponent.resource[0]
    parentApp.casos.add casoLean

    parentApp.caso.titulo = appComponent.title

    # parentApp.hasIntro = false