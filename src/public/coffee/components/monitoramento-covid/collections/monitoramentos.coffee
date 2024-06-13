define [
 '../models/Monitoramento'
], ( Monitoramento)->
  class Monitoramentos extends Backbone.Collection
    'model': Monitoramento
    'url': ''

    'initialize': (options)->
    #   @bind 'add', @onModelAdded, @
    #   @bind 'remove', @onModelRemoved, @
    #   @bind 'change reset', @onChange, @
    #   @bind 'reset', @onReset, @
    #   null
    # onModelAdded:()->
    # onModelRemoved:()->
    # onChange:()->
    # onReset:()->
    'addAmostra':(a)->
      l = @get(a.id_local)
      dados = l.get('dados')
      dados.forEach (d)->
        if l.tipo is 'dia'
          if a.periodoInicio is d.periodoInicio
            throw "Já existe dados na base para o dia informado!"
        else
          dt_ini_a = new Date(a.periodoInicio)
          dt_fim_a = new Date(a.periodoFim)
          dt_ini_d = new Date(a.periodoInicio)
          dt_fim_d = new Date(a.periodoFim)
          if dt_ini_a >= dt_ini_d and dt_ini_a <= dt_fim_d
            throw "A data de inicio da amostra esta coberto por outra amostra já inserida!"
          if dt_fim_a >= dt_ini_d and dt_fim_a <= dt_fim_d
            throw "A data de fim da amostra esta coberto por outra amostra já inserida!"
          if dt_fim_a <= dt_ini_d and dt_fim_a >= dt_fim_d
            throw "Operiodo da amostra esta contendo uma outra amostra já inserida!"
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
      #@saveServer res
      @get(l.id)

    'update': (l)->
      @models = @models.map (m)=>
        if l.get('id') is m.get('id')
          m = l
        m
      console.log 'update', l.get('dados')
      @saveLocal()

    'excluir':(id)->
      local = @remove id
      @saveLocal()
      
    saveLocal: ->
      return unless App.local
      {local, user} = App
      local.set "monitoramento-#{user.cpf}", @toJSON()

    saveServer: (res)->
      return unless App.socket
      App.socket.emit "monitorou", res.toJSON(), (data) ->
        console.log data
