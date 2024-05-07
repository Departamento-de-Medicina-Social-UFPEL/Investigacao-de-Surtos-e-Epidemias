define ['backbone', 'backbone.marionette'], (Backbone, Marionette) ->
  class calCovidMainView extends Marionette.ItemView

    model: new Backbone.Model

    className: 'item calculadoras calCovid'

    template: '#calc-covid-main'

    ui:
      'resp':'.resultado'
      'condutaBox':'.condutaBox'
      'item':'.item'
      'li':'li'
      'processo':'.processoTrabalho'
      'dtatualdia': '#dt-atual-dia'
      'dtatualmes': '#dt-atual-mes'
      'dtatualano': '#dt-atual-ano'
      'tem11anos':'input[name="optionRadiosIdade"]'
      'dezanos':'.10anos'
      'qdezanos':'.q10anos'
      'onzeanos':'.11anos'
      'qtevesintomas':'input:radio[name="optiontevesintomas10"]'
      'qperdaolfato':'input:radio[name="optionRadiosPerdaolfato"]'
      'qperdaPaladar':'input:radio[name="optionRadiosPerdaPaladar"]'
      'qgastrointestinais':'input:radio[name="optionRadiosGastrointestinais"]'
      'qfaltadear':'input:radio[name="optionRadiosFaltadear"]'
      'qpressaoTorax':'input:radio[name="optionRadiosPressaoTorax"]'
      'qsaturacao':'input:radio[name="optionRadiosSaturacao"]'
      'qcoloracaoazulada':'input:radio[name="optionRadiosColoracaoAzulada"]'
      'qbatimentosazanariz':'input:radio[name="optionRadiosBatimentosAzaNariz"]'
      'qtiragemintercostal':'input:radio[name="optionRadioTiragemIntercostal"]'
      'dtsintomadia': '#dt-sintoma-dia'
      'dtsintomames': '#dt-sintoma-mes'
      'dtsintomaano': '#dt-sintoma-ano'
      'qcontato':'input:radio[name="optionRadiosContato"]'
      'contato':'.contato'
      'dtcontatodia':'#dt-contato-dia'
      'dtcontatomes':'#dt-contato-mes'
      'dtcontatoano':'#dt-contato-ano'
      'qexameimagem':'input:radio[name="optionRadiosExameImagem"]'
      'qexameimagemcompativel':'input:radio[name="optionRadiosExameImagemCompativel"]'
      'qexamepcr':'input:radio[name="optionRadiosExamePcr"]'
      'pcrdiadia': '#dt-exame-pcr-dia'
      'pcrdiames': '#dt-exame-pcr-mes'
      'pcrdiaano': '#dt-exame-pcr-ano'
      'qexamepcrprazo':'input:radio[name="optionRadiosExamePcrPrazo"]'
      'qexamepcrResultado':'input:radio[name="optionRadiosExamePcrResultado"]'
      'qexameaindapode':'input:radio[name="optionRadiosExameAindaPode"]'
      'qtesteantigeno':'input:radio[name="optionRadiosTesteAntigeno"]'
      'testeantigenodia':'#dt-exame-antigeno-dia'
      'testeantigenomes':'#dt-exame-antigeno-mes'
      'testeantigenoano':'#dt-exame-antigeno-ano'
      'qtesteantigenonoprazo':'input:radio[name="optionRadiosTesteAntigenoNoPrazo"]'
      'qtesteantigenoresultado':'input:radio[name="optionRadiosTesteAntigenoResultado"]'
      'qtesteantigenoaindapode':'input:radio[name="optionRadiosTesteAntigenoAindaPode"]'
      'qpesquisaagenteetinologico':'input:radio[name="optionRadiosPesquisaAgenteEtinologico"]'
      'qpesquisaagenteetinologicoresultado':'input:radio[name="optionRadiosPesquisaAgenteEtinologicoResultado"]'
      'calcula': '#calculaEscore'
      'categoria': '.categoria'
      'dataprimeirosintoma': '.dataprimeirosintoma'
      'blocoexameimagem': '.blocoexameimagem'
      'exameimagem': '.exameimagem'
      'examepcr': '.examepcr'
      'nexamepcr': '.nexamepcr'
      'exameantigeno': '.exameantigeno'
      'nexameantigeno': '.nexameantigeno'
      'algumteste': '.fezalgumteste'
      'agenteetinologico': '.agenteetinologico'
      'isolamento': '.isolamento'
      'quarentena': '.quarentena'
      'dtisolamento': '.dt-isolamento'
      'resultado': '.resultado'
      'realizarPcr': '.realizar-pcr'
      'naoRealizarPcr': '.nao-realizar-pcr'
      'realizarAntigeno': '.realizar-antigeno'
      'naoRealizarAntigeno': '.nao-realizar-antigeno'
      'dtRealizarPcr': '.dt-realizar-pcr'
      'dtRealizarAntigeno': '.dt-realizar-antigeno'
      'processos':'.processos'
      'dtAtualMesg':'#dt-atual-msg'
      'dtPcrMesg':'#dt-pcr-msg'
      'dtContatoMesg':'#dt-contato-msg'
      'dtAntigenoMesg':'#dt-antigeno-msg'
      'dtSintomaMesg':'#dt-sintoma-msg'
      'errorMesg':'#error-msg'
      'paladarolfato': '.paladarolfato'
      'recomendacoes':'#recomendacoes-title'
      'zera':'#zeraEscore'
      'umdia':'.umdia'
      'doisdia':'.doisdia'
      'rou':'.rou'
      'questoes5a8':'.questoes5a8'
      'popover':'[data-toggle="popover"]'

    events:
      'change input':'escondeResultado'
      'click @ui.calcula': 'calculaEscore'
      'click @ui.zera': 'zeraEscore'
      'change @ui.categoria': 'calculaCategoria'
      'change @ui.qexameimagem': 'exibeOcultaResultadoImagem'
      'change @ui.qexamepcr': 'exibeOcultaResultadoPcr'
      'change @ui.qtesteantigeno': 'exibeOcultaResultadoAntigeno'
      'change @ui.qpesquisaagenteetinologico': 'exibeOcultaEtinologicoResultado'
      'change @ui.qcontato': 'exibeOcultaDtUltimoContato'
      'change @ui.qtevesintomas, @ui.tem11anos': 'idadeousintoma'
      'change @ui.dtatualdia, @ui.dtatualmes, @ui.dtatualano, @ui.dtsintomadia, @ui.dtsintomames, @ui.dtsintomaano, @ui.pcrdiadia, @ui.pcrdiames, @ui.pcrdiaano, @ui.dtcontatodia, @ui.dtcontatomes, @ui.dtcontatoano, @ui.testeantigenodia, @ui.testeantigenomes, @ui.testeantigenoano':'getDatas'
      'change @ui.tem11anos, @ui.qtevesintomas, @ui.qtevesintomas,@ui.qgastrointestinais, @ui.qfaltadear, @ui.qpressaoTorax, @ui.qsaturacao, @ui.qcoloracaoazulada, @ui.qbatimentosazanariz, @ui.qtiragemintercostal':'exibeOcultaPaladarOlfato'
      #'change @ui.tem11anos, @ui.q2, @ui.q3, @ui.q4, @ui.q5, @ui.q6, @ui.q7, @ui.q8, @ui.q9': 'changeDados'

    escondeResultado:()->
      @ui.condutaBox.hide()
    
    exibeOcultaPaladarOlfato:()->
      dados = @getDados()
      simorPar45678 = ( dados[2] is '1' or dados[3] is '1' or dados[4] is '1' or dados[5] is '1' or dados[6] is '1' )
      simorPar45678910 = (simorPar45678 or dados[7] is '1' or dados[8] is '1' )
      console.log(@ui.tem11anos.filter(':checked').val() is '1', simorPar45678, simorPar45678910, 'paladarolfato', @ui.qtevesintomas.filter(':checked').val())
      tem11 = if @ui.tem11anos.filter(':checked').val() is '1' then true else false 
      if ( tem11  and (@ui.qtevesintomas.filter(':checked').val() is '1' or simorPar45678)) or (not tem11 and (@ui.qtevesintomas.filter(':checked').val() is '1' or simorPar45678910))
        @ui.paladarolfato.show()
        @ui.blocoexameimagem.show()
      else
        @ui.paladarolfato.hide()
        @ui.blocoexameimagem.hide()
        @ui.qexameimagem.filter('[value="0"]').prop('checked', true)
        @ui.qperdaPaladar.filter('[value="0"]').prop('checked', true)
        @ui.qperdaolfato.filter('[value="0"]').prop('checked', true)

    exibeOcultaDtUltimoContato:()->
      if @ui.qcontato.filter(':checked').val() is '1'
        @ui.contato.show()
      else
        @ui.contato.hide()
        @ui.contato.find("input").val('')
    
    idadeousintoma:()->
      sintomas = @ui.qtevesintomas.filter(':checked').val() is '1'
      if @ui.qgastrointestinais.filter(':checked').val() is '1'
        sintomas = true

      if sintomas
        @ui.questoes5a8.show()
        if @ui.tem11anos.filter(':checked').val() is '0'
          @ui.qdezanos.show()
        else
          @ui.qdezanos.hide()
      else
        @ui.questoes5a8.hide()
        @ui.qdezanos.hide()
      if @ui.tem11anos.filter(':checked').val() is '1'
        @ui.dezanos.hide()
        console.log 'oculta 10'
      else
        console.log 'exibe 10'
        @ui.dezanos.show()

    getDatas:()->
      datas = {
        'dt_atual': @validaData([@ui.dtatualdia.val(), @ui.dtatualmes.val(), @ui.dtatualano.val()], @ui.dtAtualMesg)
        'dt_sintoma': @validaData([@ui.dtsintomadia.val(), @ui.dtsintomames.val(), @ui.dtsintomaano.val()], @ui.dtSintomaMesg)
        'dt_pcr': @validaData([@ui.pcrdiadia.val(), @ui.pcrdiames.val(), @ui.pcrdiaano.val()], @ui.dtPcrMesg)
        'dt_contato': @validaData([@ui.dtcontatodia.val(), @ui.dtcontatomes.val(), @ui.dtcontatoano.val()], @ui.dtContatoMesg)
        'dt_antigeno': @validaData([@ui.testeantigenodia.val(), @ui.testeantigenomes.val(), @ui.testeantigenoano.val()], @ui.dtAntigenoMesg)
      }
      #se a data do 1o sintoma estiver disponível, 
      #a data de realização do teste RT-PCR e do Teste de antígeno deve ser posterior a data do 1o sintoma. 
      if datas.dt_sintoma 
        if datas.dt_pcr and (datas.dt_pcr < datas.dt_sintoma)
          @ui.dtPcrMesg.show().html('A data do teste RT-PCR deve ser porterior ou igual a dos sintomas!')
          @ui.errorMesg.show()
          return
        if datas.dt_antigeno and (datas.dt_antigeno < datas.dt_sintoma)
          @ui.dtAntigenoMesg.show().html('A data do teste Antigeno deve ser porterior ou igual a dos sintomas!')
          @ui.errorMesg.show()
          return
        if datas.dt_atual and (datas.dt_atual < datas.dt_sintoma)
          @ui.dtAntigenoMesg.show().html('A data do 1º sintoma deve ser anterior a data atual!')
          @ui.errorMesg.show()
          return
      #Se a data do último contato com o caso confirmado estiver disponível 
      #a data de realização do teste RT-PCR e do Teste de antígeno deve ser posterior a data do último contato com o caso confirmado
      else if datas.dt_contato
        if datas.dt_pcr and (datas.dt_pcr < datas.dt_contato)
          @ui.dtPcrMesg.show().html('A data do teste RT-PCR deve ser porterior ou igual a do contato!')
          @ui.errorMesg.show()
          return
        if datas.dt_antigeno and (datas.dt_antigeno < datas.dt_contato)
          @ui.dtAntigenoMesg.show().html('A data do teste Antigeno deve ser porterior ou igual a do contato!')
          @ui.errorMesg.show()
          return
        if datas.dt_atual and (datas.dt_atual <= datas.dt_contato)
          @ui.dtAntigenoMesg.show().html('A data do último contato deve ser anterior a data atual!')
          @ui.errorMesg.show()
          return
      datas
    
    validaData:(dt, msg)->
      console.log 'valida esta data', dt
      dt[0] = parseInt(dt[0])
      dt[1] = parseInt(dt[1])
      if not dt[0] and not dt[1] and not dt[2]
        msg.show().html('Esta data é obrigatória')  
        return ''
      maximodia = 31
      if [2,4,6,9,11].indexOf(dt[1]) > -1
        maximodia = 30
      console.log maximodia, 'maximodia', [2,4,6,9,11].indexOf(dt[1]) > -1, dt[1], [2,4,6,9,11].indexOf(dt[1])
      if dt[0] < 1 or dt[0] > maximodia
        msg.show().html('Digite um dia válido!')
        return ''
      if dt[1] < 1 or dt[1] > 12
        msg.show().html('Digite um mês é válido!')
        return ''
      if dt[2].length < 4
        msg.show().html('Digite um ano válido! Ex: 2021')
        return ''
        
        return ''
      if dt[0] < 10
        dt[0] = '0'+dt[0]
      if dt[1] < 10
        dt[1] = '0'+dt[1]
      dt[0] += ''
      dt[1] += ''
      try 
        dtx = Date.parse(dt[2]+'-'+dt[1]+'-'+dt[0]+'T06:00:00Z')
        console.log(dtx,'dtx',dt[2]+'-'+dt[1]+'-'+dt[0])
        dtnow = new Date()
        console.log(dtnow,'dtnow')
        dnow = dtnow.getDate()
        if dnow < 10
          dnow = '0'+dnow
        mnow = dtnow.getMonth()+1
        if mnow < 10
          mnow = '0'+mnow
        dtnow = Date.parse(dtnow.getFullYear()+'-'+mnow+'-'+dnow+'T06:00:00Z')
        console.log(dtnow,'dtnow2')
        
        if dtx > dtnow
          throw "As datas não podem ultrapassar a data atual!"
        msg.hide().html('')
        @ui.errorMesg.hide()
      catch e
        console.log e
        msg.show().html(e)
        
        return ''
      dtx

    getDados:() ->
      # do @ui.qtevesintomas.filter(':checked').val
      # do @ui.qtevesintomas.filter(':checked').val
      d = [
        do @ui.qperdaolfato.filter(':checked').val
        do @ui.qperdaPaladar.filter(':checked').val
        do @ui.qgastrointestinais.filter(':checked').val
        do @ui.qfaltadear.filter(':checked').val
        do @ui.qpressaoTorax.filter(':checked').val
        do @ui.qsaturacao.filter(':checked').val
        do @ui.qcoloracaoazulada.filter(':checked').val
        do @ui.qbatimentosazanariz.filter(':checked').val
        do @ui.qtiragemintercostal.filter(':checked').val
        do @ui.qcontato.filter(':checked').val
        do @ui.qexameimagem.filter(':checked').val
        do @ui.qexameimagemcompativel.filter(':checked').val
        do @ui.qexamepcr.filter(':checked').val
        do @ui.qexamepcrResultado.filter(':checked').val
        do @ui.qtesteantigeno.filter(':checked').val
        do @ui.qtesteantigenoresultado.filter(':checked').val 
        do @ui.qpesquisaagenteetinologico.filter(':checked').val
        do @ui.qpesquisaagenteetinologicoresultado.filter(':checked').val
      ]
      console.log 'dados' , d 
      d

    zeraEscore:() ->
      @ui.qperdaolfato.filter('[value="0"]').prop('checked', true).change()
      @ui.qperdaPaladar.filter('[value="0"]').prop('checked', true).change()
      @ui.qgastrointestinais.filter('[value="0"]').prop('checked', true).change()
      @ui.qfaltadear.filter('[value="0"]').prop('checked', true).change()
      @ui.qpressaoTorax.filter('[value="0"]').prop('checked', true).change()
      @ui.qsaturacao.filter('[value="0"]').prop('checked', true).change()
      @ui.qcoloracaoazulada.filter('[value="0"]').prop('checked', true).change()
      @ui.qbatimentosazanariz.filter('[value="0"]').prop('checked', true).change()
      @ui.qtiragemintercostal.filter('[value="0"]').prop('checked', true).change()
      @ui.qcontato.filter('[value="0"]').prop('checked', true).change()
      @ui.qexameimagem.filter('[value="0"]').prop('checked', true).change()
      @ui.qexameimagemcompativel.filter('[value="0"]').prop('checked', true).change()
      @ui.qexamepcr.filter('[value="0"]').prop('checked', true).change()
      @ui.qexamepcrResultado.filter('[value="0"]').prop('checked', true).change()
      @ui.qtesteantigeno.filter('[value="0"]').prop('checked', true).change()
      @ui.qtesteantigenoresultado.filter('[value="0"]').prop('checked', true).change() 
      @ui.qpesquisaagenteetinologico.filter('[value="0"]').prop('checked', true).change()
      @ui.qpesquisaagenteetinologicoresultado.filter('[value="0"]').prop('checked', true).change()
      @ui.qtevesintomas.filter('[value="0"]').prop('checked', true).change()
      @ui.qtevesintomas.filter('[value="0"]').prop('checked', true).change()
      @ui.dtsintomadia.val('')
      @ui.dtsintomames.val('')
      @ui.dtsintomaano.val('')
      @ui.pcrdiadia.val('')
      @ui.pcrdiames.val('')
      @ui.pcrdiaano.val('')
      @ui.dtcontatodia.val('')
      @ui.dtcontatomes.val('')
      @ui.dtcontatoano.val('')
      @ui.testeantigenodia.val('')
      @ui.testeantigenomes.val('')
      @ui.testeantigenoano.val('')
      @ui.naoRealizarPcr.hide()
      @ui.naoRealizarAntigeno.hide()
      @ui.condutaBox.hide()
      @ui.processos.html('')
      @ui.errorMesg.hide()

    exibeOcultaResultadoImagem: ()->
      if @ui.qexameimagem.filter(':checked').val() is '1'
        @ui.exameimagem.show()
      else
        @ui.exameimagem.hide()
        @ui.exameimagem.find('input:radio').filter('[value="0"]').prop('checked', true)
    
    exibeOcultaResultadoPcr: ()->
      if @ui.qexamepcr.filter(':checked').val() is '1'
        @ui.examepcr.show()
        @ui.nexamepcr.hide()
        @ui.nexamepcr.find('input:radio').filter('[value="0"]').prop('checked', true)
      else
        @ui.examepcr.hide()
        @ui.examepcr.find('input:radio').filter('[value="0"]').prop('checked', true)
        @ui.nexamepcr.show()
        @ui.pcrdiadia.val('')
        @ui.pcrdiames.val('')
        @ui.pcrdiaano.val('')
      do @exibeOcultaEtinologico
    
    exibeOcultaResultadoAntigeno: ()->
      if @ui.qtesteantigeno.filter(':checked').val() is '1'
        @ui.exameantigeno.show()
        @ui.nexameantigeno.hide()
        @ui.nexameantigeno.find('input:radio').filter('[value="0"]').prop('checked', true)
      else
        @ui.exameantigeno.hide()
        @ui.exameantigeno.find('input:radio').filter('[value="0"]').prop('checked', true)
        @ui.nexameantigeno.show()
        @ui.testeantigenodia.val('')
        @ui.testeantigenomes.val('')
        @ui.testeantigenoano.val('')
      do @exibeOcultaEtinologico
    
    exibeOcultaEtinologico: ()->
      if @ui.qtesteantigeno.filter(':checked').val() is '1' or @ui.qexamepcr.filter(':checked').val() is '1'
        @ui.algumteste.show()
      else
        @ui.algumteste.hide()
        @ui.algumteste.find('input:radio').filter('[value="0"]').prop('checked', true)
    
    exibeOcultaEtinologicoResultado: ()->
      if @ui.qpesquisaagenteetinologico.filter(':checked').val() is '1'
        @ui.agenteetinologico.show()
      else
        @ui.agenteetinologico.hide()
    # 1. SG/caso suspeito
    # 2. Caso confirmado 
    # 3. SRAG caso suspeito 
    # 4. Assintomático - Respondeu não para todas as questões 
    calculaCategoria: (dados)->
      dados = @getDados()
      categoria = 0
      naoPara234 = (dados[0] is '0' and dados[1] is '0' and dados[2] is '0')
      naoPara5678 = (dados[3] is '0' and dados[4] is '0' and dados[5] is '0' and dados[6] is '0' )
      naoPara5678910 = (naoPara5678 and dados[7] is '0' and dados[8] is '0' )
      simOuPar5678 = (dados[3] is '1' or dados[4] is '1' or dados[5] is '1' or dados[6] is '1' )
      simOuPar5678910 = (simOuPar5678 or dados[7] is '1' or dados[8] is '1' )
      simOuPara23 = (dados[0] is '1' or dados[1] is '1')
      if @ui.tem11anos.filter(':checked').val() is '1' #11 ou mais
        #sg suspeito  
        teveAlgumSintoma = @ui.qtevesintomas.filter(':checked').val() is '1'
        if ( teveAlgumSintoma or dados[2] is '1') and naoPara5678
          categoria = 1
        #SRAG caso suspeito
        if simOuPar5678 and teveAlgumSintoma
          categoria = 2
        # Assintomático 
        if naoPara5678 and naoPara234 and not teveAlgumSintoma
          categoria = 3
      else #10 ou menos
        teveAlgumSintoma = @ui.qtevesintomas.filter(':checked').val() is '1'
        #sg suspeito  
        if (teveAlgumSintoma or dados[2] is '1') and naoPara5678910
          categoria = 1
        #SRAG caso suspeito 
        if simOuPar5678910 and teveAlgumSintoma
          categoria = 2
        # Assintomático 
        if naoPara5678910 and naoPara234 and not teveAlgumSintoma
          categoria = 3
      console.log naoPara5678910 , naoPara234 , not teveAlgumSintoma, 'categoriza', categoria
      if simOuPar5678 or categoria is 1 or categoria is 2
        @ui.dataprimeirosintoma.show()
      else 
        @ui.dataprimeirosintoma.hide()
        @ui.dtsintomadia.val('')
        @ui.dtsintomames.val('')
        @ui.dtsintomaano.val('')
      categoria
    
    calculaData:(dtx, nr_dias)->
      diasmile = nr_dias * (1000*60*60*24)
      d = new Date(dtx+diasmile)
      console.log 'calculaDta', d, nr_dias, 'teste',dtx, diasmile, dtx+diasmile
      dia = d.getDate()
      if dia < 10
        dia = '0'+ dia
      mes = d.getMonth()+1
      if mes < 10
        mes = '0' + mes
      ano = d.getFullYear()
      dia+'/'+mes+'/'+ano
    
    calculaDiasPassado:(dataAntes, dataAtual)->
      dt_atualx = new Date(dataAtual)
      dt_sintomax = new Date(dataAntes)
      diasx = (dt_atualx.getTime() - dt_sintomax.getTime())/1000/60/60/24
      diasx

    exibeResultado:(nivel, datas)->
      @ui.errorMesg.hide()
      if @ui.dtsintomadia.is(':visible') and not datas.dt_sintoma
        @ui.errorMesg.show()
        window.location.href = '#dt-sintoma-dia'
        return
      if @ui.dtcontatodia.is(':visible') and not datas.dt_contato
        @ui.errorMesg.show()
        window.location.href = '#dt-contato-dia'
        return
      if @ui.pcrdiadia.is(':visible') and not datas.dt_pcr
        @ui.errorMesg.show()
        window.location.href = '#dt-exame-pcr-dia'
        return
      if @ui.testeantigenodia.is(':visible') and not datas.dt_antigeno
        @ui.errorMesg.show()
        window.location.href = '#dt-exame-antigeno-dia'
        return
      conduta = _.find @tabela, (item) ->
          item.nivel == nivel
      console.log 'exibe resultado', nivel, conduta
      if conduta.isolamento and ((not datas.dt_sintoma and nivel < 10)or ((@ui.qexamepcrResultado.filter(':checked').val() is '1' and not datas.dt_pcr) or (@ui.qtesteantigenoresultado.filter(':checked').val() is '1' and not datas.dt_antigeno)))
        return
      window.location.href = '#calculaEscore'

      @ui.condutaBox.show()
      @ui.processos.html('')
      console.log conduta, 'conduta', datas.dt_sintoma
      @ui.resultado.html(conduta.descricao)
      @ui.quarentena.hide()
      if conduta.isolamento
        @ui.isolamento.show()
        antigenoPositivo = @ui.qtesteantigenoresultado.filter(':checked').val() is '1'
        pcrPositivo = @ui.qexamepcrResultado.filter(':checked').val() is '1'
        console.log 'antigeno', antigenoPositivo, 'pcr', pcrPositivo
        if nivel is 1 or (nivel > 9 and nivel < 20) or nivel is 112 or nivel is 111 or nivel is 131
          if antigenoPositivo or pcrPositivo
            if antigenoPositivo
              dt = @calculaData(datas.dt_antigeno, conduta.nr_dias)
            if pcrPositivo
              dt = @calculaData(datas.dt_pcr, conduta.nr_dias)
          else if @ui.qexameimagemcompativel.filter(':checked').val() is '1'
            dt = @calculaData(datas.dt_sintoma, conduta.nr_dias)
          else if nivel is 1
            dt = @calculaData(datas.dt_sintoma, conduta.nr_dias)
          else
            dt = @calculaData(datas.dt_contato, conduta.nr_dias)
        else if nivel is 2 and (antigenoPositivo or pcrPositivo)
          if antigenoPositivo
            dt = @calculaData(datas.dt_antigeno, conduta.nr_dias)
          if pcrPositivo
            dt = @calculaData(datas.dt_pcr, conduta.nr_dias)
        else 
          dt = @calculaData(datas.dt_sintoma, conduta.nr_dias)
        @ui.dtisolamento.html(dt)
        console.log datas, 'setou isolamento',dt
        @ui.doisdia.hide()
        @ui.umdia.show()
        if conduta.nr_dias_pcr
          @ui.realizarPcr.show()
          if nivel is 11 or nivel is 131
            dtInit =  @calculaData(datas.dt_contato, conduta.nr_dias_pcr)
            dtFin = @calculaData(datas.dt_contato, conduta.nr_dias_antigeno)
            dtPcr = dtInit+' ou '+ dtFin
            @ui.doisdia.show()
            @ui.umdia.hide()
          else
            dtPcr = @calculaData(datas.dt_sintoma, conduta.nr_dias_pcr)
          @ui.dtRealizarPcr.html(dtPcr)
          console.log datas, 'setou pcr',dtPcr
        else 
          @ui.realizarPcr.hide()

        if conduta.nr_dias_antigeno
          @ui.realizarAntigeno.show()
          if conduta.nr_dias_pcr
            @ui.rou.show()
          else
            @ui.rou.hide()
          if nivel is 11 or nivel is 131
            dtFin = @calculaData(datas.dt_contato, conduta.nr_dias_antigeno)
            dtInit =  @calculaData(datas.dt_contato, conduta.nr_dias_pcr)
            dtAntigeno = dtInit+' ou '+ dtFin
            @ui.doisdia.show()
            @ui.umdia.hide()
          else if nivel is 111
            dtAntigeno = @calculaData(datas.dt_contato, conduta.nr_dias_antigeno)
          else
            dtAntigeno = @calculaData(datas.dt_sintoma, conduta.nr_dias_antigeno)
          @ui.dtRealizarAntigeno.html(dtAntigeno)
        else
          @ui.realizarAntigeno.hide()
        if nivel is 12
          @ui.isolamento.hide()
          @ui.quarentena.show()
      else
        @ui.isolamento.hide()
      if nivel is 62 or nivel is 52 or nivel is 11 or nivel is 31 or nivel is 32 or nivel is 41 or nivel is 42 or nivel is 43 or nivel is 33 or nivel is 111
        if nivel is 32 or nivel is 31 or nivel is 42 or nivel is 41 or nivel is 11 or nivel is 52 or nivel is 62
          if nivel is 111
            @ui.realizarPcr.hide()
            @ui.naoRealizarPcr.show() 
          else
            @ui.realizarPcr.show()
            @ui.naoRealizarPcr.hide()
          if nivel is 31 or nivel is 41 or nivel is 11 or nivel is 52 or nivel is 62
            if nivel is 52 or nivel is 62
              @ui.realizarAntigeno.hide()
            else
              @ui.realizarAntigeno.show()
            @ui.naoRealizarAntigeno.hide()
          else
            @ui.naoRealizarAntigeno.show()
        else
          @ui.realizarPcr.hide()
          @ui.realizarAntigeno.hide()
          @ui.naoRealizarPcr.show()
          @ui.naoRealizarAntigeno.show()
      else if nivel is 131
        @ui.realizarPcr.show()
        @ui.realizarAntigeno.show()
        @ui.naoRealizarPcr.hide()
        @ui.naoRealizarAntigeno.hide()
      else
        @ui.realizarPcr.hide()
        @ui.realizarAntigeno.hide()
      lista = conduta.processos.map (p)-> "<li class=''>"+p+"</li>"
      @ui.processos.empty()
      if lista.length > 0
        @ui.recomendacoes.show()
        @ui.processos.append lista.join('')
      else
        @ui.recomendacoes.hide()
      classeResultado = ''
      @ui.resultado.removeClass 'alert-success'
      @ui.resultado.removeClass 'alert-warning'
      @ui.resultado.removeClass 'alert-info'
      @ui.resultado.removeClass 'alert-danger'
      if [0,91,92,14,15].indexOf(nivel) > -1
        classeResultado = 'alert-success'
      # if [13,131].indexOf(nivel) > -1
      #   classeResultado = 'alert-warning'
      if [13,131, 11,111,12,31,32,33,41,42,43,5,51,52,53,6,61,62,63,7,8].indexOf(nivel) > -1
        classeResultado = 'alert-info'
      if [1,2,10].indexOf(nivel) > -1
        classeResultado = 'alert-danger'
      @ui.resultado.show().addClass classeResultado
      
      # @calculaData(data, nr_dias)
      # calcular data isolamento (.isolamento, .dtisolamento)
      # calcular data isolamento (.realizar-pcr-antigeno, .dt-realizar-prc, .dt-realizar-antigeno)
    
    calculaEscore: ()->
      $('.alert').hide()
      datas = @getDatas()
      if not datas
        @ui.errorMesg.show()
        return
      @ui.errorMesg.hide()
      dados = @getDados()
      console.log('calcula escore', datas, dados)
      return if not datas.dt_atual
      return if dados[12] is '1' and not datas.dt_pcr
      return if dados[14] is '1' and not datas.dt_antigeno
      return if dados[9] is '1' and not datas.dt_contato
      categoria = @calculaCategoria(dados, datas)
      console.log('datas', datas, dados[9])
      console.log(categoria)
      # SG/caso suspeito
      if categoria is 1 
        console.log 's/g suspeiro' ,[dados[0] is '1',  dados[1] is '1',  dados[9] is '1',  dados[11] is '1',  dados[15] is '1']
        if dados[0] is '1' or dados[1] is '1' or dados[9] is '1' or dados[11] is '1' or dados[13] is '1' or dados[15] is '1'
          #1
          #SG/caso suspeito +
          # Perda de olfato – (sim)] ou
          # Perda de paladar – (sim) ou 
          # Contato próximo – (sim) ou
          # Exame de imagem com resultado compatível com Covid-19 – (sim) ou
          # Teste RT-PCR ou RT Lamp – (detectável) ou
          # Teste de antígeno – (reagente)
          return @exibeResultado(1, datas)
        dias = @calculaDiasPassado(datas.dt_sintoma, datas.dt_atual)
        #
        if dados[9] is '0' #contato proximo não
          # Contato próximo – (não) e
          diasPcr = @calculaDiasPassado(datas.dt_sintoma, datas.dt_pcr)
          diasAntigeno = @calculaDiasPassado(datas.dt_sintoma, datas.dt_antigeno)
          console.log dados[11] is '0' , dados[13] is '0' , dados[15] is '0' , dias <= 8, dias
          if dados[11] is '0'
            # Exame de imagem compatível com Covid-19 – (não) e
            if dados[12] is '0' and dados[14] is '0'
              #3
              if dias < 8
                # 3.1
                # SG/caso suspeito 
                # + 
                # Contato próximo – (não) e
                # Exame de imagem compatível com Covid-19 – (não) e
                # Realizou Teste RT-PCR / RT Lamp – (não) e
                # Realizou Teste de antígeno – (não) e
                # Passaram 8 dias ou menos do início dos sintoma (ainda tem prazo para realizar o Teste RT-PCR / RT Lamp ou Teste de antígeno).
                return @exibeResultado(31, datas)
              if dias is 8
                # 3.2
                return @exibeResultado(32, datas)
              if dias >= 9
                #3.3
                return @exibeResultado(33, datas)
            #5 e 51
            if dados[12] is '1' and dados[13] is '0' and diasPcr <= 8 and dados[17] is '0'
              if dados[14] is '1' and dados[15] is '0' and diasAntigeno <= 7 
                return @exibeResultado(5, datas)
              if dados[14] is '0'
                return @exibeResultado(51, datas)
            #52
            console.log dados[12] ,  dados[14] , diasAntigeno, dados[15] ,'52'
            if dados[12] is '0' and dados[14] is '1' and diasAntigeno <= 7 and dados[15] is '0'
              return @exibeResultado(52, datas)
            if(dados[13] is '0' and dados[15] is '0') and dados[17] is '0'
              # 7
              #Exame de imagem compatível com Covid-19 – (não) e
              # {
              # [Realizou Teste RT-PCR / RT Lamp – (sim) e Depois do 8º dia a partir do início dos sintomas - (fora do prazo)] ou 
              # [Realizou Teste de antígeno depois do 7º dia a partir do início dos sintomas – (fora do prazo)]
              # } e
              # Nenhum* dos testes realizados teve resultado – (detectável/reagente) e
              # [Fez pesquisa para a identificação de outro agente etiológico – (não) ou Identificou outro agente etiológico – (não)]
              # 7 um dos dois fora do prazo
              if (( dados[12] is '1' and diasPcr > 8)or(dados[14] is '1' and diasAntigeno <= 7))
                return @exibeResultado(52,datas)
              if (( dados[12] is '1' and diasPcr <= 8)or(dados[14] is '1' and diasAntigeno > 7)) 
                return @exibeResultado(51,datas)
              #7 ambos fora do prazo
              if (( dados[12] is '1' and diasPcr > 8)or(dados[14] is '1' and diasAntigeno > 7)) 
                return @exibeResultado(7, datas)
            #9.1
            if (( dados[12] is '1' ) or (dados[14] is '1' )) and dados[16] is '1' and dados[17] is '1'
              return @exibeResultado(91, datas)
      # SRAG caso suspeito +
      if categoria is 2
        if dados[0] is '1' or dados[1] is '1' or dados[9] is '1' or dados[11] is '1' or dados[13] is '1' or dados[15] is '1'
          #2
          # Perda de olfato – (sim)] ou
          # Perda de paladar – (sim) ou 
          # Contato próximo – (sim) ou
          # Exame de imagem com resultado compatível com Covid-19 – (sim) ou
          # Teste RT-PCR ou RT Lamp – (detectável) ou
          # Teste de antígeno – (reagente)
          return @exibeResultado(2, datas)
        if dados[9] is '0' and dados[11] is '0'
          # Contato próximo – (não) e
          # Exame de imagem compatível com Covid-19 – (não) e
          dias = @calculaDiasPassado(datas.dt_sintoma, datas.dt_atual)
          if dados[12] is '0' and dados[14] is '0' 
            console.log 'dias logica 4', dias
            #4
            # Contato próximo – (não) e
            # Exame de imagem compatível com Covid-19 – (não) e
            # Realizou Teste RT-PCR / RT Lamp – (não) e
            # Realizou Teste de antígeno – (não) 
            if dias < 8
              # 4.1
              # ate setimº dia pode antigeno
              return @exibeResultado(41, datas)
            if dias >= 8 and dias <= 14
              #4.2
              # Passaram 14 dias ou menos do início dos sintoma (ainda tem prazo para realizar o Teste RT-PCR / RT Lamp ou Teste de antígeno).
              return @exibeResultado(42, datas)
            if dias > 14
              # 4.3
              # mais de 14 dias de sintomas
              return @exibeResultado(43, datas)
          console.log('passei no 6')
          if dados[17] is '0'
            #6
            # Contato próximo – (não) e
            # Exame de imagem compatível com Covid-19 – (não) e
            # Realizou Teste RT-PCR / RT Lamp – (sim) e 
            # # até o 14º dia a partir do início dos sintomas – (no prazo) 
            # # ou Realizou Teste de antígeno – (sim) e até dia o 7º dia a partir do início dos sintomas – (no prazo) e
            # Nenhum dos testes realizados teve resultado – (detectável/reagente) e
            # Fez pesquisa para a identificação de outro agente etiológico – (não) ou Identificou outro agente etiológico - não
            diasPcr = @calculaDiasPassado(datas.dt_sintoma, datas.dt_pcr)
            diasAntigeno = @calculaDiasPassado(datas.dt_sintoma, datas.dt_antigeno)
            if ((dados[12] is '1' and diasPcr <= 14) and (dados[14] is '1' and diasAntigeno <= 7)) and  (dados[13] is '0' and dados[15] is '0') 
              return @exibeResultado(6, datas)
            #6.1
            if ((dados[12] is '1' and diasPcr <= 14 and dados[13] is '0') and dados[14] is '0')
              return @exibeResultado(61, datas)
            #6.2
            if ((dados[12] is '0') and (dados[14] is '1' and dados[15] is '0' and diasAntigeno <=7)) 
              return @exibeResultado(62, datas)
            #8
            # Contato próximo – (não) e
            # Exame de imagem compatível com Covid-19 – (não) e
            # Realizou Teste RT-PCR / RT Lamp – (sim) e 
            # # Depois do 8º dia a partir do início dos sintomas - (fora do prazo) 
            # # ou Realizou Teste de antígeno depois do 7º dia a partir do início dos sintomas – (fora do prazo) 
            # e
            # Nenhum dos testes realizados teve resultado – (detectável/reagente) e
            # Fez pesquisa para a identificação de outro agente etiológico – (não) ou Identificou outro agente etiológico – (não)
            console.log 'teste 8', (dados[12] is '1' and diasPcr > 8)  , (dados[14] is '1' and diasAntigeno > 7) ,  (dados[13] is '0' and dados[15] is '0') , (dados[17] is '0' )
            if (dados[13] is '0' and dados[15] is '0')
              # pcr fora
              if ((dados[12] is '1' and diasPcr <= 14)  or (dados[14] is '1' and diasAntigeno > 7)) 
                return @exibeResultado(61, datas)
              # antigeno fora
              if ((dados[12] is '1' and diasPcr > 14)  or (dados[14] is '1' and diasAntigeno <= 7)) 
                return @exibeResultado(62, datas)
              # ambos fora do prazo
              if ((dados[12] is '1' and diasPcr > 14)  or (dados[14] is '1' and diasAntigeno > 7)) 
                return @exibeResultado(8, datas)
          #9.2
          if (( dados[12] is '1' ) or (dados[14] is '1' )) and dados[16] is '1' and dados[17] is '1'
            return @exibeResultado(92, datas)
      #assintomatico +
      if categoria is 3
        #10 Teste RT-PCR / RT Lamp – detectável ou Teste de Antígeno - reagente
        console.log dados[13], dados[15], 'teste 10'
        if dados[13] is '1' or dados[15] is '1'
          return @exibeResultado(10, datas)
        if dados[9] is '1' 
          diasContato = @calculaDiasPassado(datas.dt_contato, datas.dt_atual)
          console.log dados[12] is '0' , ( dados[14] is '0' and diasContato <= 5), diasContato, 'quase 11'
          return if not diasContato
          if dados[12] is '0' and ( dados[14] is '0' and (diasContato <= 6))
            #11 Contato próximo – (sim) e
            # Realizou Teste RT-PCR / RT Lamp – (não) e
            # [
            # Realizou Teste de antígeno – (não) e
            # Passaram 5 dias ou menos da data do último contato com o caso confirmado (ainda tem prazo para realizar o Teste RT-PCR / RT Lamp ou Teste de antígeno)
            #]
            return @exibeResultado(11, datas)
          if dados[12] is '0' and ( dados[14] is '0' and (diasContato > 6))
            return @exibeResultado(111, datas)
          # 12, 13
          # Contato próximo – (sim) e
          # Nenhum* dos testes realizados teve resultado – (detectável/reagente) e
          # [
          #    Fez pesquisa para a identificação de outro agente etiológico – (não) ou 
          #    Identificou outro agente etiológico – (não)
          # ]
          diasPcrContato = @calculaDiasPassado(datas.dt_contato, datas.dt_pcr)
          diasAntigenoContato = @calculaDiasPassado(datas.dt_contato, datas.dt_antigeno)
          examePcrNoPrazo = [5,6].indexOf(diasPcrContato) > -1
          exameAntigenoNoPrazo = [5,6].indexOf(diasAntigenoContato) > -1
          if (dados[13] is '0' and dados[15] is '0') and dados[17] is '0'
            if (dados[12] is '1' and examePcrNoPrazo) or(dados[14] is '1' and exameAntigenoNoPrazo) 
              # 12
              # {
              #  [
              #    Realizou Teste RT-PCR / RT Lamp  – (sim) e 
              #    No 5º ou 6º dia do último contato com o caso suspeito ou  confirmado – (no prazo)
              #  ] ou 
              #  [
              #     Realizou Teste de antígeno – (sim) e 
              #    No 5º ou 6º dia do último contato com o caso suspeito ou confirmado – (no prazo)
              #  ]
              # } e 
              return @exibeResultado(12, datas)
            # 13 pcr no pra antigeno fora 
            if ( dados[12] is '1' and examePcrNoPrazo) or (dados[14] is '1' and not exameAntigenoNoPrazo) 
              @exibeResultado(12,datas)
            # 13 pcr fora antigeno dentro
            if ( dados[12] is '1' and not examePcrNoPrazo) or (dados[14] is '1' and exameAntigenoNoPrazo) 
              @exibeResultado(12,datas)
            # ambos fora
            if ( dados[12] is '1' and not examePcrNoPrazo) or (dados[14] is '1' and not exameAntigenoNoPrazo) 
              # 13
              # {
              #   [
              #     Realizou Teste RT-PCR / RT Lamp  – (sim) 
              #     e Fora do 5º ou 6º dia do último contato com o caso suspeito ou confirmado – (fora do prazo)
              #   ] ou 
              #   [
              #     Realizou Teste de antígeno – (sim) e 
              #     Fora dos dias 5º ou 6º dia do último contato com o caso suspeito ou confirmado – (fora do prazo)
              #    ]
              # }
              console.log diasPcrContato, diasAntigenoContato, 'dias contato'
              if (diasPcrContato > 6 and dados[12] is '1') or (diasAntigenoContato > 6 and dados[14] is '1')
                return @exibeResultado(13, datas)
              else if (diasPcrContato < 5 and dados[12] is '1') or (diasAntigenoContato < 5 and dados[14] is '1')
                return @exibeResultado(131, datas)
        else
          if dados[9] is '0' 
            if dados[12] is '1' and dados[13] is '0'
              # Contato próximo – (não) e
              # Exame de imagem compatível com Covid-19 – (não) e
              # Realizou Teste RT-PCR / RT Lamp – (não) e
              # Realizou Teste de antígeno – (não) 
              return @exibeResultado(14, datas)
            if dados[12] is '0' and dados[13] is '0' and dados[14] is '0' and dados[15] is '0'
              # Contato próximo – (não) e
              # Exame de imagem compatível com Covid-19 – (não) e
              # [
              # Realizou Teste RT-PCR / RT Lamp – (sim) e RT-PCR/RT Lamp Não detectável ou 
              # Realizou Teste de antígeno – (não) e Teste de antígeno não reagente]
              return @exibeResultado(15, datas)
          saudavel = dados.filter (i)-> i == '1'
          if saudavel.length is 0
            return @exibeResultado(0, datas)
      return @exibeResultado(0,datas)
 
    tabela:[
      nivel:0
      descricao:"Não é caso suspeito ou confirmado de Covid-19"
      isolamento: false
      processos:[]
    ,
      nivel:1
      descricao:"Caso confirmado"
      isolamento: true # calcular (por 10 dias a partir do início dos sintomas)
      nr_dias: 10
      processos:[
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Indivíduos gravemente imunossuprimidos: Realizar isolamento por 20 dias a partir da data do início dos sintomas. A critério médico, pode ser requerido, nesta população, a apresentação de  RT-PCR não detectável para a descontinuidade do isolamento."
        "Monitorar Caso Confirmado preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia. "
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel:2
      descricao:"SRAG Caso Confirmado"
      isolamento: true # (por 20 dias a partir do início dos sintomas)
      nr_dias: 20
      processos:[
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Indivíduos gravemente imunossuprimidos: Realizar isolamento por 20 dias a partir da data do início dos sintomas. A critério médico, pode ser requerido, nesta população, a apresentação de  RT-PCR não detectável para a descontinuidade do isolamento."
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel:31
      descricao:"SG Não Especificada, sem teste"
      isolamento:true
      nr_dias: 10
      nr_dias_pcr: 8 # (por 8 dias a partir do início dos sintomas)
      nr_dias_antigeno: 7 # (por 10 dias a partir do início dos sintomas)
      processos:[
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Indivíduos gravemente imunossuprimidos: Realizar isolamento por 20 dias a partir da data do início dos sintomas. A critério médico, pode ser requerido, nesta população, a apresentação de  RT-PCR não detectável para a descontinuidade do isolamento."
        "Monitorar Caso Suspeito preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia. "
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel:32
      descricao:"SG Não Especificada, sem teste"
      isolamento:true
      nr_dias: 10
      nr_dias_pcr: 8 # (por 8 dias a partir do início dos sintomas)
      processos:[
        "A realização do teste de antígeno fora do prazo preconizado (a partir do 8º dia do início dos sintomas) aumenta a probabilidade de resultados falso negativos. "
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Indivíduos gravemente imunossuprimidos: Realizar isolamento por 20 dias a partir da data do início dos sintomas. A critério médico, pode ser requerido, nesta população, a apresentação de  RT-PCR não detectável para a descontinuidade do isolamento."
        "Monitorar Caso Suspeito preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia. "
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel:33
      descricao:"SG Não Especificada, sem teste"
      isolamento:true
      nr_dias: 10
      processos:[
        "A realização do teste RT-PCR fora do prazo preconizado (a partir do 9º dia do início dos sintomas) aumenta a probabilidade de resultados falso negativos."
        "A realização do teste de antígeno fora do prazo preconizado (a partir do 8º dia do início dos sintomas) aumenta a probabilidade de resultados falso negativos."
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Indivíduos gravemente imunossuprimidos: Realizar isolamento por 20 dias a partir da data do início dos sintomas. A critério médico, pode ser requerido, nesta população, a apresentação de  RT-PCR não detectável para a descontinuidade do isolamento."
        "Monitorar Caso Suspeito preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia. "
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel: 41
      descricao:"SRAG não Especificada, sem teste"
      isolamento:true
      nr_dias: 20
      nr_dias_pcr: 14 # (por 8 dias a partir do início dos sintomas)
      nr_dias_antigeno: 7 # (por 10 dias a partir do início dos sintomas)
      processos:[
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Indivíduos gravemente imunossuprimidos: Realizar isolamento por 20 dias a partir da data do início dos sintomas. A critério médico, pode ser requerido, nesta população, a apresentação de  RT-PCR não detectável para a descontinuidade do isolamento."
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel: 42
      descricao:"SRAG não Especificada, sem teste"
      isolamento:true
      nr_dias: 20
      nr_dias_pcr: 14 # (por 8 dias a partir do início dos sintomas)
      processos:[
        "A realização do teste de antígeno fora do prazo preconizado (a partir do 9º dia do início dos sintomas) aumenta a probabilidade de resultados falso negativos. "
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Indivíduos gravemente imunossuprimidos: Realizar isolamento por 20 dias a partir da data do início dos sintomas. A critério médico, pode ser requerido, nesta população, a apresentação de  RT-PCR não detectável para a descontinuidade do isolamento."
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel: 43
      descricao:"SRAG não Especificada, sem teste"
      isolamento:true
      nr_dias: 20
      nr_dias_pcr: 14 # (por 8 dias a partir do início dos sintomas)
      nr_dias_antigeno: 7 # (por 10 dias a partir do início dos sintomas)
      processos:[
        " A realização do teste RT-PCR fora do prazo preconizado (a partir do 15º dia do início dos sintomas) aumenta a probabilidade de resultados falso negativos."
        "A realização do teste de antígeno fora do prazo preconizado (a partir do 8º dia do início dos sintomas) aumenta a probabilidade de resultados falso negativos. "
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Indivíduos gravemente imunossuprimidos: Realizar isolamento por 20 dias a partir da data do início dos sintomas. A critério médico, pode ser requerido, nesta população, a apresentação de  RT-PCR não detectável para a descontinuidade do isolamento."
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel: 5
      descricao:"SG não especificada, testes não reagente/não detectável no prazo"
      isolamento: false 
      processos:[
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Monitorar Caso Suspeito preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia."
      ]
    ,
      nivel: 51
      descricao:"SG não especificada, testes não reagente/não detectável no prazo"
      isolamento: false 
      processos:[
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Monitorar Caso Suspeito preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia."
      ]
    ,
      nivel: 52
      nr_dias: 10
      nr_dias_pcr: 8
      descricao:"SG não especificada, testes não reagente/não detectável no prazo"
      isolamento: true 
      processos:[
        "O teste de antígeno é menos sensível que o RT-PCR, assim se for necessário suspender o isolamento é recomendado confirmar o resultado através do teste RT-PCR / RT-Lamp."
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Indivíduos gravemente imunossuprimidos: Realizar isolamento por 20 dias a partir da data do início dos sintomas. A critério médico, pode ser requerido, nesta população, a apresentação de  RT-PCR não detectável para a descontinuidade do isolamento."
        "Monitorar Caso Suspeito preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia."
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel: 6
      descricao:"SRAG não especificada, testes não reagente/não detectável no prazo"
      isolamento: false
      processos:[
        "Caso um primeiro teste de RT-PCR tenha resultado negativo, um segundo teste RT-PCR, preferencialmente com material de via aérea baixa, deve ser realizado 48 horas após o primeiro. Sendo os dois negativos, o paciente poderá ser retirado da precaução para Covid-19. "
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
      ]
    ,
      nivel: 61
      descricao:"SRAG não especificada, teste RT-PCR / RT Lamp não detectável no prazo"
      isolamento: false
      processos:[
        "Caso um primeiro teste de RT-PCR tenha resultado negativo, um segundo teste RT-PCR, preferencialmente com material de via aérea baixa, deve ser realizado 48 horas após o primeiro. Sendo os dois negativos, o paciente poderá ser retirado da precaução para Covid-19. "
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
      ]
    ,
      nivel: 62
      descricao:"SRAG não especificada, Teste de Antígeno não detectável no prazo"
      isolamento: true
      nr_dias: 20
      nr_dias_pcr: 14
      processos:[
        "O teste de antígeno é menos sensível que o RT-PCR, assim se for necessário suspender o isolamento é recomendado confirmar o resultado através do teste RT-PCR / RT-Lamp."
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Indivíduos gravemente imunossuprimidos: Realizar isolamento por 20 dias a partir da data do início dos sintomas. A critério médico, pode ser requerido, nesta população, a apresentação de  RT-PCR não detectável para a descontinuidade do isolamento."
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel: 7
      descricao:"SRAG não especificada, teste não reagente/não detectável fora do prazo"
      isolamento: true #(por 10 dias a partir do início dos sintomas)
      nr_dias: 10
      processos:[
        "Teste realizado fora do período recomendado, assim o resultado tem maior probabilidade de ser falso negativo."
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Indivíduos gravemente imunossuprimidos: Realizar isolamento por 20 dias a partir da data do início dos sintomas. A critério médico, pode ser requerido, nesta população, a apresentação de  RT-PCR não detectável para a descontinuidade do isolamento."
        "Monitorar caso suspeito preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia."
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel: 8
      descricao:"SRAG não especificada, teste não reagente/não detectável fora do prazo"
      isolamento: true #(por 10 dias a partir do início dos sintomas)
      nr_dias: 20
      processos:[
        "Teste realizado fora do período recomendado, assim o resultado tem maior probabilidade de ser falso negativo."
        "Suspensão do isolamento é condicionada a estar há 24 horas sem febre sem uso de antitérmicos e ter remissão dos sintomas respiratórios."
        "Indivíduos gravemente imunossuprimidos: Realizar isolamento por 20 dias a partir da data do início dos sintomas. A critério médico, pode ser requerido, nesta população, a apresentação de  RT-PCR não detectável para a descontinuidade do isolamento."
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel: 91
      descricao:"SG descartada"
      isolamento: false 
      processos:[
        "Suspender o isolamento e o monitoramento 24 horas após estar sem febre sem uso de antitérmicos e ter remissão dos sintomas."
      ]
    ,
      nivel: 92
      descricao:"SRAG descartada"
      isolamento: false 
      processos:[
        "Suspender o isolamento e o monitoramento 24 horas após estar sem febre sem uso de antitérmicos e ter remissão dos sintomas."
      ]
    ,
      nivel: 10
      descricao:"Caso Confirmado"
      isolamento: true #(por 10 dias a partir da data da coleta da amostra para a realização do teste). (Se tiver feito RT-PCR / RT Lamp detectável e Teste de Antígeno reagente, utilizar a data do RT-PCR / RT Lamp).
      nr_dias: 10
      processos:[
        "Monitorar caso confirmado preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia. "
        "Identificar, Rastrear, Monitorar e Isolar contatos próximos."
      ]
    ,
      nivel: 11
      descricao:"Contato Próximo de caso confirmado"
      isolamento: true #(por 10 dias a partir da data do último contato com o caso confirmado).
      nr_dias: 10
      nr_dias_pcr: 5
      nr_dias_antigeno: 6
      processos:[
        "Monitorar preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia."
      ]
    ,
      nivel: 111
      descricao:"Contato Próximo de caso confirmado"
      isolamento: true #(por 10 dias a partir da data do último contato com o caso confirmado).
      nr_dias: 10
      processos:[
        "Monitorar preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia."
      ]
    ,
      nivel: 12
      descricao:"Contato Próximo de caso confirmado"
      isolamento: true #Contato Próximo de caso confirmado
      nr_dias: 14
      processos:[
          "Monitorar preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia. "
      ]
    ,
      nivel: 13
      descricao:"Contato Próximo de caso confirmado"
      isolamento: true #(por 10 dias a partir da data do último contato com o caso confirmado).
      nr_dias: 10
      processos:[
          "Teste realizado fora do período recomendado."
          "Não há mais prazo para realizar Teste RT-PCR ou Teste de Antígeno."
          "Monitorar preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia. "
      ]
    ,
      nivel: 131
      descricao:"Contato Próximo de caso confirmado"
      isolamento: true #(por 10 dias a partir da data do último contato com o caso confirmado).
      nr_dias: 10
      nr_dias_pcr: 5
      nr_dias_antigeno: 6
      processos:[
          "Teste realizado fora do período recomendado."
          "Monitorar preferencialmente a partir das primeiras 48 horas após a notificação do caso, no mínimo a cada 2 dias, por 14 dias e obrigatoriamente no 14º dia. "
      ]
    ,
      nivel: 14
      descricao:"Não é caso suspeito ou confirmado de Covid-19"
      isolamento: false 
      processos:[]
    ,
      nivel: 15
      descricao:"Não é caso suspeito ou confirmado de Covid-19"
      isolamento: false 
      processos:[]
    ]

    onRender: (view) ->
      console.log 'view'
      console.log 'view'
      atual = new Date()
      dia = atual.getDate()
      dia = if dia < 10 then '0'+dia else dia
      @ui.dtatualdia.val(dia)

      mes = atual.getMonth()+1
      mes = if mes < 10 then '0'+mes else mes
      @ui.dtatualmes.val(mes)

      @ui.dtatualano.val(atual.getFullYear())
      @ui.popover.popover({'html':true})
      #do @ui.item.hide
      #do @$el.find('.item.active').show
      #@ui.prev.attr('disabled','disabled')
      #@$el.find('.p1').addClass('active')
      #do @changeDados


  calCovidMainView
