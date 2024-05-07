define [
 '../models/Monitoramento'
], ( Monitoramento)->
  class Monitoramentos extends Backbone.Collection
    'model': Monitoramento
    'url': ''


    'initialize': (options)->
    #
    # onChange:()->
    # onReset:()->
    'addAmostra':(a)->
      l = @get(a.id_local)
      dados = l.get('dados')
      #console.log dados, 'dados do local', l.get('tipo'),a
      self = @
      dados.forEach (d)->
        #console.log a.periodoInicio is d.periodoInicio, a.id isnt d.id, a.periodoInicio , d.periodoInicio , a.id , d.id, 'davex'
        if l.get('tipo') is 'diario'
          if a.periodoInicio is d.periodoInicio and (a.id isnt d.id or not a.id)
            throw "Já existem dados na base para o dia informado!"
        else
          dt_ini_a = new Date(self.getDateInternational(a.periodoInicio))
          dt_fim_a = new Date(self.getDateInternational(a.periodoFim))
          dt_ini_d = new Date(self.getDateInternational(d.periodoInicio))
          dt_fim_d = new Date(self.getDateInternational(d.periodoFim))
          if dt_ini_a >= dt_ini_d and dt_ini_a <= dt_fim_d and (a.id isnt d.id or not a.id)
            console.log dt_ini_a, 'data entrando'
            console.log dt_ini_d, ' data ja estva ', dt_fim_d
            console.log ' a d ids ', a.id, d.id, not a.id
            throw "A data do início do período está superposta a um período inserido anteriormente!"
          if dt_fim_a >= dt_ini_d and dt_fim_a <= dt_fim_d and (a.id isnt d.id or not a.id)
            throw "A data de fim do período está superposta a um período inserido anteriormente!"
          if dt_fim_a <= dt_ini_d and dt_fim_a >= dt_fim_d and (a.id isnt d.id or not a.id)
            throw "O periodo da amostra esta contendo uma outra amostra já inserida!"
      if not a.id
        a['id'] = a.id_local+'_'+(a.periodoInicio.split('/').join('_'))
      jaexiste = false
      dados = dados.map (d)=>
        if d.id is a.id
          jaexiste = true
          a
        else
          d
      if not jaexiste
        dados.push(a)
      l.set('dados', dados)
      @update(l)

    'create': (l)->
      l.dados = []
      l['tipo'] = 'dia' unless l.tipo
      console.log l, 'moni', l['tipo']
      @add l
      do @saveLocal
      @saveServer l
      @get(l.id)

    'update': (l)->
      @models = @models.map (m)=>
        if l.get('id') is m.get('id')
          m = l
        m
      console.log 'update', l.get('dados')
      @saveLocal()
      @saveServer l.toJSON()

    'excluir':(id)->
      local = @remove id
      @removeServer id
      @saveLocal()
      
    saveLocal: ->
      return unless App.local
      {local, user} = App
      local.set "monitoramento-#{user.cpf}", @toJSON()

    removeServer: (id)->
      return unless App.socket
      App.socket.emit "desmonitorou", id
      , (data) ->
        console.log data, 'removeu?'
    saveServer: (res)->
      return unless App.socket
      App.socket.emit "monitorou", res
      , (data) ->
        console.log data
    
    getDateInternational:(strDate)->
      strDate = strDate.split('/')
      c = strDate[0]
      strDate[0] = strDate[1]
      strDate[1] = c
      strDate.join('/')
