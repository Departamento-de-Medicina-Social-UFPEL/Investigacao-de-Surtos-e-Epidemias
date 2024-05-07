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
      path = "comp/selecao-testes-progresso#{key}"
      prefixedRoutes[path] = val
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    appComponent = _.findWhere window.modulo.components, {folder: @moduleName}

    # ISSO TEM QUE IR PARA AS CONFIGURACOES DO COMPONENTE
    itemModule = '#comp/teste-progresso'
    component.routeFactory = (id)-> "#{itemModule}/#{id}"
    referenceModule = '#comp/caso-progresso'
    component.refRouteFactory = (id)-> "#{referenceModule}/#{id}"

    unless window.App['selecao-testes-progresso']
        window.App['selecao-testes-progresso'] = ({});
        window.App['selecao-testes-progresso'].refRouteFactory = component.refRouteFactory

        
    appComponent.resource.casos = appComponent.resource.casos.map (c)->
      c.tipo = 'teste'
      c.posTeste = !(/inicial/img.test c.titulo)
      # console.log c.posTeste
      c

    $('.dropdown-componentes').find('.dropdown-menu a[href="#comp/selecao-testes-progresso-multipro"]')
    .attr 'href', '#comp/selecao-testes-progresso'

    parentApp.selecaoTestes = appComponent.resource
    testesLean = appComponent.resource.casos

    for t in testesLean
      parentApp.atividades.add t
      parentApp.testes.add t

    parentApp.selecaoTestes.titulo = appComponent.title
