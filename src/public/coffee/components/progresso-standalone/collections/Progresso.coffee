define [
  '../models/Resposta'
  '../models/Badge'
  '../collections/Badges'
], (RespostaModel, BadgeModel, BadgesColl)->


  class ProgressoManager extends Backbone.Collection
    'model': RespostaModel
    'url': ''

    'create': (resposta)->
      console.log  resposta
      res = @add resposta
      console.log @
      # console.log """

      #     ###################
      #     CREATE
      #     ###################

      # """, res
      # @geral = do @calculaProgressoGeral
      # return unless App.user
      # @badgesConcedidos = new BadgesColl unless @badgesConcedidos
      # @badgesConcedidos.reset @temNovosBadges().models
      do @saveLocal
      # @saveServer res

    saveLocal: ->
      return unless App.local
      {local} = App
      console.log @
      if @length > 0
        local.set "respostas-standalone", @toJSON()
      else
        throw new Error

    # saveServer: (res)->
    #   return unless App.socket
    #   App.socket.emit "respondeu", res.toJSON(), (data) ->
    #     console.log data

    'initialize': (options)->
      # @badgesConcedidos = new BadgesColl
      # @badges = new BadgesColl App.badges.toJSON()
      @bind 'add', @onModelAdded, @
      @bind 'remove', @onModelRemoved, @
      @bind 'change reset', @onChange, @
      # @bind 'reset', @onReset, @
      @atividades = do @getAllAtividades
      @casos = do @getAllCasos
      @testes = do @getAllTestes
      null

    'onChange': () ->
      key = "respostas-standalone"
      console.log 'change'
      App.local.set(key, @toJSON()) if App.local
        # throw new Error
      # @badgesConcedidos = @temNovosBadges()

    # 'onReset': () ->
    #   # throw new Error
    #   console.log  "@calculaProgressoGeral reset", arguments
    #   @geral = do @calculaProgressoGeral
    #   @badgesConcedidos = @temNovosBadges(yes)

    # 'setUser': (user)->
    #   @user = new Backbone.Model user
    #   @badgesConcedidos = new BadgesColl @temNovosBadges(yes).models
    #   @atividades = do @getAllAtividades
    #   @casos = do @getAllCasos
    #   @testes = do @getAllTestes

    'getByAtividadeId': (id) -> _.sortBy @where(atividade: id), 'seqid'

    'onModelAdded': (model, collection, options) ->
      if @user
        model.set 'user', @user.get 'cpf'
      model.set 'modulo', window.modulo._id
      if model.seqid is 0
        @remove @filter((res)-> res.modulo is model.modulo)

    'onModelRemoved': (model, collection, options) ->
      # console.log  "@calculaProgressoGeral onModelRemoved"
      # if App.socket and App.socket.connected
      #   App.socket.emit("reiniciou", model.toJSON())
      # @geral = do @calculaProgressoGeral
      # @badgesConcedidos.reset @temNovosBadges(yes).models

    conta: 0
    resolveCasosBloqueados:->
      # console.log App.atividades.models.length, App.progresso.length, 'antes'
      # casosBloqueados = App.atividades.models.filter (a)->
      #   return a.get('bloqueado') == true
      # console.log casosBloqueados, 'casosBloqueados'

      # progressoBloqueado = []
      # for c in casosBloqueados
      #   cblo = c.get('_id')
      #   progressosAtiv = App.progresso.models.filter (m)-> 
      #     return m.get('atividade') == cblo
      #   progressoBloqueado = progressoBloqueado.concat progressosAtiv

      # console.log progressoBloqueado, 'progressoBloqueado'
      # App.progresso.remove(progressoBloqueado)

      # if casosBloqueados.length > 0
      #   App.atividades.remove(casosBloqueados)
      #   App.progresso.atividades = App.atividades.toJSON()

    calculaProgressoGeral: (callback) ->
      @resolveCasosBloqueados()
      # console.log "CalculaProgresso #{@conta++}"
      #@models  is  respostas
      return false unless @models
      #console.log @models,@models, 'modelos', App.atividades, @atividades
      posTeste = preTeste = false
      percTestesTotal = percCasosRespTotal = percTestesRespTotal = percAtivQuestTotal = percAcertoPosTeste = percAcertoPreTeste = 0.0
      numCasosIniciados = numTestes = numAtiv = numQuestoesCasoRespondidas = numQuestoesTesteRespondidas = numTestesConcluidos = 0.0
      numQuestoesCaso = numQuestoes = numQuestoesTeste = numAtivConcluido = numCasos = numTestesIniciados = percCasosTotal = 0.0
      numTestesConcluidosNucleo = numCasosConcluidos = percGeralAcertoCasos = percGeralAcertoTestes = percAtivTotal = 0.0

      respostasPorAtividade = _.groupBy @models, (item)-> item.get('atividade')
      # console.log @models
      # console.log respostasPorAtividade, 'respostasPorAtividade'
      #cicla groupby - para  cada atividade

      for _id, respostasDaAtividade of respostasPorAtividade
        #pega a atividade global pelo id
        atividade = _.findWhere @atividades, { _id }
        # console.log 'respostasDaAtividade', respostasDaAtividade
        #pega as questoes da atividade
        questoesDaAtividade = atividade.slides.filter (slide)-> /quest/img.test slide.tipo

        escore = 0.0
        for respAtiv, key in respostasDaAtividade
          escore += respAtiv.get('escore')
        escore = escore / respostasDaAtividade.length

        ativConcluida = questoesDaAtividade.length is respostasDaAtividade.length
        ativEhDoNucleo = @ehDoNucleo(atividade)
        #pega o numero de questoes caso/test - +length em questoes total e +1 no numCasos/numTest
        # console.log atividade
        # console.log atividade.tipo
        switch atividade.tipo

          when 'caso'
            numCasosIniciados++
            if ativConcluida and ativEhDoNucleo
              numQuestoesCasoRespondidas += respostasDaAtividade.length
              percGeralAcertoCasos += escore
              numCasosConcluidos++

          when 'teste'
            numTestesIniciados++
            #console.log ativConcluida, ativEhDoNucleo, atividade ,'é teste porq nao entra no if'
            if ativConcluida and ativEhDoNucleo
              numTestesConcluidosNucleo++
              numQuestoesTesteRespondidas += respostasDaAtividade.length
              percAcertoTestesNucleo += escore
              percGeralAcertoTestes += escore
              numTestesConcluidos++
              if atividade.posTeste
                percAcertoPosTeste = escore
                posTeste = true
              else
                percAcertoPreTeste = escore
                preTeste = true
        #se concluida +1 em concluida
        numAtivConcluido++ if ativConcluida
      # fim do for respostasPorAtividade
      numAtiv = (do @getAllAtividades).length
      numCasos = (do @getAllCasos).length
      numTestes = (do @getAllTestes).length
      numQuestoesTeste = (do @getQuestAllTestes).length
      numQuestoesCaso = (do @getQuestAllCasos).length
      numQuestoes = numQuestoesCaso + numQuestoesTeste
      numAtivConcluidos = numTestesConcluidos + numCasosConcluidos
      percCasosConcluTotal = @calcPercentagem numCasosConcluidos, numCasos
      percCasosRespTotal = @calcPercentagem numQuestoesCasoRespondidas, numQuestoesCaso
      percTestesConcluTotal = @calcPercentagem numTestesConcluidos, numTestes
      percTestesRespTotal = @calcPercentagem numQuestoesTesteRespondidas, numQuestoesTeste
      percAtivConcluTotal = @calcPercentagem numAtivConcluidos, numAtiv
      percAtivQuestRespTotal = @calcPercentagem numQuestoesTesteRespondidas + numQuestoesCasoRespondidas, numQuestoesTeste + numQuestoesCaso
      percGeralAcertoTestes = (percGeralAcertoTestes / numTestesConcluidos) if numTestesConcluidos > 0
      percAcertoTestesNucleo = (percAcertoTestesNucleo / numTestesConcluidosNucleo) if numTestesConcluidosNucleo > 0
      percGeralAcertoCasos = (percGeralAcertoCasos / numCasosConcluidos) if numCasosConcluidos > 0
      porAtividade = do @getProgressoPorAtividades

      geral = {
        percCasosRespTotal, percCasosConcluTotal, percTestesConcluTotal, percTestesRespTotal
        percAcertoPosTeste, percAcertoPreTeste, percAtivConcluTotal, percAtivQuestRespTotal
        numQuestoesTeste, numAtivConcluido, numCasos, numTestes, posTeste, preTeste
        numQuestoesCaso, numTestesIniciados, numCasosIniciados, numTestesConcluidos
        numQuestoesCasoRespondidas, numQuestoesCaso, numQuestoesTesteRespondidas
        numTestesConcluidosNucleo, numAtiv, numCasosConcluidos, numQuestoes
        percGeralAcertoTestes, percGeralAcertoCasos, porAtividade
      }

      @geral = geral
      callback() if callback
      geral

    calcPercentagem:(vparcial, vtotal)->
      return 0.0 if vparcial is 0
      perc = (parseFloat(100*vparcial)/vtotal)

    getAllAtividades:()->
      do App.atividades.toJSON

    getAllCasos:()->
      self = @
      try
        nuc = self.user.get('profissional')
      catch
        nuc = 0

      App.casos.toJSON().filter (atividade)->
        if atividade.pro[0] and (nuc is '2' or nuc is 2)
          return true
        if atividade.pro[1] and (nuc is '1' or nuc is 1)
          return true
        if nuc is '0' or nuc is 0 or nuc is '-1' or nuc is -1
          return true
        false

    ehDoNucleo : (atividade)->
      self = @
      nuc = self.user.get('profissional')
      if atividade.pro[0] and (nuc is '2' or nuc is 2)
        return true
      if atividade.pro[1] and (nuc is '1' or nuc is 1)
        return true
      if nuc is '0' or nuc is 0 or nuc is '-1' or nuc is -1
        return true
      false

    getQuestAllCasos:()->
      casos = do @getAllCasos
      questsCasos= []
      for val,key in casos
        questUmcaso= val.slides.filter (slide)->
          return /quest/img.test(slide.tipo)
        questsCasos=questsCasos.concat questUmcaso
      questsCasos

    getAllTestes:()->
      self = @
      try
        nuc = self.user.get('profissional')
      catch
        nuc = 0
      App.testes.toJSON().filter (atividade)->
        # console.log 'atividade.pro', atividade.pro
        if atividade.pro[0] and (nuc is '2' or nuc is 2)
          return true
        if atividade.pro[1] and (nuc is '1' or nuc is 1)
          return true
        if nuc is '0' or nuc is 0 or nuc is '-1' or nuc is -1
          return true
        false

    getQuestAllTestes:()->
      Tests = do @getAllTestes
      questsTests = []
      for val,key in Tests
        questUmcaso= val.slides.filter (slide)->
          return /quest/img.test(slide.tipo)
        questsTests=questsTests.concat questUmcaso
      questsTests

    getPercAtivTotal: (numAtivConcluidos, numAtiv)->
      return 0.0 if numAtivConcluidos is 0
      parseFloat(100 * numAtivConcluidos) / numAtiv

    getPercCasosTotal: (numCasosConcluidos, numCasos)->
      return 0.0 if numCasosConcluidos is 0
      parseFloat(100 * numCasosConcluidos) / numCasos

    getPercTestesTotal: (numTestesConcluidos, numTeste)->
      return 0.0 if numTestesConcluidos is 0
      parseFloat(100 * numTestesConcluidos) / numTeste

    getProgressoPorAtividades: ()->
      respostasPorAtividade = _.groupBy @models, (item)-> item.get('atividade')
      porAtiv = {}
      for _id, respostasDaAtividade of respostasPorAtividade
        #pega a atividade global pelo id
        atividade = _.findWhere(@atividades,{_id})
        #if atividade._id is "537b80e241e46f4367000000"

        #console.log 'respostasDaAtividade', respostasDaAtividade
        #pega as questoes da atividade
        questoesDaAtividade = atividade.slides.filter (slide)->
          /quest/img.test slide.tipo
        escore=0.0
        for respAtiv,key in respostasDaAtividade
          escore+=respAtiv.get('escore')
        escore=escore/respostasDaAtividade.length

        ativConcluida = questoesDaAtividade.length is respostasDaAtividade.length
        numQuestoesRespondidas = respostasDaAtividade.length
        numQuestoesTotais = questoesDaAtividade.length
        percConclusao = @calcPercentagem numQuestoesRespondidas, numQuestoesTotais
        #pega o numero de questoes caso/test - +length em questoes total e +1 no numCasos/numTest
        #se concluida +1 em concluida
        #numAtivConcluido++ if ativConcluida
        porAtiv[ _id ] = {
          escore
          ativConcluida
          numQuestoesTotais
          numQuestoesRespondidas
          percConclusao
        }

      @geral.porAtividade = porAtiv

    geral: {}
    CONTABADGE: 0
    temNovosBadges: (silent=false) ->
      return false unless @badges
      self = @
      # console.log @badges
      #numConcedidos = @badgesConcedidos.length
      badgesConcedidos = new BadgesColl()
      badgesConcedidos = @badgesConcedidos unless silent
      aConceder = new BadgesColl()
      # console.log badgesConcedidos
      @badges.each (badge)->
        # console.log badge.name
        #se tem id de atividade
        if badge.get('idAtiv') is ''
          #clica as atividades para ver se cada uma tem badge
          for idAtividade, ativ of self.geral.porAtividade
            # console.log badge.name
            # console.log idAtividade, ativ, 'umaAtiv'
            #verifica se tem badge para a atividade
            asQueTem = badge.get('rules').filter (regra)->
              # console.log badge.name
              regra.test ativ
            # console.log 'asQueTem', asQueTem.length, badge.get('rules').length
            #se merece badge
            if asQueTem.length is badge.get('rules').length
              #verifica se já foi dado
              # console.log self.badgesConcedidos
              foiDado = badgesConcedidos.where({_id:badge.get('_id'), idAtiv:idAtividade})
              #se não foi dado
              if foiDado.length is 0
                #da
                rules = badge.get('rules')
                badge.unset('rules')
                novoBadge = badge.clone()
                badge.set('rules',rules)
                novoBadge.set('idAtiv',idAtividade)
                # console.log 'novoBadge', novoBadge
                aConceder.add(novoBadge)
            null
        else
          # console.log self.geral, 'geral'
          pool = self.geral
          pool = self.calculaProgressoGeral() unless pool
          asQueTem = badge.get('rules').filter (regra)->
            # console.log badge.name
            regra.test pool
          # console.log asQueTem, 'asQueTem'
          #se merece badge
          if asQueTem.length is badge.get('rules').length
            foiDado = badgesConcedidos.where {_id:badge.get('_id')}
            # console.log foiDado, 'foiDado'
            #se não foi dado
            if foiDado.length is 0
              #da
              # console.log '-----------',badge
              aConceder.add(badge)

      # console.log 'badgesConcedidos', badgesConcedidos, aConceder
      # console.log arguments
      for bad in aConceder.models
        # console.log bad
        badgesConcedidos.add(bad) if bad instanceof BadgeModel

      # console.log 'silent', silent

      if !silent and aConceder.length > 0
        # console.log 'sdkfhasldkfhsalkjfhsad', aConceder
        ids = aConceder.map (badge)-> badge.get '_id'
        Backbone.history.loadUrl("comp/badge/concede/#{ids.join ','}")

        d = self.geral
        casos = d.percCasosConcluTotal
        acerto = d.percGeralAcertoCasos
        tfinal = d.percAcertoPosTeste


        aprovado =
          casos >= 70 and
          acerto >= 70 and
          tfinal >= 70

        console.log casos, acerto, tfinal, aprovado


      # console.log badgesConcedidos
      badgesConcedidos




#                                    Quantidades Totais Absolutas
#
#   numAtiv -----------------------> de Atividades
#   numCasos ----------------------> de Casos
#   numTestes ---------------------> de Testes
#   numQuestoesCaso ---------------> de Questões de Casos
#   numQuestoesTeste ---------------> de Questões de Testes
#
#                                    Somatórios Atuais
#
#   numCasosIniciados -------------> de Casos Iniciados ( ? deprecado )
#   numTestesIniciados ------------> de Testes Iniciados ( ? deprecado )
#   numAtivConcluido --------------> de Atividades Concluídas
#   numCasosConcluidos ------------> de Casos Concluídos
#   numTestesConcluidos -----------> de Questões de Casos Respondidas
#   numQuestoesCasoRespondidas ----> de Questões de Casos Respondidas
#   numQuestoesTesteRespondidas ----> de Questões de Teste Respondidas
#
#                                    Percentuais Relativos Atuais
#
#   percAtivConcluTotal -----------> de Atividades Concluídos do Total Absoluto de Atividades
#   percCasosConcluTotal ----------> de Casos Concluídos do Total Absoluto de Casos
#   percTestesConcluTotal ---------> de Testes Concluídos do Total
#   percAtivQuestTotal ------------> de Questões de Atividades Concluídas do Total de Questões
#   percCasosRespTotal ------------> de Questões de Casos Respondidas
#   percTestesRespTotal -----------> de Questões de Testes Respondidas
#   percGeralAcertoCasos ----------> de Acertos nas Respostas às Questões dos Casos
#   percGeralAcertoTestes ---------> de Acertos nos Respostas às Questões dos Testes
#
#                                    Por Atividade
#
#   porAtividade ------------------> Lista de Atividades (Casos e Testes)
#                                    {
#                                        < _id da atividade >: {
#                                            ativConcluida: false
#                                            escore: 50.5
#                                            numQuestoes: 4
#                                            numQuestoesRespondidas: 4
#                                            percConclusao: 66.66666666666667
#                                        },
#                                        { ... },
#                                        ...
#                                    }
#
