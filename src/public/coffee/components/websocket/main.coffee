define [
  'socketio'
], (io) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    setIcon = (state=on)->
      iconEl = $ '.main-net-stats-ico'
      checkConectadoInternet = $('.conexao-internet')
      ico = 'mdi-wifi'
      fn = if state then 'unshift' else 'push'
      if state then checkConectadoInternet.prop("checked", true) else checkConectadoInternet.prop("checked", false)
      checkConectadoInternet.trigger("change")     

      states = [ico]
      states[fn] "#{ico}-off"
      iconEl.removeClass(states[0]).addClass states[1]

    amOnline = ()->
      App.execute 'retrieveRespostas', ->
        #console.log "online, tentando sincronizar respostas - App.execute 'retrieveRespostas', ->"
        App.progresso.calculaProgressoGeral()
        App.progresso.badgesConcedidos.reset App.progresso.temNovosBadges(yes).models

      if App.userMenu.currentView
        iconEl = $ '.main-net-stats-ico'
        setIcon on
        iconEl.attr 'title', "Conectado a #{@io.uri}"

    opt = 
      'path': '/ws'
      'port': 50000

    socket = io window.location.host, opt

    # console.log window.location.host, opt, "============== socketio ================="

    socket.io.engine.on 'heartbeat', ()->
      if App.userMenu.currentView
        ico = $('.main-net-stats-ico')
        ico.addClass 'glow'
        setTimeout (()-> ico.removeClass 'glow'), 2000

    socket.on 'connect', ()->
      amOnline.apply this

    socket.on 'respostas', (data)->
      # console.log "socket.on 'respostas', (data)->", data

    socket.on 'reconnect', ()->
      # console.log 'reconn'
      amOnline.apply this

    socket.on 'reconnect_failed', ()->
      self = this
      setTimeout (()-> self.io.reconnect()), 60e3

    socket.on 'disconnect', ()->
      # console.log 'disconn'
      if App.userMenu.currentView
        iconEl = $ '.main-net-stats-ico'
        setIcon off
        now = (new Date)
        iconEl.attr 'title', "Desconectado desde #{now.toLocaleDateString()} #{now.toLocaleTimeString()}"


    parentApp.socket = socket
