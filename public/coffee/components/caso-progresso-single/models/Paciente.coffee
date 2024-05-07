define [], () ->

  class Paciente extends Backbone.Model
    'initialize': (options) ->
      return unless typeof options is 'object'
      idade = parseInt(options.idade.match(/\d{1,}/)[0])
      sexo = options.sexo.trim()
      idade = options.idade.trim()
      idade = 1 if (options.idade.indexOf('a') is -1) and (options.idade.indexOf('m') isnt -1)
      if (options.idade.indexOf('a') isnt -1) and (options.idade.indexOf('m') isnt -1)
        somaPartes = (soma, parte, idx)->
          val = parseInt(parte.match(/\d{1,}/)[0])
          return soma + val if idx is 0
          soma + (val/12)
        idade = idade.split('a').reduce somaPartes, 0
      fe = switch sexo
        when 'feminino' then 'fenoMulher'
        when 'masculino' then 'fenoHomem'
      fe = switch
        when idade <= 13 then 'fenoCrianca'
        when idade <= 3 then 'fenoBebe'
        else fe

      console.log """






      """;console.log(options, fe, idade);console.log """







      """

      @set 'fenotipo', fe

  Paciente