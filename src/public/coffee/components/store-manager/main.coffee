define [
  './controller'
  './routes'
], (controller, routes) ->

  url =
    'host': window.location.host
    'path': 'arouca/modulo/maad-paliativo'

  return (component, parentApp, Backbone, Marionette, $, _)->


    App.commands.setHandler 'storeUser', (user=App.user, cb)->
      # console.log arguments
      {local, socket, progresso} = parentApp

      return false unless user

      parentApp.user = user

      if local
        local.set 'user', parentApp.user

      progresso.setUser user
      resposta = {ok:false}

      if socket
        user['modulo'] = App.moduloId
        console.log "emit user", user
        socket.emit 'user', user, (resposta) ->
          console.log """
          SALVO USER no server
          """, resposta
          if resposta.ok
            if resposta.user.cpf isnt user.cpf
              resposta.ok = false
              erroServidor = "Conflito de cpf enviado: "+user.cpf+" recebido "+resposta.user.cpf
              socket.emit 'senderror', erroServidor, (r)->
                # console.log 'erro salvo no servidor'
              cb(resposta) if cb
            else
              u = resposta.user
              App.user = u
              App.local.set 'user', App.user
              # console.log App.user, 'salvo no server e local', local.get 'user'
              # App.progresso.setUser App.user
              # console.log 'sincronizando progressos'
              App.execute 'retrieveRespostas', cb
          else
            cb(resposta) if cb
      else
        cb(resposta) if cb

    App.commands.setHandler 'retrieveRespostas', (cb)->

      # console.log "App.commands.setHandler 'retrieveRespostas', (cb)->"

      {user, local, socket, progresso} = parentApp

      if socket and local and user
        # console.log "emit respostas"
        respostaz = if App.local.get('respostas-'+App.user.cpf) then App.local.get('respostas-'+App.user.cpf) else []
        respsServer = []
        # console.log respostaz
        resps = _.sortBy(respostaz,'ts')
        ts = if resps then resps[0]?.ts else 0
        cpfUser = parentApp.progresso.user.get('cpf')
        obj = {user: cpfUser, modulo: window.modulo._id}
        # console.log obj
        # console.log 'enviando respostas locais para o servidor'
        socket.emit 'respostas:rebuild', resps, (data) ->
          # console.log 'respostas entregues ao servidor', data
          if !data.ok
            if cb then return cb(data) else return App.main.currentView?.render()
          if data.respostas.length > 0
            respsLocais = data.respostas
          socket.emit 'respostas', obj, (data) ->
            #console.log 'buscando progresso completo do servidor validas(a+b) ...', obj
            {ok, respostas} = data
            return cb(data) if cb unless ok
            # App.local.set('respostas-'+App.user.cpf, respsServer)
            data.respostas = respsLocais unless data.respostas
            App.progresso.reset data.respostas
            if cb
              cb(data)
            else
              App.main.currentView?.render()

    App.commands.setHandler 'loginComo', (cpf, cb)->
      {local, socket, progresso} = parentApp
      socket.emit 'getuser', {cpf:cpf}, (resposta) ->
        # console.log {cpf:cpf}, resposta, 'resposta'
        if resposta.ok
          if resposta.user.cpf isnt cpf
            erroServidor = "Conflito (loginComo) de cpf enviado: "+cpf+" recebido "+resposta.user.cpf
            socket.emit 'senderror', erroServidor, (r)->
              # console.log 'erro salvo no servidor'
          # console.log resposta.user, '<- aqui esta'
          u = resposta.user
          App.user = u
          App.local.set 'user', App.user
          # console.log App.user, 'salvo local', local.get 'user'
          App.progresso.setUser App.user
          App.execute 'retrieveRespostas', ()->
            window.location.reload()
        else
         console.log "Error:", resposta

    App.commands.setHandler 'storeUserEnquete', (userEnquete, cb)->
      # console.log arguments, userEnquete, 'userEnquete'
      {local, socket, progresso} = parentApp
      return false unless userEnquete
      if not App.user
        # console.log 'nao tem usar local tentando buscar'
        socket.emit 'getuser', {cpf:userEnquete.cpf, modulo: App.moduloId}, (resposta) ->
          if resposta.ok
            App.user = resposta.user
            # console.log 'tem usar local tentando enviar enquete', resposta
            enviaUserEnquete userEnquete, cb
          else
            erroServidor = "Não foi possivel salvar a enquete para: "+userEnquete.cpf
            socket.emit 'senderror', erroServidor, (r)->
              # console.log 'erro salvo no servidor'
      else
        # console.log 'tem user local, enviando enquete', App.user.cpf
        enviaUserEnquete userEnquete, cb

    App.commands.setHandler 'dashboard.calcProgresso', (cb) ->
      App.socket.emit 'dashboard.calcProgresso', App.user.cpf, App.moduloId, cb

    enviaUserEnquete = (userEnquete, cb)->
      {local, socket, progresso} = parentApp

      # console.log 'enviando enquete' , userEnquete, App.user
      if not App.user.enquetes
        App.user.enquetes = {}
      if not App.user.enquetes[App.moduloId]
        App.user.enquetes[App.moduloId] = {}
      if userEnquete.cadastro
        App.user.enquetes[App.moduloId]['cadastro'] = userEnquete.cadastro
      if userEnquete.conclusao
        App.user.enquetes[App.moduloId]['conclusao'] = userEnquete.conclusao
      if userEnquete.encerramento
        App.user.enquetes[App.moduloId]['encerramento'] = userEnquete.encerramento

      parentApp.user = App.user
      if local
        local.set 'user', parentApp.user

      resposta = {ok:false}

      if socket
        # console.log "emit user", App.user
        socket.emit 'userEnquete', App.user, (resposta) ->

          if not resposta.ok
            erroServidor = "Não foi possível salvar suas respostas!"
            socket.emit 'senderror', erroServidor, (r)->
              # console.log 'erro salvo no servidor'
            cb(resposta) if cb
          else
            # App.user = resposta.user
            # App.local.set 'user', App.user
            # console.log App.user, 'enquete salva no server e local', local.get 'user'
            cb(resposta) if cb
              # App.progresso.setUser App.user
      else
        cb(resposta) if cb



