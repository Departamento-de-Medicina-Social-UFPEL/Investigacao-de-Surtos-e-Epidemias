define [
  './controller'
  './routes'
], (controller, routes) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"
      prefixedRoutes[path] = val
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    # ISSO TEM QUE IR PARA AS CONFIGURACOES DO COMPONENTE
    itemModule = '#comp/teste-progresso'
    component.routeFactory = (id)-> "#{itemModule}/#{id}"
    referenceModule = '#comp/caso-progresso'
    component.refRouteFactory = (id)-> "#{referenceModule}/#{id}"

    unless window.App['selecao-testes-progresso']
        window.App['selecao-testes-progresso'] = ({})
        window.App['selecao-testes-progresso'].refRouteFactory = component.refRouteFactory

    appComponent = _.findWhere window.modulo.components, {folder: @moduleName}
    unidades = _.where window.modulo.components, {folder: 'unidade-progresso'}
    appComponent.resource.casos = appComponent.resource.casos.map (t)->
      t.tipo = 'teste'
      t.posTeste = !(/inicial/img.test t.titulo)
      # unidades.forEach (u)->
      #   if u.teste_inicial is t._id
      #     t.unidade = u.unidade
      #   if u.teste_final is t._id
      #     t.unidade = u.unidade
      t

    parentApp.selecaoTestes = appComponent.resource
    # testesLean = appComponent.resource.casos
    # for t in testesLean
    #   parentApp.atividades.add t
    #   parentApp.testes.add t

    parentApp.selecaoTestes.titulo = appComponent.title
