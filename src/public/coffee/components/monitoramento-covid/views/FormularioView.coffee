define [
  '../collections/Monitoramentos'
  '../models/Monitoramento'
], (Monitoramentos, Monitoramento) ->

  class FormularioView extends Marionette.CompositeView
    initialize: ->
      {user, local} = App
      id = @model.get('id_local')
      l = App.monitoramentos.get(id)
      ###       console.log @model,'model'
      console.log l, 'monitoramento', id
      console.log App.monitoramentos, 'monitoramentos' ###
      @model.set('local', l.get('local')+' ('+l.get('municipio')+'/'+l.get('uf')+')')
      @model.set('tipo', l.get('tipo'))
      if not @model.get('id')
        @model.set 'id', ''
      @local = l
      $.datepicker.regional["pt-BR"] =
        closeText: "Fechar",
        prevText: "Anterior",
        nextText: "Próximo",
        currentText: "Hoje",
        monthNames: ["Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"],
        monthNamesShort: ["Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"],
        dayNames: ["Domingo","Segunda-feira","Terça-feira","Quarta-feira","Quinta-feira","Sexta-feira","Sabado"],
        dayNamesShort: ["Dom","Seg","Ter","Qua","Qui","Sex","Sab"],
        dayNamesMin: ["Dom","Seg","Ter","Qua","Qui","Sex","Sab"],
        weekHeader: "Sm",
        dateFormat: "dd/mm/yy",
        firstDay: 0,
        isRTL: false,
        showMonthAfterYear: false,
        yearSuffix: ""
      $.datepicker.setDefaults($.datepicker.regional["pt-BR"])

    className: 'container'

    template: '#monitoramento-covid-formulario'

    ui:
      'dtInicio': "#inputPeriodoInicio"
      'dtFim': "#inputPeriodoFim"
      'btnClear': ".btn-clear"
      'btnSave': ".btn-save"
      "inputLocal": "#inputLocal"
      "inputPeriodoInicio": "#inputPeriodoInicio"
      "inputPeriodoFim": "#inputPeriodoFim"
      "inputNrMonitorados": "#inputNrMonitorados"
      "inputNrRegistrados": "#inputNrRegistrados"
      "inputNrNaoIniciados": "#inputNrNaoIniciados"
      "inputNrEmAndamento": "#inputNrEmAndamento"
      "inputNrEncerrados": "#inputNrEncerrados"
      "inputIgnoradosSituacao": "#inputIgnoradosSituacao"
      "inputNrDomiciliar": "#inputNrDomiciliar"
      "inputNrFamiliar": "#inputNrFamiliar"
      "inputNrEscolar": "#inputNrEscolar"
      "inputNrLaboral": "#inputNrLaboral"
      "inputNrEventoSocial": "#inputNrEventoSocial"
      "inputNrRelacaoOutros": "#inputNrRelacaoOutros"
      "inputNrRelacaoIgnorados": "#inputNrRelacaoIgnorados"
      "inputNrPerdaSegmento": "#inputNrPerdaSegmento"
      "inputNaoEncontradoLigacao": "#inputNaoEncontradoLigacao"
      "inputNrRecusa": "#inputNrRecusa"
      "inputNrProblemasEquipe": "#inputNrProblemasEquipe"
      "inputNrDescartado": "#inputNrDescartado"
      "inputNrSuspeita": "#inputNrSuspeita"
      "inputNrConfirmado": "#inputNrConfirmado"
      "inputNrMotivoIgnorados": "#inputNrMotivoIgnorados"
      "inputNrMoniDoisPrimeiros":"#inputNrMoniDoisPrimeiros"
      "inputNrNaoMoniDoisPrimeiros":"#inputNrNaoMoniDoisPrimeiros"
      "inputNrMonitoradosIgnoradosSegundo":"#inputNrMonitoradosIgnoradosSegundo"
      "inputNrMonitoradosDecimoQuato":"#inputNrMonitoradosDecimoQuato"
      "inputNrNaoMonitoradosDecimoQuato":"#inputNrNaoMonitoradosDecimoQuato"
      "inputNrMonitoradosIgnorados":"#inputNrMonitoradosIgnorados"
      "inputNrMoniZeroOuTres":"#inputNrMoniZeroOuTres"
      "inputNrMoniQuatroOuSeis":"#inputNrMoniQuatroOuSeis"
      "inputNrMoniSeisOuMais":"#inputNrMoniSeisOuMais"
      "inputNrMonitoradosVezesIgnorados":"#inputNrMonitoradosVezesIgnorados"
      "mensagens":".mensagens"
      'entradasNumericas':'input[type=number]'

    events:
      'click .btn-clear': "limpar"
      'click .btn-save': "salvar"
      'change input': 'removeErro'
      'change @ui.inputNrMonitorados, @ui.inputNrNaoIniciados, @ui.inputNrEmAndamento, @ui.inputNrEncerrados': 'setIgnoradosSituacao'
      'change @ui.inputNrMonitorados, @ui.inputNrLaboral, @ui.inputNrEventoSocial, @ui.inputNrRelacaoOutros,@ui.inputNrDomiciliar, @ui.inputNrFamiliar, @ui.inputNrEscolar': 'setIgnoradosRelacao'
      'change @ui.inputNrEncerrados, @ui.inputNrPerdaSegmento, @ui.inputNaoEncontradoLigacao, @ui.inputNrRecusa,@ui.inputNrProblemasEquipe, @ui.inputNrDescartado, @ui.inputNrSuspeita, @ui.inputNrConfirmado': 'setIgnoradosMotivosEncerramento'
      'change @ui.inputNrDescartado, @ui.inputNrMoniDoisPrimeiros, @ui.inputNrNaoMoniDoisPrimeiros': 'setIgnoradosMonitorados'
      'change @ui.inputNrDescartado, @ui.inputNrMonitoradosDecimoQuato, @ui.inputNrNaoMonitoradosDecimoQuato': 'setIgnoradosMonitoradosDecimoQuarto'
      'change @ui.inputNrDescartado, @ui.inputNrMonitorados, @ui.inputNrMoniZeroOuTres, @ui.inputNrMoniQuatroOuSeis, @ui.inputNrMoniSeisOuMais': 'setIgnoradosVezes'
      'change @ui.inputPeriodoInicio': 'getNextDate'
      'change @ui.entradasNumericas': 'zeraNegativos'

    zeraNegativos:(e)=>
      if $(e.target).val() < 0
        $(e.target).val(0)
    
    setIgnoradosSituacao:()->
      monitorados = if @ui.inputNrMonitorados.val() then @ui.inputNrMonitorados.val() else 0 
      iniciados = if @ui.inputNrNaoIniciados.val() then @ui.inputNrNaoIniciados.val() else 0 
      andamento = if @ui.inputNrEmAndamento.val() then @ui.inputNrEmAndamento.val() else 0 
      encerrados = if @ui.inputNrEncerrados.val() then @ui.inputNrEncerrados.val() else 0 
      r = monitorados - iniciados - andamento - encerrados
      @ui.inputIgnoradosSituacao.val(r)
      r
    
    setIgnoradosRelacao:()->
      monitorados = if @ui.inputNrMonitorados.val() then @ui.inputNrMonitorados.val() else 0 
      domiciliar = if @ui.inputNrDomiciliar.val() then @ui.inputNrDomiciliar.val() else 0 
      familiar = if @ui.inputNrFamiliar.val() then @ui.inputNrFamiliar.val() else 0 
      escolar = if @ui.inputNrEscolar.val() then @ui.inputNrEscolar.val() else 0 
      laboral = if @ui.inputNrLaboral.val() then @ui.inputNrLaboral.val() else 0 
      evento = if @ui.inputNrEventoSocial.val() then @ui.inputNrEventoSocial.val() else 0 
      outros = if @ui.inputNrRelacaoOutros.val() then @ui.inputNrRelacaoOutros.val() else 0 
      r = monitorados - domiciliar - familiar - escolar - laboral - evento - outros
      @ui.inputNrRelacaoIgnorados.val(r)
      r
    
    setIgnoradosMotivosEncerramento:()->
      monitorados = if @ui.inputNrEncerrados.val() then @ui.inputNrEncerrados.val() else 0 
      perda = if @ui.inputNrPerdaSegmento.val() then @ui.inputNrPerdaSegmento.val() else 0 
      naoEncontradoLigacao = if @ui.inputNaoEncontradoLigacao.val() then @ui.inputNaoEncontradoLigacao.val() else 0 
      recusa = if @ui.inputNrRecusa.val() then @ui.inputNrRecusa.val() else 0 
      problemasEquipe = if @ui.inputNrProblemasEquipe.val() then @ui.inputNrProblemasEquipe.val() else 0 
      descartado = if @ui.inputNrDescartado.val() then @ui.inputNrDescartado.val() else 0 
      suspeita = if @ui.inputNrSuspeita.val() then @ui.inputNrSuspeita.val() else 0 
      confirmado = if @ui.inputNrConfirmado.val() then @ui.inputNrConfirmado.val() else 0 
      r = monitorados - perda - naoEncontradoLigacao - recusa - problemasEquipe - descartado - suspeita - confirmado
      @ui.inputNrMotivoIgnorados.val(r)
      r
   
    setIgnoradosMonitorados:()->
      monitorados = if @ui.inputNrDescartado.val() then @ui.inputNrDescartado.val() else 0 
      primeiro = if @ui.inputNrMoniDoisPrimeiros.val() then @ui.inputNrMoniDoisPrimeiros.val() else 0 
      naoprimeiro = if @ui.inputNrNaoMoniDoisPrimeiros.val() then @ui.inputNrNaoMoniDoisPrimeiros.val() else 0 
      r = monitorados - primeiro - naoprimeiro
      @ui.inputNrMonitoradosIgnoradosSegundo.val(r)
      r
   
    setIgnoradosMonitoradosDecimoQuarto:()->
      monitorados = if @ui.inputNrDescartado.val() then @ui.inputNrDescartado.val() else 0 
      quatorze = if @ui.inputNrMonitoradosDecimoQuato.val() then @ui.inputNrMonitoradosDecimoQuato.val() else 0 
      naoquatorze = if @ui.inputNrNaoMonitoradosDecimoQuato.val() then @ui.inputNrNaoMonitoradosDecimoQuato.val() else 0 
      r = monitorados - quatorze - naoquatorze
      @ui.inputNrMonitoradosIgnorados.val(r)
      r

    setIgnoradosVezes:()->
      monitorados = if @ui.inputNrDescartado.val() then @ui.inputNrDescartado.val() else 0 
      tres = if @ui.inputNrMoniZeroOuTres.val() then @ui.inputNrMoniZeroOuTres.val() else 0 
      quatroSeis = if @ui.inputNrMoniQuatroOuSeis.val() then @ui.inputNrMoniQuatroOuSeis.val() else 0 
      seisMais = if @ui.inputNrMoniSeisOuMais.val() then @ui.inputNrMoniSeisOuMais.val() else 0 
      r = monitorados - tres - quatroSeis - seisMais
      @ui.inputNrMonitoradosVezesIgnorados.val(r)
      r

    removeErro:(e)->
      $(e.target).parent().removeClass 'has-error'
    getDados:()->
      dados =        
        "nrMonitorados": @ui.inputNrMonitorados.val()
        "nrRegistrados": @ui.inputNrRegistrados.val()
        "nrNaoIniciados": @ui.inputNrNaoIniciados.val()
        "nrEmAndamento": @ui.inputNrEmAndamento.val()
        "nrEncerrados": @ui.inputNrEncerrados.val()
        "nrIgnoradosSituacao": @ui.inputIgnoradosSituacao.val()
        "nrDomiciliar": @ui.inputNrDomiciliar.val()
        "nrFamiliar": @ui.inputNrFamiliar.val()
        "nrEscolar": @ui.inputNrEscolar.val()
        "nrLaboral": @ui.inputNrLaboral.val()
        "nrEventoSocial": @ui.inputNrEventoSocial.val()
        "nrRelacaoOutros": @ui.inputNrRelacaoOutros.val()
        "nrRelacaoIgnorados": @ui.inputNrRelacaoIgnorados.val()
        "nrPerdaSegmento": @ui.inputNrPerdaSegmento.val()
        "naoEncontradoLigacao": @ui.inputNaoEncontradoLigacao.val()
        "nrRecusa": @ui.inputNrRecusa.val()
        "nrProblemasEquipe": @ui.inputNrProblemasEquipe.val()
        "nrDescartado": @ui.inputNrDescartado.val()
        "nrSuspeita": @ui.inputNrSuspeita.val()
        "nrConfirmado": @ui.inputNrConfirmado.val()
        "nrMotivoIgnorados": @ui.inputNrMotivoIgnorados.val()
        "nrMoniDoisPrimeiros": @ui.inputNrMoniDoisPrimeiros.val()
        "nrNaoMoniDoisPrimeiros": @ui.inputNrNaoMoniDoisPrimeiros.val()
        "nrMonitoradosIgnoradosSegundo": @ui.inputNrMonitoradosIgnoradosSegundo.val()
        "nrMonitoradosDecimoQuato": @ui.inputNrMonitoradosDecimoQuato.val()
        "nrNaoMonitoradosDecimoQuato": @ui.inputNrNaoMonitoradosDecimoQuato.val()
        "nrMonitoradosIgnorados": @ui.inputNrMonitoradosIgnorados.val()
        "nrMoniZeroOuTres": @ui.inputNrMoniZeroOuTres.val()
        "nrMoniQuatroOuSeis": @ui.inputNrMoniQuatroOuSeis.val()
        "nrMoniSeisOuMais": @ui.inputNrMoniSeisOuMais.val()
        "nrMoniIgnorados": @ui.inputNrMonitoradosVezesIgnorados.val()
      dados

    salvar:()->
      dados = @getDados()
      if @model.get('tipo') isnt 'diario'
        dados["periodoFim"] = @ui.inputPeriodoFim.val()
      dados["periodoInicio"] = @ui.inputPeriodoInicio.val()
      err = false
      camposErros = []
      msgErros = []
      msgErros = @validateDatePeriodos(dados,msgErros)
      console.log dados, 'dados'
      for v of dados
        if not dados[v]
          err = true
          camposErros.push '#input'+v.slice(0,1).toUpperCase()+v.slice(1)
        if parseInt(dados[v]) > parseInt(dados['nrMonitorados']) and ['periodoFim','periodoInicio'].indexOf(v) is -1
          err = true
          camposErros.push '#input'+v.slice(0,1).toUpperCase()+v.slice(1)
          msgErros.push('Nenhum dos valores pode ultrapassar o numero de monitorados!')
          console.log v,'nenhum', parseInt(dados[v]) , parseInt(dados['nrMonitorados']), parseInt(dados[v]) > parseInt(dados['nrMonitorados'])
        if parseInt(dados[v]) < 0 and ['periodoFim','periodoInicio'].indexOf(v) is -1
          err = true
          camposErros.push '#input'+v.slice(0,1).toUpperCase()+v.slice(1)
          msgErros.push('Nenhum dos valores pode ser negativo!')
      totalSituacoes = parseInt(dados.nrNaoIniciados) + parseInt(dados.nrEmAndamento) + parseInt(dados.nrEncerrados) + parseInt(dados.nrIgnoradosSituacao)
      #console.log dados, totalSituacoes , parseInt(dados.nrMonitorados), 'teste'
      if totalSituacoes != parseInt(dados.nrMonitorados)
        err = true
        camposErros.push '#inputIgnoradosSituacao'
        msgErros.push('Em Situação do Monitoramento a soma não pode exceder o total de contatos.')
      totalRelacao = parseInt(dados.nrDomiciliar) + parseInt(dados.nrFamiliar) + parseInt(dados.nrEscolar)+ parseInt(dados.nrLaboral)+ parseInt(dados.nrEventoSocial)+ parseInt(dados.nrRelacaoOutros) + parseInt(dados.nrRelacaoIgnorados)
      if totalRelacao != parseInt(dados.nrMonitorados)
        err = true
        camposErros.push '#inputNrRelacaoIgnorados'
        msgErros.push('Em Tipo de Relação com o Caso a soma não pode exceder o total de contatos.')
      totalMotivos = parseInt(dados.nrPerdaSegmento) + parseInt(dados.naoEncontradoLigacao) + parseInt(dados.nrRecusa)+ parseInt(dados.nrProblemasEquipe)+ parseInt(dados.nrDescartado)+ parseInt(dados.nrSuspeita)+ parseInt(dados.nrConfirmado) + parseInt(dados.nrMotivoIgnorados)
      if totalMotivos != parseInt(dados.nrEncerrados)
        err = true
        camposErros.push '#inputNrMotivoIgnorados'
        msgErros.push('Em Motivo de Encerramento a soma não pode exceder os contatos encerrados.')
      if parseInt(dados.nrMoniDoisPrimeiros) + parseInt(dados.nrNaoMoniDoisPrimeiros) + parseInt(dados.nrMonitoradosIgnoradosSegundo) != parseInt(dados.nrDescartado)
        err = true
        camposErros.push '#inputNrMonitoradosIgnoradosSegundo'
        msgErros.push('Em Início do Monitoramento até o 2º dia a soma não pode exceder os contatos descartados.')
      totalDescartadoDecimoQuarto = parseInt(dados.nrMonitoradosDecimoQuato) + parseInt(dados.nrNaoMonitoradosDecimoQuato) + parseInt(dados.nrMonitoradosIgnorados)
      #console.log totalDescartadoDecimoQuarto, parseInt(dados.nrDescartado), dados.nrMonitoradosDecimoQuato, parseInt(dados.nrNaoMonitoradosDecimoQuato), dados.nrMonitoradosIgnorados 
      if totalDescartadoDecimoQuarto != parseInt(dados.nrDescartado)
        err = true
        camposErros.push '#inputNrMonitoradosIgnorados'
        msgErros.push('Em Monitoramento dos Contatos no 14º dia a soma não pode exceder os contatos descartados.')
      if parseInt(dados.nrMoniZeroOuTres) + parseInt(dados.nrMoniQuatroOuSeis) + parseInt(dados.nrMoniSeisOuMais) + parseInt(dados.nrMoniIgnorados) != parseInt(dados.nrDescartado)
        err = true
        camposErros.push '#inputNrMonitoradosVezesIgnorados'
        msgErros.push('Em Número de Comunicações com Cada Contato a soma não pode exceder os contatos descartados.')
      if err
        camposErros.forEach (c)->
          $(c).parent().addClass 'has-error'
        $(camposErros[0]).focus()
        msgErros.push('Verifique campos sem preenchimento!')
        @exibeMensagens(msgErros)
        return
      dados["user"] = App.user.cpf
      dados["tipo"] = 'covid'
      dados["id_local"] = @model.get('id_local')
      dados["local"] = @model.get('local')
      
      #console.log err, camposErros, 'campoerros', msgErros
      if msgErros.length > 0
        @exibeMensagens(msgErros)
        return

      dados['ano'] = dados.periodoInicio.split('/')[2]
      if @model.get('id')
        dados['id'] = @model.get('id')
      try
        App.monitoramentos.addAmostra(dados)
        id_local = @model.get('id_local')
        if id_local
          App.appRouter.navigate '#comp/monitoramento-covid/local/'+@model.get('id_local'), 'trigger': yes
        else
          App.appRouter.navigate '#comp/monitoramento-covid/', 'trigger': yes
      catch e
        @exibeMensagens([e])
        @ui.inputPeriodoInicio.parent().addClass 'has-error'
        @ui.inputPeriodoInicio.focus()
        return
      
    limpar:()->
      @$el.find('input[type=number]').val('')
    exibeMensagens:(msgs)->
      @ui.mensagens.empty()
      if msgs.length
        text = ""
        msgs.forEach (m)->
          text += "<li>"+m+"</li>"
        @ui.mensagens.append("<div class='alert alert-danger'><ul>"+text+"</ul></div>")
    preenche:()->
      padrao = ''
      #console.log @model.attributes, 'dados'
      id = @model.get('id')
      @ui.inputLocal.val(if id then @model.get('local') else 'teste local')
      @ui.inputPeriodoInicio.val(if id then @model.get('periodoInicio') else '')
      @ui.inputPeriodoFim.val(if id then @model.get('periodoFim') else '')
      @ui.inputNrMonitorados.val(if id then @model.get('nrMonitorados') else padrao)
      @ui.inputNrRegistrados.val(if id then @model.get('nrRegistrados') else padrao)
      @ui.inputNrNaoIniciados.val(if id then @model.get('nrNaoIniciados') else padrao)
      @ui.inputNrEmAndamento.val(if id then @model.get('nrEmAndamento') else padrao)
      @ui.inputNrEncerrados.val(if id then @model.get('nrEncerrados') else padrao)
      @ui.inputIgnoradosSituacao.val(if id then @model.get("nrIgnoradosSituacao") else padrao)
      @ui.inputNrDomiciliar.val(if id then @model.get('nrDomiciliar') else padrao)
      @ui.inputNrFamiliar.val(if id then @model.get('nrFamiliar') else padrao)
      @ui.inputNrEscolar.val(if id then @model.get('nrEscolar') else padrao)
      @ui.inputNrLaboral.val(if id then @model.get('nrLaboral') else padrao)
      @ui.inputNrEventoSocial.val(if id then @model.get('nrEventoSocial') else padrao)
      @ui.inputNrRelacaoOutros.val(if id then @model.get('nrRelacaoOutros') else padrao)
      @ui.inputNrRelacaoIgnorados.val(if id then @model.get("nrRelacaoIgnorados") else padrao)
      @ui.inputNrPerdaSegmento.val(if id then @model.get('nrPerdaSegmento') else padrao)
      @ui.inputNaoEncontradoLigacao.val(if id then @model.get('naoEncontradoLigacao') else padrao)
      @ui.inputNrRecusa.val(if id then @model.get('nrRecusa') else padrao)
      @ui.inputNrProblemasEquipe.val(if id then @model.get('nrProblemasEquipe') else padrao)
      @ui.inputNrDescartado.val(if id then @model.get('nrDescartado') else padrao)
      @ui.inputNrSuspeita.val(if id then @model.get('nrSuspeita') else padrao)
      @ui.inputNrConfirmado.val(if id then @model.get('nrConfirmado') else padrao)
      @ui.inputNrMotivoIgnorados.val(if id then @model.get("nrMotivoIgnorados") else padrao)
      @ui.inputNrMoniDoisPrimeiros.val(if id then @model.get('nrMoniDoisPrimeiros') else padrao)
      @ui.inputNrNaoMoniDoisPrimeiros.val(if id then @model.get('nrNaoMoniDoisPrimeiros') else padrao)
      @ui.inputNrMonitoradosDecimoQuato.val(if id then @model.get('nrMonitoradosDecimoQuato') else padrao)
      @ui.inputNrNaoMonitoradosDecimoQuato.val(if id then @model.get('nrNaoMonitoradosDecimoQuato') else padrao)
      @ui.inputNrMonitoradosIgnoradosSegundo.val(if id then @model.get("nrMonitoradosIgnoradosSegundo") else padrao)
      @ui.inputNrMonitoradosIgnorados.val(if id then @model.get("nrMonitoradosIgnorados") else padrao)
      @ui.inputNrMoniZeroOuTres.val(if id then @model.get('nrMoniZeroOuTres') else padrao)
      @ui.inputNrMoniQuatroOuSeis.val(if id then @model.get('nrMoniQuatroOuSeis') else padrao)
      @ui.inputNrMoniSeisOuMais.val(if id then @model.get('nrMoniSeisOuMais') else padrao)
      @ui.inputNrMonitoradosVezesIgnorados.val(if id then @model.get("nrMoniIgnorados") else padrao)

    validateDatePeriodos:(dados, msgErros)->
      msgErros unless dados.periodoInicio
      i = dados.periodoInicio.split('/')
      dt_ini = new Date(i[1]+'/'+i[0]+'/'+i[2])
      if @model.get('tipo') isnt 'diario'
        return msgErros unless dados.periodoFim
        f = dados.periodoFim.split('/')
        dt_fim = new Date(f[1]+'/'+f[0]+'/'+f[2])
        if dt_ini > dt_fim
          msgErros.push('A data de início do periodo não pode ser maior que a data de fim!')
        intervalo = (dt_fim - dt_ini)/1000/60/60/24
        if @model.get('tipo') is 'semanal' and intervalo < 6
          msgErros.push('Você selecionou periodicidade de avaliação semanal, assim o período informado deve ser de 7 dias!')
        if @model.get('tipo') is 'mensal' 
          dias = @diasNoMes(i[1],i[2])
          #console.log dias, 'dias', intervalo, dt_ini.getMonth(),i[2]
          if ((intervalo < 30 and dias is 31) or (intervalo < 29 and dias is 30) or (intervalo < 28 and dias is 29) or (intervalo < 27 and dias is 28))
            msgErros.push('Você configurou o local para periodos mensais, o periodo informado deve ter no mínimo um mês!')
          if ((intervalo > 30 and dias is 31) or (intervalo > 29 and dias is 30) or (intervalo > 28 and dias is 29) or (intervalo > 27 and dias is 28))
            msgErros.push('Você configurou o local para periodos mensais, o periodo informado deve ter no máximo um mês!')
      msgErros

    diasNoMes:(mes, ano)->
      #console.log mes, ano, '<= mes/ano'
      data = new Date(ano, mes, 0)
      data.getDate()

    getDateInternational:(strDate)->
      strDate = strDate.split('/')
      c = strDate[0]
      strDate[0] = strDate[1]
      strDate[1] = c
      strDate.join('/')

    getNextDate: ()->
      dataStart = @ui.inputPeriodoInicio.val()
      if not dataStart
        pi = @getLastDateInicio()
        df = false
        if pi
          d = new Date(@getDateInternational(pi))
          df = new Date(@getDateInternational(pi))
          switch @local.get('tipo')
            when 'mensal'
              d.setMonth(d.getMonth()+1)
            when 'semanal'
              d.setDate(d.getDate()+7)
            when 'diario'
              d.setDate(d.getDate()+1)
        else
          d = new Date()
          if @local.get('tipo') isnt 'diario'
            df = new Date()
      else
        pi = (new Date(@getDateInternational(dataStart))).toLocaleDateString()
        d = new Date(@getDateInternational(pi))
        df = new Date(@getDateInternational(pi))
      switch @local.get('tipo')
        when 'mensal'
          df.setTime(d.getTime())
          df.setMonth(d.getMonth()+1)
          #console.log df.getMonth(), 'mes'
          df.setDate(d.getDate()-1)
        when 'semanal'
          if pi 
            df.setTime(d.getTime())
            df.setDate(d.getDate()+6)
          else
            df.setTime(d.getTime())
            d.setDate(d.getDate()-6)
      if not dataStart
        @ui.inputPeriodoInicio.val(d.toLocaleDateString())
      @ui.inputPeriodoFim.val(df.toLocaleDateString()) if df

    getLastDateInicio:()->
      dados = @local.get('dados')
      if dados.length is 0 
        return '' 
      else 
        maior = new Date(0)
      self = @
      dados.forEach (d)->
        d_date = new Date(self.getDateInternational(d.periodoInicio))
        if d_date.getTime() > maior.getTime()
          maior = d_date
      return maior.toLocaleDateString()

      
    onRender: ->
      @ui.dtInicio.datepicker()
      @ui.dtFim.datepicker()
      @preenche()
      if not @model.get('periodoInicio')
        @getNextDate()



  FormularioView