define [
  './ModalRemoverAmostra'
], (ModalRemoverAmostra) ->

  class ItemView extends Marionette.ItemView
    initialize: ->
      #console.log @model, 'model'
      modelo = @model.attributes
      @model.set 'element_id', modelo.id
      @model.set 'media', getDadosPeriodoMediaContato(modelo)
      ###       @model.set 'nrMoniDoisPrimeiros', getDadosPeriodoMotivosContatoDescartadoSegundoDia(modelo)
      @model.set 'nrMonitoradosDecimoQuarto', getDadosPeriodoMotivosContatoDescartadoDecimoQuartoDia(modelo) ###
    tagName:'li'
    className: 'list-group-item'

    template: '#monitoramento-covid-monitoramento-item'

    ui:
      'btnRemove':'.btn-remove'
      'collapse':'.panel-collapse.collapse'
      'up':'.glyphicon-chevron-up'
      'down':'.glyphicon-chevron-down'

    events:
      'click @ui.btnRemove':'remover'
      'show.bs.collapse @ui.collapse':'graficos'
      'hide.bs.collapse @ui.collapse':'hidegraficos'

    hidegraficos:()->
      @$el.find('.glyphicon-chevron-down:visible').addClass('glyphicon-chevron-up').removeClass('glyphicon-chevron-down')

    graficos:()->
      modelo = @model.attributes
      #console.log @$el.find('.glyphicon-chevron-up:visible').length
      @$el.find('.glyphicon-chevron-up:visible').addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-up')


      @getGraficoPizza(@model.get('element_id')+'_grafico-situacao', getDadosPeriodoSituacaoMonitoramento(modelo))
      @getGraficoPizza(@model.get('element_id')+'_grafico-segundo', getDadosMotivosContatoDescartadoSegundoDia(modelo))
      @getGraficoPizza(@model.get('element_id')+'_grafico-decimo-quarto', getDadosMotivosContatoDescartadoDecimoQuartoDia(modelo))
      @getGraficoPizza(@model.get('element_id')+'_grafico-relacao', getDadosPeriodoTiposRelacaoContato(modelo))
      @getGraficoPizzaDupla(@model.get('element_id')+'_grafico-motivos-encerramento', getDadosPeriodoNrMotivosEncerramento(modelo))
      @getGraficoPizza(@model.get('element_id')+'_grafico-vezes-monitoradas', getDadosPeriodoNrMonitoramentos(modelo))
    getGraficoSobreposto:(elemento, options)->
      if !options.stacking
        options['stacking'] = 'percent'
      if !options.tooltip
        options['tooltip'] = {
          pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>'
          #shared: true
        }
      Highcharts.chart elemento,
        chart: type: 'column'
        title: text: options.titulo
        xAxis: categories: options.categorias
        yAxis:
          min: 0
          title: text: options.tituloy
        tooltip: options.tooltip 
        plotOptions: column: stacking: options.stacking
        series: options.series
    getGraficoLinhas:(elemento,options)->
      Highcharts.chart elemento,
        chart: type: 'line'
        title: text: options.titulo
        subtitle: text: ''
        xAxis: categories: options.categories 
        yAxis: title: text: options.tituloy
        plotOptions: line:
          dataLabels: enabled: true
          enableMouseTracking: false
        series: options.series
    getGraficoPizza:(elemento,options)->
      Highcharts.chart elemento,
        chart:
          plotBackgroundColor: null
          plotBorderWidth: null
          plotShadow: false
          type: 'pie'
        title: text: options.titulo
        tooltip: pointFormat: '<b>{point.y} ({point.percentage:.1f}%)</b>'
        accessibility: point: valueSuffix: '%'
        plotOptions: pie:
          allowPointSelect: true
          cursor: 'pointer'
          dataLabels: enabled: false
          showInLegend: true
        series: options.series
    getGraficoPizzaDupla:(elemento,options)->
      #console.log 'artico', options
      Highcharts.chart elemento,
        chart: type: 'pie'
        title: text: options.titulo
        tooltip: pointFormat: '<b>{point.y} ({point.percentage:.1f}%)</b>'
        subtitle: text: ''
        plotOptions: pie:
          shadow: false
          showInLegend: true
          center: [
            '50%'
            '50%'
          ]
          allowPointSelect: true
          cursor: 'pointer'
          dataLabels:
            enabled: false
            #format: '<b>{point.name}</b>:<br> {point.percent:.1f} %'
        series: options.series
        #responsive: options.responsive
    getGraficoBarras:(elemento, options)->
      Highcharts.chart elemento,
        chart: type: 'column'
        title: text: options.titulo
        subtitle: text: ''
        xAxis:
          categories: options.categorias
          crosshair: true
        yAxis:
          min: 0
          title: text: options.tituloy
        tooltip:
          headerFormat: '<span style="font-size:10px">{point.key}</span><table>'
          pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' + '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>'
          footerFormat: '</table>'
          shared: true
          useHTML: true
        plotOptions: column:
          pointPadding: 0.2
          borderWidth: 0
        series: options.series
    
    remover:(e)->
      r = new ModalRemoverAmostra
        model: @model
      App.modals.show r

    onRender: ->
      #console.log 'view item'


  ItemView
getPorcentagem = (v, total)->
  return 0 unless v
  return 0 unless total
  parseFloat((parseFloat(v) * 100 / total).toFixed(2))

getDadosPeriodoSituacaoMonitoramento = (d)->
  d.nrIgnoradosSituacao = if d.nrIgnoradosSituacao then d.nrIgnoradosSituacao else 0
  options ={}
  options['titulo'] = 'Situação do Monitoramento'
  options['tituloy'] = '% Todos os Contatos'
  fim = if d.periodoFim isnt 'dia' then ' a '+d.periodoFim else ''
  options['categorias'] = d.periodoInicio+fim
  #options.dados.forEach (d)->
  #total = parseInt(d.nrNaoIniciados)+parseInt(d.nrEmAndamento)+parseInt(d.nrEncerrados)+parseInt(d.nrIgnoradosSituacao)
  naoIniciado = parseInt(d.nrNaoIniciados)
  andamento = parseInt(d.nrEmAndamento)
  encerrado = parseInt(d.nrEncerrados)
  ignoradosSituacao = parseInt(d.nrIgnoradosSituacao)
  options['series'] = [
    {
      name: ''
      colorByPoint: true
      data:[
        {
          name: "Não iniciado"
          y: naoIniciado
        }
        {
          name: "Em andamento"
          y: andamento
        }
        {
          name: "Encerrado"
          y: encerrado
        }
        {
          name: "Ignorado"
          y: ignoradosSituacao
        }
      ]
    }
  ]
  #console.log options, 'options'
  options

getDadosPeriodoTiposRelacaoContato = (d)->
  d.nrRelacaoIgnorados = if d.nrRelacaoIgnorados then d.nrRelacaoIgnorados else 0
  options ={}
  options['titulo'] = 'Tipo de Relação com o Caso'
  options['tituloy'] = '% Todos os Contatos'
  fim = if d.periodoFim isnt 'dia' then ' a '+d.periodoFim else ''
  options['categorias'] =  d.periodoInicio+fim
  #nrContatos = parseInt(d.nrRelacaoIgnorados)+parseInt(d.nrDomiciliar)+parseInt(d.nrFamiliar)+parseInt(d.nrEscolar)+parseInt(d.nrLaboral)+parseInt(d.nrEventoSocial)+parseInt(d.nrRelacaoOutros)
  domiciliar = parseInt(d.nrDomiciliar)
  familiar = parseInt(d.nrFamiliar)
  escolar = parseInt(d.nrEscolar)
  laboral = parseInt(d.nrLaboral)
  evento = parseInt(d.nrEventoSocial)
  outros = parseInt(d.nrRelacaoOutros)
  ignoradosRelacao = parseInt(d.nrRelacaoIgnorados)
  options['series'] = [{
    name: ''
    colorByPoint: true
    data:[
      {
        name: "Domiciliar"
        y: domiciliar
      }
      {
        name: "Familiar"
        y: familiar
      }
      {
        name: "Escolar"
        y: escolar
      }
      {
        name: "Laboral"
        y: laboral
      }
      {
        name: "Evento Social"
        y: evento
      }
      {
        name: "Outros"
        y: outros
      }
      {
        name: "Ignorado"
        y: ignoradosRelacao
      }
    ]
  }]
  #console.log options, 'options relacoes'
  options

getDadosPeriodoNrMonitoramentos = (d)->
  options ={}
  d.nrMoniIgnorados = if d.nrMoniIgnorados then d.nrMoniIgnorados else 0
  options['titulo'] = 'Número de Comunicações com Cada Contato'
  options['tituloy'] = '% do Número de comunicações'
  options['categories'] = ["3 vezes ou menos", "4 a 6 vezes", "7 vezes ou mais", 'Ignorado']
  #nrDescartados = parseInt(d.nrMoniZeroOuTres)+parseInt(d.nrEncerrados)+parseInt(d.nrEncerrados)
  tresoumenos = parseInt(d.nrMoniZeroOuTres)
  quatroouseis = parseInt(d.nrMoniQuatroOuSeis)
  seteoumais = parseInt(d.nrMoniSeisOuMais)
  moniIgnorados = parseInt(d.nrMoniIgnorados)
  options['series'] = [{
    name: ''
    colorByPoint: true
    data:[
      {
        name: "3 vezes ou menos"
        y: tresoumenos
        color:'#73e5da'
      }
      {
        name: "4 a 6 vezes"
        y: quatroouseis
        color:'#1f8ab5'
      }
      {
        name: "7 vezes ou mais"
        y: seteoumais
        color:'#8ed685'
      }
      {
        name: "Ignorado"
        y: moniIgnorados
        color:'#b3b3b3'
      }
    ]
  }]
  console.log options.series, 'series'
  options

getNrEncerramentoCompleto =(d)->
  return (parseInt(d.nrDescartado)+parseInt(d.nrSuspeita)+parseInt(d.nrConfirmado))

getNrEncerramentoIncompleto =(d)->
  return (parseInt(d.nrPerdaSegmento)+parseInt(d.naoEncontradoLigacao)+parseInt(d.nrRecusa)+parseInt(d.nrProblemasEquipe))

getDadosPeriodoNrMotivosEncerramento = (d)->
  d.nrIgnoradosSituacao = if d.nrIgnoradosSituacao then d.nrIgnoradosSituacao else 0
  colors = [
    '#599d66'
    '#1D588F'
    '#B3B3B3'
  ]
  options ={}
  options['titulo'] = 'Motivo de Encerramento'
  options['tituloy'] = 'Número Total de Contatos'
  options['categories'] = ['Monitoramento completo', 'Monitoramento incompleto', 'Ignorado']

  nr_incompleto = (getNrEncerramentoIncompleto(d))
  nr_completo = (getNrEncerramentoCompleto(d))
  #todos = nr_completo+nr_incompleto+parseInt(d.nrIgnoradosSituacao)
  perdaSegmento = parseInt(parseInt(d.nrPerdaSegmento))
  naoEncontradoLigacao = parseInt(parseInt(d.naoEncontradoLigacao))
  recusa = parseInt(parseInt(d.nrRecusa))
  problemasEquipe = parseInt(parseInt(d.nrProblemasEquipe))
  #
  suspeita = parseInt(parseInt(d.nrSuspeita))
  descartado = parseInt(parseInt(d.nrDescartado))
  confirmado = parseInt(parseInt(d.nrConfirmado))
  motivoIgnorados = parseInt(parseInt(d.nrMotivoIgnorados))
  #
  incompleto = parseInt(nr_incompleto)
  completo = parseInt(nr_completo)
  #total = completo+incompleto
  data = [
    {
      y: completo
      color: colors[0]
      drilldown: {
        name: 'Monitoramento completo',
        categories: [
          "Descartado"
          "Suspeita de covid-19"
          "Confirmado para covid-19"
        ]
        cores: [
          '#A3CEA5'
          '#C1F0A2'
          '#8ED685'
        ]
        data: [
          descartado
          suspeita
          confirmado
        ]
      }
    }
    {
      y: incompleto
      color: colors[1]
      drilldown: {
        name: 'Monitoramento incompleto'
        categories: [
          "Perda de seguimento"
          "Não encontrado na ligação"
          "Recusa"
          "Problemas na equipe"
        ]
        cores: [
          '#73e5da'
          '#1f8ab6'
          '#5c77bc'
          '#aeb8dc'
        ]
        data:[
          perdaSegmento
          naoEncontradoLigacao
          recusa
          problemasEquipe
        ]
      }
    }
    {
      y: motivoIgnorados
      color: colors[2]
      drilldown: {
        name: 'Ignorado',
        categories: [
          'Ignorado'
        ]
        cores: [
          '#B3B3B3'
        ]
        data: [
          motivoIgnorados
        ]
      }
    }
  ]
  situacoes = []
  motivos = []
  i = undefined
  j = undefined
  dataLen = data.length
  drillDataLen = undefined
  brightness = undefined
  # Build the data arrays
  i = 0
  while i < dataLen
    # add browser data
    situacoes.push
      name: options.categories[i]
      y: data[i].y
      color: data[i].color
    # add version data
    drillDataLen = data[i].drilldown.data.length
    j = 0
    while j < drillDataLen
      brightness = 0.2 - (j / drillDataLen / 6)
      motivos.push
        name: data[i].drilldown.categories[j]
        y: data[i].drilldown.data[j]
        color: data[i].drilldown.cores[j]
      j += 1
    i += 1
  options['series']= [
    {
      name: ''
      data: situacoes
      size: '60%'
      colorByPoint: true
    }
    {
      name: ''
      data: motivos
      size: '80%'
      innerSize: '60%'
      id: 'versions'
      colorByPoint: true
    }
  ]
  options['responsive']={
    rules: [
      {
        condition: maxWidth: 400
        chartOptions: series: [
          {}
          {
            id: 'versions'
            dataLabels: enabled: false
          }
        ]
      }
    ]
  }
  #console.log options.series, 'teste agora', d, total
  options

getDadosPeriodoMediaContato = (d)->
  options ={}
  options['titulo'] = 'Média de Contatos por Caso'
  options['tituloy'] = 'Média de Contatos por Caso'
  fim = if d.periodoFim isnt 'dia' then ' a '+d.periodoFim else ''
  options['categorias'] = d.periodoInicio+fim
  #nrContatos = parseInt(d.nrDomiciliar)+parseInt(d.nrFamiliar)+parseInt(d.nrEscolar)+parseInt(d.nrLaboral)+parseInt(d.nrEventoSocial)+parseInt(d.nrRelacaoOutros)
  return  parseFloat((parseInt(d.nrMonitorados)/parseFloat(d.nrRegistrados)).toFixed(2))

getDadosMotivosContatoDescartadoSegundoDia = (d)->
  options = d 
  options['titulo'] = 'Início do Monitoramento até o 2º dia'
  options['tituloy'] = 'Total contatos monitorados'
  fim = if options.tipo isnt 'diario' then ' a '+d.periodoFim else ''
  options['categories'] = ["Iniciados até o 2º dia", "Não Iniciados até o 2º dia", 'Ignorado']
  i = parseInt(if d.nrMonitoradosIgnoradosSegundo then d.nrMonitoradosIgnoradosSegundo else 0)
  nao = parseInt(if d.nrNaoMoniDoisPrimeiros then d.nrNaoMoniDoisPrimeiros else 0)
  total = i + nao + parseInt(d.nrMoniDoisPrimeiros)
  monitoradosegundodia =  parseInt(d.nrMoniDoisPrimeiros)
  monitoradonaosegundodia =  nao
  ignoradosegundo =  i
  options['series'] = [
    {
      name: ''
      colorByPoint: true
      data:[
        {
          name: "Iniciado até 2º dia"
          y: monitoradosegundodia
          color: '#8ED685'
        }
        {
          name: "Não Iniciado até 2º dia"
          y: monitoradonaosegundodia
          color: '#1f8ab5'
        }
        {
          name: "Ignorado"
          y: ignoradosegundo
          color: '#b3b3b3'
        }
      ]
    }
  ]
  options

getDadosMotivosContatoDescartadoDecimoQuartoDia = (d)->
  options =d
  options['titulo'] = 'Monitoramento dos Contatos no 14º dia'
  options['tituloy'] = 'Total contatos monitorados'
  fim = if options.tipo isnt 'diario' then ' a '+d.periodoFim else ''
  options['categories'] = ["Iniciados até 14º dia dias", "Não Iniciados até 14º dia dias", 'Ignorado']
  i = parseInt(if d.nrMonitoradosIgnorados then d.nrMonitoradosIgnorados else 0)
  nao = parseInt(if d.nrNaoMonitoradosDecimoQuato then d.nrNaoMonitoradosDecimoQuato else 0)
  #total = parseInt(d.nrMonitoradosDecimoQuato)+nao+i
  #console.log i, nao, d.nrMonitoradosDecimoQuato, 'percent', total, d
  monitoradodecimoquarto = parseInt(d.nrMonitoradosDecimoQuato)
  monitoradonaodecimoquarto = nao
  ignoradosegundo = i
  options['series'] = [
    {
      name: ''
      colorByPoint: true
      data:[
        {
          name: "Monitorado no 14º dia"
          y: monitoradodecimoquarto
          color: '#8ED685'
        }
        {
          name: "Não monitorado 14º dia"
          y: monitoradonaodecimoquarto
          color: '#1f8ab5'
        }
        {
          name: "Ignorado"
          y: ignoradosegundo
          color: '#b3b3b3'
        }
      ]
    }
  ]
  #console.log options, 'options relacoes'
  options
