define [
 '../models/Monitoramento'
], ( Monitoramento)->


  class Monitoramentos extends Backbone.Collection
    'model': Monitoramento
    'url': ''
    idAttribute: "id"

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

    'create': (resposta)->
      @add resposta
      do @saveLocal
      #@saveServer res


    saveLocal: ->
      return unless App.local
      {local, user} = App
      if @length > 0
        console.log @, 'tyhis'
        local.set "monitoramento-#{user.cpf}", @toJSON()
      else
        throw new Error

    saveServer: (res)->
      return unless App.socket
      App.socket.emit "monitorou", res.toJSON(), (data) ->
        console.log data