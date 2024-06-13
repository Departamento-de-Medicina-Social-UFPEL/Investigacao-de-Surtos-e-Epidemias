define [
  'backbone'
  './views/EnfMedMainLayout'
  './views/ErrorView'
], (Backbone, EnfMedMainLayout, ErrorView) ->

  "iniciaPagina": (callback) ->
    dtAtual = new Date()
    window.modulo.ofertasAbertas = window.modulo.ofertas.filter (o)->
      return (dtAtual >= (new Date(o.data_inicio)) and (new Date(o.data_fim_matricula)) >= dtAtual)
    App.main.show new EnfMedMainLayout()

  "error": (msg) ->
    console.log 'érro', msg
    do App.modals.destroyAll
    App.modals.destroyAll() if App.modals.currentView
    window.location.hash = '' unless App.user
    # console.log 'hash', window.location.hash, 'user', App.user, 'logout', App.socket.connected
    msg = "Não foi possível salvar o seu progresso, para evitar a perda dos dados, verifique sua conexão e tente novamente!"
    App.modals.show(new ErrorView({msg:msg}))
