define [], () ->

  class Paciente extends Backbone.Model
    'initialize': (options) ->
      idade = options.idade.match(/\d{1,}/)[0]
      sexo = options.sexo
      idade = 1 if options.idade.indexOf('a') is -1
      fe = switch sexo
        when 'feminino' then 'fenoMulher'
        when 'masculino' then 'fenoHomem'
      fe = switch
        when idade <= 13 then 'fenoCrianca'
        when idade <= 3 then 'fenoBebe'
      @set 'fenotipo', fe

  Paciente