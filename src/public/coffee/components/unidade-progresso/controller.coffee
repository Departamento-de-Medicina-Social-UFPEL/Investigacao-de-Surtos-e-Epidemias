define [
  './views/MainUnidadeView'
  './models/Caso'
  'backbone'
], (MainUnidadeView, Caso, Backbone) ->
  "unidadeBloqueada": (callback) ->
    Modal = Backbone.Modal.extend
      template: _.template $('#unidade-progresso-unidade-bloqueada').html()
      submitEl: '.bbm-button'
      onRender: ->
        b = $('body')
        do b.fadeIn unless b.is ':visible'
      onDestroy: ->
        $('body').removeAttr('style').css display: 'block'
        $('body').css 'overflow': 'auto'
        App.appRouter.navigate '/', 'trigger': yes
    App.modals.show new Modal
    callback.apply @ if callback
  "mostraUnidade": (unidade) ->
    return unless App.user
    appComponent = _.findWhere window.modulo.components, {short: unidade}
    console.log unidade, 'unidade', appComponent
    console.log window.modulo.components, appComponent, {short: unidade}, 'appComponent unidade'

    appComponent.routeFactory = (id)-> "#comp/#{openItemsIn}/#{id}"
    if appComponent.externalResources
      appComponent.resource.casos = appComponent.resource.casos.map (c)->
        c.tipo = if c.tipo then c.tipo else 'caso'
        c
    else
      appComponent.resource = { casos: []}
    # if not App.unidade
    #   App.unidade = {}
    # App.unidade[appComponent.short] = appComponent
    # casosLean = appComponent.resource.casos

    # for c in casosLean
    #   App.atividades.add c
    #   App.casos.add c
    appComponent.testes = App.testes.models.filter (t)->  t.get('unidade') == appComponent.unidade and appComponent.unidade

    coll = Backbone.Collection.extend
      model: Caso
    mainView = new MainUnidadeView
      collection: new coll(appComponent.resource.casos)
      model: new Backbone.Model(appComponent)
    App.main.show mainView

    # callback.apply @ if callback
