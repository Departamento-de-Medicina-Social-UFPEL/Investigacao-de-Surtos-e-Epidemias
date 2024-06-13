define [
  './views/salvando'
  './views/error'
  'backbone'
], ( SalvandoView, ErrorView, Backbone) ->

  "sair": () ->
    do App.modals.destroyAll
    App.modals.destroyAll() if App.modals.currentView
    window.location.hash = '' unless App.user
    # console.log 'hash', window.location.hash, 'user', App.user, 'logout', App.socket.connected
    App.modals.show(new SalvandoView())

  "error": () ->
    do App.modals.destroyAll
    App.modals.destroyAll() if App.modals.currentView
    window.location.hash = '' unless App.user
    # console.log 'hash', window.location.hash, 'user', App.user, 'logout', App.socket.connected
    msg = "Não foi possível salvar o seu progresso, verifique sua conexão e tente novamente!"
    App.modals.show(new ErrorView({msg:msg}))
