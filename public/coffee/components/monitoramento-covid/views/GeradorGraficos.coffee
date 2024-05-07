define [
], () ->
  (data) ->
    console.log 'modelo grafico', data
    tipo = data.get 'tipo'
    modelo = switch tipo
      when 'empilhado' then getDadosSituacaoMonitoramento(data)
      else getDadosSituacaoMonitoramento(data)
    modelo

getDadosSituacaoMonitoramento = (modelo)->
  console.log 'modelo grafico dados', modelo
  dados = modelo.get('dados')
  naoIniciado = andamento = encerrado = []
  modelo.set 'categorias', dados.map (d)->
    fim = if modelo.get('tipo') isnt 'dia' then ' à '+d.periodoFim else ''
    d.periodoInicio+fim
  dados.forEach (d)->
    naoIniciado.push((parseFloat(d.nrNaoIniciados) * 100 / d.nrMonitorados))
    andamento.push((parseFloat(d.nrEmAndamento) * 100 / d.nrMonitorados))
    encerrado.push((parseFloat(d.nrEncerrados) * 100 / d.nrMonitorados))
  modelo.set 'series', [
    {
      name: "Não iniciados"
      data: naoIniciado
    }
    {
      name: "Em andamento"
      data: andamento
    }
    {
      name: "Encerrados"
      data: encerrado
    }
  ]
  modelo