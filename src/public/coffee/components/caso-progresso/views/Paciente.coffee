define [], () ->

  class Paciente extends Marionette.ItemView
    'tagName': 'div'

    'className': 'slide pacienteInfo container-fluid'

    'template': '#caso-progresso-paciente'

    initialize: (options)->
      console.log @model.get 'dataLongaPub'

    'templateHelpers':
      'strIdade': -> makeIdade this.idade

  Paciente

makeIdade = (strIdade) ->
      return 0  unless typeof (strIdade) is "string"
      num = strIdade.match(/\d{1,}/g)
      uni = strIdade.match(/[dams]/g)
      singular =
        d: "dia"
        a: "ano"
        m: "mês"
        s: "semana"

      plural =
        d: "dias"
        a: "anos"
        m: "meses"
        s: "semanas"

      ret = ""
      for i of num
        nomes = (if parseInt(num[i], 10) > 1 then plural else singular)
        ret += ((if ret.length > 0 then " e " else "")) + num[i] + " " + nomes[uni[i]]
      ret