define [
], ()->

  "syncAll": (cb) ->
    {local, socket, progresso} = App

    user = local.get 'user'
    App.user = user
    progresso.setUser user

    if App.socket
      socket.emit 'user', user, (resposta) ->
        if resposta.ok
          if resposta.user.cpf isnt user.cpf
            erroServidor = "Conflito de cpf enviado: "+user.cpf+" recebido "+resposta.user.cpf
            socket.emit 'senderror', erroServidor, (r)->
              console.log 'erro salvo no servidor'
            do cb if cb
          else
            u = resposta.user
            App.user = _.extend((if App.user then App.user else {}), {
              cpf: u.cpf
              ficha:
                pessoal:
                  nome:
                    primeiro: u.nome.slice(0, u.nome.indexOf(' '))
                    sobrenome: lti.lis_person_name_full
                    completo: lti.lis_person_name_full
              synced: yes
            })
            local.set 'user', App.user
            progresso.setUser App.user
          

    do cb if cb





