define [
  './error'
  'backbone.modal'
], (ErrorView)->

  class Modal extends Backbone.Modal
    submitEl: '.bbm-button'
    template: _.template $('#logout-salvando').html()
    initialize: (obj)->

    onRender: ->
      b = $('body')
      self = @
      do b.fadeIn unless b.is ':visible'
      console.log 'setTimeout', (new Date())
      setTimeout (()-> self.salvar()), 5000

    salvar:()->
      console.log 'sokect conectado vou tentar salvar', App.socket.connected, (new Date())
      if not navigator.onLine
        window.location.hash = '#comp/logout/error'
        # return App.modals.show(new ErrorView({msg:msg}))
      else
        return App.execute 'storeUser', App.user, (dataUser)->
          # console.log 'retorno store logout', dataUser
          jaCertificado = dataUser.certificado
          if !dataUser.ok and !jaCertificado
            window.location.hash = '#comp/logout/error'
            # App.modals.show(new ErrorView({msg:msg}))
          else
            App.local.set 'user'
            App.user = null
            App.progresso = null
            window.location.hash = '' unless App.user
            window.location.reload()
    onDestroy: ->
      $('body').css 'overflow': 'auto'
      App.appRouter.previous()
