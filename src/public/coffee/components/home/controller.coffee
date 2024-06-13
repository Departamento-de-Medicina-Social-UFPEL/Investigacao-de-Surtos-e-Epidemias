define [
  './views/HomeLayout'
  './views/ElegivelCertificado'
  'backbone'
], (HomeLayout, ElegivelCertificado, Backbone) ->

  "testeBloqueado": (callback) ->
    Modal = Backbone.Modal.extend
      template: _.template $('#home-teste-bloqueado').html()
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

  "iniciaPagina": (callback) ->
    {user, progresso} = App   
    mainView = new HomeLayout
      model: new Backbone.Model
    App.main.once 'show', () ->
      setTimeout (()-> do window.$.material.init), 10
    App.main.show mainView
    callback.apply @ if callback

  "elegivelCertificado": (callback) ->
    App.modals.destroyAll()
    Modal = new ElegivelCertificado
    App.modals.show Modal
    callback.apply @ if callback



