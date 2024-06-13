define [
  './MonitoramentoItemView'
], (MonitoramentoItemView) ->

  class LocalView extends Marionette.CompositeView
    childView: MonitoramentoItemView,
    childViewContainer: '.amostras'
    initialize: ->
      console.log @model, 'modelo local'
      self = @
      @getCollectionDados()
    className: ' container'

    template: '#monitoramento-covid-local'
    
    ui:
      'btnGraficos':'.btn-graficos'
      'amostras':'.amostras'
      'corpoGraficos':'.graficos-locais'
      'up':'.glyphicon-chevron-up'
      'down':'.glyphicon-chevron-down'
    
    events:
      'click @ui.btnGraficos':'graficos'
    
    modelEvents:
      'change': 'modelChanged'

    modelChanged:()-> 
      @getCollectionDados()

    getCollectionDados:()->
      self = @
      @collection = new Backbone.Collection @model.get('dados').map (d)->
        d['tipo']= self.model.get('tipo')
        d
      @collection.comparator = (i)->
        return new Date(self.getDateInternational(i.get('periodoInicio')))
      @collection.sort()
    
    graficos:()->
      if @$el.find('.icon-grafico-local.glyphicon-chevron-up:visible').length > 0
        @ui.corpoGraficos.show()
        @$el.find('.icon-grafico-local').addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-up')
      else
        @$el.find('.icon-grafico-local').addClass('glyphicon-chevron-up').removeClass('glyphicon-chevron-down')
        @ui.corpoGraficos.hide()
        return
      modelo = @model.attributes
      @getGraficoBarras('media-contatos', getDadosMediaContatoLocal(modelo))
      @getGraficoSobreposto('situacao', getDadosSituacaoMonitoramentoLocal(modelo))
      @getGraficoSobreposto('relacao', getDadosTiposRelacaoContatoLocal(modelo))
      @getGraficoSobreposto('motivos-encerramento', getDadosNrMotivosEncerramentoLocal(modelo))
      dia = getDadosMotivosContatoDescartadoSegundoDiaLocal(modelo)
      @getGraficoSobreposto('motivos-contato-descartado-segundo-dia', dia)
      dia2 = getDadosMotivosContatoDescartadoDecimoQuartoDiaLocal(modelo)
      @getGraficoSobreposto('motivos-contato-descartado-decimo-quarto-dia', getDadosMotivosContatoDescartadoDecimoQuartoDiaLocal(modelo))
      @getGraficoSobreposto('vezes-monitoradas', getDadosNrMonitoramentosLocal(modelo))
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
        styleMode: true
        title: text: options.titulo
        xAxis: categories: options.categorias
        yAxis:
          min: 0
          title: text: options.tituloy
        tooltip: options.tooltip 
        plotOptions: column: stacking: options.stacking
        series: options.series
    getGraficoArtico:(elemento, options)->
      Highcharts.chart elemento,
        chart:
          type: 'column'
          inverted: true
          polar: true
        styleMode: true
        title: text: options.titulo
        tooltip: outside: true
        pane:
          size: '85%'
          innerSize: '20%'
          endAngle: 270
        xAxis:
          tickInterval: 1
          labels:
            align: 'right'
            useHTML: true
            allowOverlap: true
            step: 1
            y: 3
            style: fontSize: '13px'
          lineWidth: 0
          categories: [
            'Perda de seguimento <span class="f16"><span id="flag" class="flag no">' + '</span></span>'
            'Não encontrado na ligação <span class="f16"><span id="flag" class="flag us">' + '</span></span>'
            'Recusa <span class="f16"><span id="flag" class="flag de">' + '</span></span>'
            'Problemas com a equipe de monitoramento <span class="f16"><span id="flag" class="flag ca">' + '</span></span>'
            'Contato descartado, suspeita de covid-19 <span class="f16"><span id="flag" class="flag at">' + '</span></span>'
            'Confirmado para covid-19 <span class="f16"><span id="flag" class="flag at">' + '</span></span>'
          ]
        yAxis:
          crosshair:
            enabled: true
            color: '#333'
          lineWidth: 0
          tickInterval: 25
          reversedStacks: false
          endOnTick: true
          showLastLabel: true
        plotOptions: column:
          stacking: 'normal'
          borderWidth: 0
          pointPadding: 0
          groupPadding: 0.15
        series: options.series  
    getGraficoLinhas:(elemento,options)->
      Highcharts.chart elemento,
        chart: type: 'line'
        styleMode: true
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
        styleMode: true
        title: text: options.titulo
        tooltip: pointFormat: '{series.name}: <b>{point.value:.1f}%</b>'
        accessibility: point: valueSuffix: '%'
        plotOptions: pie:
          allowPointSelect: true
          cursor: 'pointer'
          dataLabels: enabled: false
          showInLegend: true
        series: options.series
    getGraficoBarras:(elemento, options)->
      Highcharts.chart elemento,
        chart: type: 'column'
        title: text: options.titulo
        subtitle: text: ''
        styleMode: true
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
    getDateInternational:(strDate)->
      strDate = strDate.split('/')
      c = strDate[0]
      strDate[0] = strDate[1]
      strDate[1] = c
      strDate.join('/')

    onRender: ->
      self = @
      #console.log 'collection', @ui.amostras
      if @collection.length is 0
        @ui.amostras.append '<li class="list-group-item"><h2><small>Você não tem Periodos em Avaliação a serem exibidos. Clique em "Inserir Dados"</small></h2></li>'

  LocalView
getPorcentagem = (v, total)->
  return 0 unless v
  return 0 unless total
  parseFloat((parseFloat(v) * 100 / total).toFixed(2))

getDadosSituacaoMonitoramentoLocal = (modelo)->
  options ={
    dados: modelo.dados
    tipo: modelo.tipo
  }
  naoIniciado = []
  andamento = []
  encerrado = []
  situacaoIgnorados = []
  options['titulo'] = 'Situação do Monitoramento'
  options['tituloy'] = '% Todos os Contatos'
  options['categorias'] = options.dados.map (d)->
    fim = if options.tipo isnt 'diario' then ' a '+d.periodoFim else ''
    d.periodoInicio+fim
  options.dados.forEach (d)->
    i = if d.nrIgnoradosSituacao then d.nrIgnoradosSituacao else 0
    #total = parseInt(d.nrNaoIniciados)+parseInt(d.nrEmAndamento)+parseInt(d.nrEncerrados)+parseInt(i)
    naoIniciado.push((parseFloat(d.nrNaoIniciados)))
    andamento.push((parseFloat(d.nrEmAndamento)))
    encerrado.push((parseFloat(d.nrEncerrados)))
    situacaoIgnorados.push((parseFloat(i)))
  options['series'] = [
    {
      name: "Não iniciado"
      data: naoIniciado
      color:'#73e5da'
    }
    {
      name: "Em andamento"
      data: andamento
      color: '#8ed685'
    }
    {
      name: "Encerrado"
      data: encerrado
      color: '#1f8ab5'
    }
    {
      name: "Ignorado"
      data: situacaoIgnorados
      color: '#b3b3b3'
    }
  ]
  console.log options, 'options situacao'
  options

getDadosTiposRelacaoContatoLocal = (modelo)->
  options ={
    dados: modelo.dados
    tipo: modelo.tipo
  }
  domiciliar = []
  familiar = []
  escolar = []
  laboral = []
  evento = []
  outros = []
  relacaoIgnorados = []
  options['titulo'] = 'Tipo de Relação com o Caso'
  options['tituloy'] = '% Todos os Contatos'
  options['categorias'] = options.dados.map (d)->
    fim = if options.tipo isnt 'diario' then ' a '+d.periodoFim else ''
    d.periodoInicio+fim
  options.dados.forEach (d)->
    #nrContatos = parseInt(d.nrDomiciliar)+parseInt(d.nrFamiliar)+parseInt(d.nrEscolar)+parseInt(d.nrLaboral)+parseInt(d.nrEventoSocial)+parseInt(d.nrRelacaoOutros)+parseInt(if d.nrRelacaoIgnorados then d.nrRelacaoIgnorados else 0)
    domiciliar.push((parseFloat(d.nrDomiciliar)))
    familiar.push((parseFloat(d.nrFamiliar)))
    escolar.push((parseFloat(d.nrEscolar)))
    laboral.push((parseFloat(d.nrLaboral)))
    evento.push((parseFloat(d.nrEventoSocial)))
    outros.push((parseFloat(d.nrRelacaoOutros)))
    relacaoIgnorados.push((parseFloat((if d.nrRelacaoIgnorados then d.nrRelacaoIgnorados else 0))))
  options['series'] = [
    {
      name: "Domiciliar"
      data: domiciliar
      color: '#8ED685'
    }
    {
      name: "Familiar"
      data: familiar
      color: '#51A892'
    }
    {
      name: "Escolar"
      data: escolar
      color: '#c1f0a2'
    }
    {
      name: "Laboral"
      data: laboral
      color: '#1F8AB5'
    }
    {
      name: "Evento Social"
      data: evento
      color: '#73E5DA'
    }
    {
      name: "Outro"
      data: outros
      color: '#5C77BC'
    }
    {
      name: "Ignorado"
      data: relacaoIgnorados
      color: '#b3b3b3'
    }
  ]
  console.log options, 'options relacao'
  options

getDadosNrMonitoramentosLocal = (modelo)->
  options ={
    dados: modelo.dados
    tipo: modelo.tipo
  }
  tresoumenos = []
  quatroouseis = []
  seteoumais = []
  moniIgnorados = []
  options['titulo'] = 'Número de Comunicações com Cada Contato'
  options['tituloy'] = '% Contatos Descartados'
  options['categorias'] = options.dados.map (d)->
    fim = if options.tipo isnt 'diario' then ' a '+d.periodoFim else ''
    d.periodoInicio+fim
  options.dados.forEach (d)->
    #nrDescartados = parseInt(d.nrDescartado)
    #console.log d.nrMoniZeroOuTres, nrDescartados, 'vezes'
    tresoumenos.push(parseInt(d.nrMoniZeroOuTres))
    quatroouseis.push(parseInt(d.nrMoniQuatroOuSeis))
    seteoumais.push(parseInt(d.nrMoniSeisOuMais))
    moniIgnorados.push(parseInt((if d.nrMoniIgnorados then d.nrMoniIgnorados else 0)))
  options['series'] = [
    {
      name: "3 vezes ou menos"
      data: tresoumenos
      color:'#73e5da'
    }
    {
      name: "4 a 6 vezes"
      data: quatroouseis
      color: '#1F8AB5'
    }
    {
      name: "7 vezes ou mais"
      data: seteoumais
      color: '#8ed685'
    }
    {
      name: "Ignorado"
      data: moniIgnorados
      color:'#b3b3b3'
    }
  ]
  #console.log 'frequencia', options
  options

getDadosNrMotivosEncerramentoLocal = (modelo)->
  options ={
    dados: modelo.dados
    tipo: modelo.tipo
  }
  perdaSegmento = []
  naoEncontradoLigacao = []
  recusa = []
  problemasEquipe = []
  descartado = []
  suspeita = []
  confirmado = []
  completo = []
  incompleto = []
  ignorado = []
  options['titulo'] = 'Motivo de Encerramento'
  options['tituloy'] = '% Contatos Encerrados'
  options['categorias'] = options.dados.map (d)->
    fim = if options.tipo isnt 'diario' then ' a '+d.periodoFim else ''
    d.periodoInicio+fim
  options.dados.forEach (d)->
    perdaSegmento.push(parseInt(d.nrPerdaSegmento))
    naoEncontradoLigacao.push(parseInt(d.naoEncontradoLigacao))
    recusa.push(parseInt(d.nrRecusa))
    problemasEquipe.push(parseInt(d.nrProblemasEquipe))
    incompleto.push(parseInt(d.nrPerdaSegmento)+parseInt(d.naoEncontradoLigacao)+parseInt(d.nrRecusa)+parseInt(d.nrProblemasEquipe))
    #
    suspeita.push(parseInt(d.nrSuspeita))
    ignorado.push(parseInt(if d.nrMotivoIgnorados then d.nrMotivoIgnorados else 0))
    descartado.push(parseInt(d.nrDescartado))
    confirmado.push(parseInt(d.nrConfirmado))
    completo.push(parseInt(d.nrDescartado)+parseInt(d.nrSuspeita)+parseInt(d.nrConfirmado))
  options['series'] = [
    {
      name: "Monitoramento incompleto"
      data: incompleto
      stack:'status'
      color:'#1d588f'
    }
    {
      name: "Monitoramento completo"
      data: completo
      stack:'status'
      color:'#599d66'
    }
    {
      name: "Ignorado"
      data: ignorado
      stack:'status'
      color:'#b3b3b3'
    }
    {
      name: "Perda de seguimento"
      data: perdaSegmento
      stack:'tipo'
      color:'#73e5da'
    }
    {
      name: "Não encontrado na ligação"
      data: naoEncontradoLigacao
      stack:'tipo'
      color:'#1f8ab5'
    }
    {
      name: "Recusa"
      data: recusa
      stack:'tipo'
      color:'#5c77bc'
    }
    {
      name: "Problemas na equipe"
      data: problemasEquipe
      stack:'tipo'
      color:'#aeb8dc'
    }
    {
      name: "Descartado"
      data: descartado
      stack:'tipo'
      color:'#a3cea5'
    }
    {
      name: "Suspeita de covid-19"
      data: suspeita
      stack:'tipo'
      color:'#c1f0a2'
    }
    {
      name: "Confirmado para covid-19"
      data: confirmado
      stack:'tipo'
      color: '#8ed685'
    }
    {
      name: "Ignorado"
      data: ignorado
      stack:'tipo'
      color:'#b3b3b3'
      showInLegend:false
    }
  ]
  #console.log options.series, 'teste agora'
  options

getDadosMotivosContatoDescartadoSegundoDiaLocal = (modelo)->
  #console.log 'dados 2', modelo.dados
  options ={
    dados: modelo.dados
    tipo: modelo.tipo
  }
  monitoradosegundodia = []
  monitoradonaosegundodia = []
  ignoradosegundo = []
  options['titulo'] = 'Início do Monitoramento até o 2º dia'
  options['tituloy'] = '% Contatos Descartados'
  options['categorias'] = options.dados.map (d)->
    fim = if options.tipo isnt 'diario' then ' a '+d.periodoFim else ''
    d.periodoInicio+fim
  options.dados.forEach (d)->
    i = parseInt(if d.nrMonitoradosIgnoradosSegundo then d.nrMonitoradosIgnoradosSegundo else 0)
    nao = parseInt(if d.nrNaoMoniDoisPrimeiros then d.nrNaoMoniDoisPrimeiros else 0)
    #total = i + nao + parseInt(d.nrMoniDoisPrimeiros)
    monitoradosegundodia.push(parseInt(d.nrMoniDoisPrimeiros))
    monitoradonaosegundodia.push(nao)
    ignoradosegundo.push(i)
  options['series'] = [
    {
      name: "Iniciado até o 2º dia"
      data: monitoradosegundodia
      color: '#8ed685'
    }
    {
      name: "Não iniciado até o 2º dia"
      data: monitoradonaosegundodia
      color: '#1f8ab5'
    }
    {
      name: "Ignorado"
      data: ignoradosegundo
      color: '#b3b3b3'
    }
  ]
  #console.log options, 'options segundo'
  options

getDadosMotivosContatoDescartadoDecimoQuartoDiaLocal = (modelo)->
  #console.log 'dados 14', modelo.dados
  options ={
    dados: modelo.dados
    tipo: modelo.tipo
  }
  monitoradodecimoquarto = []
  monitoradonaodecimoquarto = []
  ignoradosegundo = []
  options['titulo'] = 'Monitoramento de contatos no 14º dia'
  options['tituloy'] = '% Contatos Descartados'
  options['categorias'] = options.dados.map (d)->
    fim = if options.tipo isnt 'diario' then ' a '+d.periodoFim else ''
    d.periodoInicio+fim
  options.dados.forEach (d)->
    i = parseInt(if d.nrMoniIgnorados then d.nrMoniIgnorados else 0)
    nao = parseInt(if d.nrNaoMonitoradosDecimoQuato then d.nrNaoMonitoradosDecimoQuato else 0)
    #total = parseInt(d.nrMonitoradosDecimoQuato)+nao+i
    monitoradodecimoquarto.push(parseInt(d.nrMonitoradosDecimoQuato))
    monitoradonaodecimoquarto.push(nao)
    ignoradosegundo.push(i)
  options['series'] = [
    {
      name: "Monitorado no 14º dia"
      data: monitoradodecimoquarto
      color: '#8ed685'
    }
    {
      name: "Não monitorado no 14º dia"
      data: monitoradodecimoquarto
      color: '#1f8ab5'
    }
    {
      name: "Ignorado"
      data: ignoradosegundo
      color: '#b3b3b3'
    }
  ]
  #console.log options, 'options 14'
  options

getDadosMediaContatoLocal = (modelo)->
  options ={
    dados: modelo.dados
    tipo: modelo.tipo
  }
  media = []
  options['titulo'] = 'Média de Contatos por Caso'
  options['tituloy'] = 'Média de Contatos por Caso'
  options['categorias'] = options.dados.map (d)->
    fim = if options.tipo isnt 'diario' then ' a '+d.periodoFim else ''
    d.periodoInicio+fim
  options.dados.forEach (d)->
    #nrContatos = parseInt(d.nrDomiciliar)+parseInt(d.nrFamiliar)+parseInt(d.nrEscolar)+parseInt(d.nrLaboral)+parseInt(d.nrEventoSocial)+parseInt(d.nrRelacaoOutros)
    media.push((parseFloat(d.nrMonitorados)/parseInt(d.nrRegistrados)))
  options['series'] = [
    {
      name: "Média de contatos"
      data: media
    }
  ]
  options

