define [
  './views/MainSelecaoView'
  'backbone'
], (MainSelecaoView, Backbone) ->

  "mostraSelecaoCasos": (callback) ->
    return unless App.user
    mainView = new MainSelecaoView
      collection: App.testes
    App.main.show mainView

    callback.apply @ if callback

  "testeBloqueado": (callback) ->
    console.log 'block', Backbone
    Modal = Backbone.Modal.extend
      template: _.template $('#selecao-testes-progresso-multipro-teste-bloqueado').html()
      submitEl: '.bbm-button'

      onRender: ->
        b = $('body')
        do b.fadeIn unless b.is ':visible'

      onDestroy: ->
        $('body').removeAttr('style').css display: 'block'
        $('body').css 'overflow': 'auto'
        return do App.appRouter.previous if App.main.currentView
        App.appRouter.navigate '/', 'trigger': yes

    App.modals.show new Modal
    callback.apply @ if callback

