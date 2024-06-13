define [
  '../models/Resposta'
  '../models/Badge'
  '../collections/Badges'
], (RespostaModel, BadgeModel, BadgesColl)->


  class ProgressoManager extends Backbone.Collection
    'model': RespostaModel
    'url': ''

    'create': (resposta)->
      res = @add resposta
      @geral = do @calculaProgressoGeral

      return unless App.user
      @badgesConcedidos = new BadgesColl unless @badgesConcedidos
      @badgesConcedidos.reset @temNovosBadges().models
      do @saveLocal
      @saveServer res


    saveLocal: ->
      return unless App.local
      {local, user} = App
      if @length > 0
        local.set "respostas-#{user.cpf}", @toJSON()
      else
        throw new Error

    saveServer: (res)->
      return unless App.socket
      App.socket.emit "respondeu", res.toJSON(), (data) ->
        console.log "emit respondeu res  -> ", res.toJSON()
        console.log "emit respondeu data -> ", data
        if data.modulo == "63758ed55ebc0215731f6c36" # Modulo de Investigação de surtos e pandemias.
          App.execute 'dashboard.calcProgresso', (percent) ->
            console.log 'novo progresso = ' + percent + '%'

    'initialize': (options)->
      @badgesConcedidos = new BadgesColl
      @badges = new BadgesColl App.badges.toJSON()
      @bind 'add', @onModelAdded, @
      @bind 'remove', @onModelRemoved, @
      @bind 'change reset', @onChange, @
      @bind 'reset', @onReset, @
      null

    'onChange': () ->
      key = "respostas-#{App.user.cpf}"
      App.local.set(key, @toJSON()) if App.local
      if App.progressoLateral
        if App.progressoLateral.currentView
          App.progressoLateral.currentView.render()
        # throw new Error
      # @badgesConcedidos = @temNovosBadges()

    'onReset': () ->
      # throw new Error
      # console.log  "@calculaProgressoGeral reset", arguments
      @geral = do @calculaProgressoGeral
      @badgesConcedidos = @temNovosBadges(yes)
      #aqui disparar render pagina inicial

    'setUser': (user)->
      @user = new Backbone.Model user
      @badgesConcedidos = new BadgesColl @temNovosBadges(yes).models
      @atividades = do @getAllAtividades
      @casos = do @getAllCasosByNucleo
      @testes = do @getAllTestesByNucleo

    'getByAtividadeId': (id) -> _.sortBy @where(atividade: id), 'seqid'

    'onModelAdded': (model, collection, options) ->
      if @user
        model.set 'user', @user.get 'cpf'
      model.set 'modulo', window.modulo._id

    'onModelRemoved': (model, collection, options) ->
      # console.log  "@calculaProgressoGeral onModelRemoved"
      if App.socket and App.socket.connected
        App.socket.emit("reiniciou", model.toJSON())
      @geral = do @calculaProgressoGeral
      @badgesConcedidos.reset @temNovosBadges(yes).models

    conta: 0

    calculaProgressoGeral: (callback) ->
      # console.log "CalculaProgresso #{@conta++}"
      #@models  is  respostas
      # @resolveCasosBloqueados()
      self = @
      if not @elegivel
        @elegivel = {medicina:"", enfermagem:"", odontologia:"", interdisciplinar:''}
      else
        if not @elegivel.medicina
          @elegivel.medicina = ""
        if not @elegivel.enfermagem
          @elegivel.enfermagem = ""
        if not @elegivel.odontologia
          @elegivel.odontologia = ""
        if not @elegivel.interdisciplinar
          @elegivel.interdisciplinar = ""
      profissional = self.user.get('profissional')
      return false unless @models
      #console.log @models,@models, 'modelos', App.atividades, @atividades

      respostasPorAtividade = _.groupBy @models, (item)-> item.get('atividade')
      atividadesPorUnidade = _.groupBy @getAllAtividades(), (item)-> item.unidade
      unidades = _.where(window.modulo.components, {folder: 'unidade-progresso'}).map (c)-> c.unidade
      unidades = unidades.filter (u)->
        return if u then true else false
      #console.log unidades, 'unidades', atividadesPorUnidade, 'atividadesPorUnidade', respostasPorAtividade, 'respostasPorAtividade'
      initialUnit = []
      for u in unidades
        initialUnit.push {}
      unidade = {}
      preTesteUnidade = posTesteUnidade = percPosTesteUnidade = numTestesConcluidos = numCasosUnidade = numCasosIniciados = percGeralAcertoCasos = numCasosConcluidos = numTestesIniciados = numQuestoesTesteUnidade = numQuestoesTesteRespondidas = {}
      for u in unidades
        unidade[u] = {
          preTesteUnidade: false
          posTesteUnidade: false
          numCasosConcluidos: 0.0
          percPosTesteUnidade: 0.0
          numCasosIniciados: 0.0
          numTestesIniciados: 0.0
          numTestesConcluidos: 0.0
          numQuestoesTesteRespondidas: 0.0
          numQuestoesTesteUnidade: 0.0
          percGeralAcertoCasos: 0.0
          percAcertoTestes: 0.0
          percCasosConcluUnidade: 0.0
          percAcertoPreTeste: 0.0
          percAcertoPosTeste: 0.0
        }
        #console.log 'unidadessssssss',u, unidade[u]
      # console.log @models
      # console.log respostasPorAtividade, 'respostasPorAtividade'
      #cicla groupby - para  cada atividade
      posTeste = preTeste = false
      posTesteEnfermagem = preTesteEnfermagem = false
      posTesteMedicina = preTesteMedicina = false
      posTesteOdontologia = preTesteOdontologia = false
      posTesteInterdisciplinar = preTesteInterdisciplinar = false
      percTestesTotal = percCasosRespTotal = percTestesRespTotal = percAtivQuestTotal = percAcertoPosTeste = percAcertoPreTeste = 0.0
      numCasosIniciados = numTestes = numAtiv = numQuestoesCasoRespondidas = numQuestoesTesteRespondidas = numTestesConcluidos = 0.0
      numQuestoesCaso = numQuestoes = numQuestoesTeste = numAtivConcluido = numCasos = numCasosNucleo = numTestesIniciados = percCasosTotal = 0.0
      numTestesConcluidosNucleo = numCasosConcluidos = numCasosConcluidosNucleo = percGeralAcertoCasos = percGeralAcertoCasosNucleo = percGeralAcertoTestes = percAtivTotal = 0.0
      percAcertoTestesNucleoEnfermagem = percAcertoTestesNucleoMedicina = percAcertoTestesNucleoOdontologia = percGeralAcertoCasosNucleoEnfermagem = percGeralAcertoCasosNucleoMedicina = percGeralAcertoCasosNucleoOdontologia = percGeralAcertoCasosNucleoInterdisciplinar = 0.0
      percCasosConcluNucleoEnfermagem = percCasosConcluNucleoMedicina = percCasosConcluNucleoOdontologia = percCasosConcluNucleoInterdisciplinar = 0.0
      numCasosConcluidosNucleoEnfermagem = numCasosConcluidosNucleoMedicina = numCasosConcluidosNucleoOdontologia = numCasosConcluidosNucleoInterdisciplinar = 0.0
      numCasosNucleoEnfermagem = numCasosNucleoMedicina = numCasosNucleoOdontologia = numCasosNucleoInterdisciplinar = 0.0
      numTestesConcluidosNucleoEnfermagem = numTestesConcluidosNucleoMedicina = numTestesConcluidosNucleoOdontologia = numTestesConcluidosNucleoInterdisciplinar = 0.0
      numQuestoesTesteRespondidasNucleoEnfermagem = numQuestoesTesteRespondidasNucleoMedicina = numQuestoesTesteRespondidasNucleoOdontologia = numQuestoesTesteRespondidasNucleoInterdisciplinar = 0.0
      numQuestoesTesteNucleoEnfermagem = numQuestoesTesteNucleoMedicina = numQuestoesTesteNucleoOdontologia = numQuestoesTesteNucleoInterdisciplinar = 0.0
      percAcertoPosTesteEnfermagem = percAcertoPosTesteMedicina = percAcertoPosTesteOdontologia = percAcertoPosTesteInterdisciplinar = 0.0
      percAcertoPreTesteEnfermagem = percAcertoPreTesteMedicina = percAcertoPreTesteOdontologia = percAcertoPreTesteInterdisciplinar = 0.0

      for _id, respostasDaAtividade of respostasPorAtividade
        #pega a atividade global pelo id
        atividade = _.findWhere @atividades, { _id }
        if not atividade
          continue

        #pega as questoes da atividade
        questoesDaAtividade = atividade.slides.filter (slide)-> /quest/img.test slide.tipo

        escore = 0.0
        for respAtiv, key in respostasDaAtividade
          escore += respAtiv.get('escore')
        if respostasDaAtividade.length > 0
          escore = escore / respostasDaAtividade.length
        else
          escore = 0

        ativConcluida = questoesDaAtividade.length <= respostasDaAtividade.length and escore >= 70.00
        #if ['6081742341e46f51549e042a','6082ccff41e46f7a6cd06fb3', '60eb810e41e46f582d9acd4e'].indexOf(atividade._id) > -1
        #''  console.log questoesDaAtividade.length , respostasDaAtividade.length , escore >= 70.00, escore , 'atividade concluida?', atividade._id
        ativEhDoNucleo = @ehDoNucleo(atividade, profissional)
        #console.log atividade, ativConcluida, 'respostasDaAtividade', respostasDaAtividade, atividade.unidade
        #pega o numero de questoes caso/test - +leng th em questoes total e +1 no numCasos/numTest
        # console.log atividade
        # console.log atividade.tipo
        switch atividade.tipo
          when 'saibamais'
            numCasosIniciados++
            if atividade.unidade
              unidade[atividade.unidade].numCasosIniciados++
            if ativConcluida
              numQuestoesCasoRespondidas += respostasDaAtividade.length
              percGeralAcertoCasos += escore
              numCasosConcluidos++
              if ativEhDoNucleo
                percGeralAcertoCasosNucleo += escore
                numCasosConcluidosNucleo++
              #adicionado para calcular nucleos separadamente
              if self.ehDoNucleoByNucleo(atividade, 1)
                percGeralAcertoCasosNucleoEnfermagem += escore
                numCasosConcluidosNucleoEnfermagem++
              if self.ehDoNucleoByNucleo(atividade, 2)
                percGeralAcertoCasosNucleoMedicina += escore
                numCasosConcluidosNucleoMedicina++
              if self.ehDoNucleoByNucleo(atividade, 3)
                percGeralAcertoCasosNucleoOdontologia += escore
                numCasosConcluidosNucleoOdontologia++
              if atividade.unidade
                unidade[atividade.unidade].percGeralAcertoCasos += escore
                unidade[atividade.unidade].numCasosConcluidos++
          when 'caso'
            numCasosIniciados++
            if atividade.unidade
              unidade[atividade.unidade].numCasosIniciados++
            if ativConcluida
              numQuestoesCasoRespondidas += respostasDaAtividade.length
              percGeralAcertoCasos += escore
              numCasosConcluidos++
              if ativEhDoNucleo
                percGeralAcertoCasosNucleo += escore
                numCasosConcluidosNucleo++
              #adicionado para calcular nucleos separadamente
              if self.ehDoNucleoByNucleo(atividade, 1)
                percGeralAcertoCasosNucleoEnfermagem += escore
                numCasosConcluidosNucleoEnfermagem++
              if self.ehDoNucleoByNucleo(atividade, 2)
                percGeralAcertoCasosNucleoMedicina += escore
                numCasosConcluidosNucleoMedicina++
              if self.ehDoNucleoByNucleo(atividade, 3)
                percGeralAcertoCasosNucleoOdontologia += escore
                numCasosConcluidosNucleoOdontologia++
              if atividade.unidade
                unidade[atividade.unidade].percGeralAcertoCasos += escore
                unidade[atividade.unidade].numCasosConcluidos++
                #console.log 'eeeeeeeeeeeeee', unidade[atividade.unidade].percGeralAcertoCasos,unidade[atividade.unidade].numCasosConcluidos, escore
          when 'teste'
            numTestesIniciados++
            numQuestoesTesteNucleoInterdisciplinar += respostasDaAtividade.length
            if self.ehDoNucleoByNucleo(atividade, 1)
              numQuestoesTesteNucleoEnfermagem += questoesDaAtividade.length
              numQuestoesTesteRespondidasNucleoEnfermagem += respostasDaAtividade.length
            if self.ehDoNucleoByNucleo(atividade, 2)
              numQuestoesTesteNucleoMedicina += questoesDaAtividade.length
              numQuestoesTesteRespondidasNucleoMedicina += respostasDaAtividade.length
            if self.ehDoNucleoByNucleo(atividade, 3)
              numQuestoesTesteNucleoOdontologia += questoesDaAtividade.length
              numQuestoesTesteRespondidasNucleoOdontologia += respostasDaAtividade.length
            if atividade.unidade
              console.log atividade, unidade
              unidade[atividade.unidade].numTestesIniciados++
              unidade[atividade.unidade].numQuestoesTesteUnidade += questoesDaAtividade.length
              unidade[atividade.unidade].numQuestoesTesteRespondidas += respostasDaAtividade.length
            if ativConcluida
              numTestesConcluidos++
              numTestesConcluidosNucleoInterdisciplinar++
            percGeralAcertoTestes += escore
            numQuestoesTesteRespondidas += respostasDaAtividade.length
            numQuestoesTesteRespondidasNucleoInterdisciplinar += respostasDaAtividade.length
            if ativEhDoNucleo
              percAcertoTestesNucleo = escore
              numTestesConcluidosNucleo++
              if atividade.posTeste
                percAcertoPosTeste = escore
                if ativConcluida
                  posTeste = true
                  posTesteInterdisciplinar = true
              else
                percAcertoPreTeste = escore
                if ativConcluida
                  preTeste = true
                  preTesteInterdisciplinar = true
            if atividade.posTeste
              percAcertoPosTesteInterdisciplinar = escore
              if self.ehDoNucleoByNucleo(atividade, 1)
                percAcertoPosTesteEnfermagem = escore
                if ativConcluida
                  posTesteEnfermagem = true
              if self.ehDoNucleoByNucleo(atividade, 2)
                percAcertoPosTesteMedicina = escore
                if ativConcluida
                  posTesteMedicina = true
              if self.ehDoNucleoByNucleo(atividade, 3)
                percAcertoPosTesteOdontologia = escore
                if ativConcluida
                  posTesteOdontologia = true
              if atividade.unidade
                unidade[atividade.unidade].percAcertoPosTeste = escore
                if ativConcluida
                  unidade[atividade.unidade].posTesteUnidade = true
                  unidade[atividade.unidade].numTestesConcluidos++
            else
              percAcertoPreTesteInterdisciplinar = escore
              if self.ehDoNucleoByNucleo(atividade, 1)
                percAcertoPreTesteEnfermagem = escore
                if ativConcluida
                  preTesteEnfermagem = true
              if self.ehDoNucleoByNucleo(atividade, 2)
                percAcertoPreTesteMedicina = escore
                if ativConcluida
                  preTesteMedicina = true
              if self.ehDoNucleoByNucleo(atividade, 3)
                percAcertoPreTesteOdontologia = escore
                if ativConcluida
                  preTesteOdontologia = true
              if atividade.unidade
                unidade[atividade.unidade].percAcertoPreTeste = escore
                if ativConcluida
                  unidade[atividade.unidade].preTeste = true
            #adicionado para calcular nucleos separadamente
            if self.ehDoNucleoByNucleo(atividade, 1)
              percAcertoTestesNucleoEnfermagem += escore
              if ativConcluida
                numTestesConcluidosNucleoEnfermagem++
            if self.ehDoNucleoByNucleo(atividade, 2)
              percAcertoTestesNucleoMedicina += escore
              if ativConcluida
                numTestesConcluidosNucleoMedicina++
            if self.ehDoNucleoByNucleo(atividade, 3)
              percAcertoTestesNucleoOdontologia += escore
              if ativConcluida
                numTestesConcluidosNucleoOdontologia++
            if atividade.unidade
              unidade[atividade.unidade].percAcertoTestes += escore
              if ativConcluida
                unidade[atividade.unidade].numTestesConcluidos++
                unidade[atividade.unidade].numTestesConcluidos++
        #se concluida +1 em concluida
        numAtivConcluido++ if ativConcluida
      # fim do for respostasPorAtividade
      numAtiv = (do @getAllAtividades).length
      numCasos = (do @getAllCasosByNucleo).length
      numCasosNucleo = (@getAllCasosByNucleo(profissional)).length
      #numCasosNucleo = (@getAllCasosByNucleo()).filter((c)-> self.ehDoNucleo(c, profissional)).length

      numCasosNucleoEnfermagem = (do @getAllCasosByNucleo).filter((c)-> self.ehDoNucleoByNucleo(c, 1)).length
      numCasosNucleoMedicina = (do @getAllCasosByNucleo).filter((c)-> self.ehDoNucleoByNucleo(c, 2)).length
      numCasosNucleoOdontologia = (do @getAllCasosByNucleo).filter((c)-> self.ehDoNucleoByNucleo(c, 3)).length
      #console.log profissional, numCasosNucleo,numCasosConcluidosNucleo, numCasosNucleoEnfermagem, numCasosConcluidosNucleoEnfermagem, 'casos percent'
      unidades.forEach (u)->
        uni = atividadesPorUnidade[u]
        if !uni
          return
        unidade[u].numCasosUnidade = uni.filter((c)-> c.tipo == 'caso' or c.tipo == 'saibamais').length

      numTestes = (do @getAllTestesByNucleo).length
      numQuestoesTeste = (do @getQuestAllTestes).length
      numQuestoesCaso = (do @getQuestAllCasos).length
      numQuestoes = numQuestoesCaso + numQuestoesTeste
      numAtivConcluidos = numTestesConcluidos + numCasosConcluidos
      percCasosConcluTotal = @calcPercentagem numCasosConcluidos, numCasos
      percCasosConcluNucleo = @calcPercentagem numCasosConcluidosNucleo, numCasosNucleo

      #progresso nucleos
      percCasosConcluNucleoEnfermagem = @calcPercentagem numCasosConcluidosNucleoEnfermagem, numCasosNucleoEnfermagem
      percCasosConcluNucleoMedicina = @calcPercentagem numCasosConcluidosNucleoMedicina, numCasosNucleoMedicina
      percCasosConcluNucleoOdontologia = @calcPercentagem numCasosConcluidosNucleoOdontologia, numCasosNucleoOdontologia
      percCasosConcluNucleoInterdisciplinar = @calcPercentagem numCasosConcluidos, numCasos
      self = @

      # console.log(numCasosConcluidosNucleoOdontologia , numCasosNucleoOdontologia, 'teste')

      percCasosRespTotal = @calcPercentagem numQuestoesCasoRespondidas, numQuestoesCaso
      percTestesConcluTotal = @calcPercentagem numTestesConcluidos, numTestes
      percTestesRespTotal = @calcPercentagem numQuestoesTesteRespondidas, numQuestoesTeste
      percAtivConcluTotal = @calcPercentagem numAtivConcluidos, numAtiv
      percAtivQuestRespTotal = @calcPercentagem numQuestoesTesteRespondidas + numQuestoesCasoRespondidas, numQuestoesTeste + numQuestoesCaso
      percGeralAcertoCasosNucleo = (percGeralAcertoCasosNucleo / numCasosConcluidosNucleo) if numCasosConcluidosNucleo > 0

      #progresso nucleos
      percGeralAcertoCasosNucleoEnfermagem = (percGeralAcertoCasosNucleoEnfermagem / numCasosConcluidosNucleoEnfermagem) if numCasosConcluidosNucleoEnfermagem > 0
      percGeralAcertoCasosNucleoMedicina = (percGeralAcertoCasosNucleoMedicina / numCasosConcluidosNucleoMedicina) if numCasosConcluidosNucleoMedicina > 0
      percGeralAcertoCasosNucleoOdontologia = (percGeralAcertoCasosNucleoOdontologia / numCasosConcluidosNucleoOdontologia) if numCasosConcluidosNucleoOdontologia > 0
      percGeralAcertoCasosNucleoInterdisciplinar = (percGeralAcertoCasos / numCasosConcluidos) if numCasosConcluidos > 0

      percGeralAcertoTestes = (percGeralAcertoTestes / numTestesConcluidos) if numTestesConcluidos > 0
      percAcertoTestesNucleo = (percAcertoTestesNucleo / numTestesConcluidosNucleo) if numTestesConcluidosNucleo > 0

      percAcertoTestesNucleoEnfermagem = (percAcertoTestesNucleoEnfermagem / numTestesConcluidosNucleoEnfermagem) if numTestesConcluidosNucleoEnfermagem > 0
      percAcertoTestesNucleoMedicina = (percAcertoTestesNucleoMedicina / numTestesConcluidosNucleoMedicina) if numTestesConcluidosNucleoMedicina > 0
      percAcertoTestesNucleoOdontologia = (percAcertoTestesNucleoOdontologia / numTestesConcluidosNucleoOdontologia) if numTestesConcluidosNucleoOdontologia > 0
      percAcertoTestesNucleoInterdisciplinar = percGeralAcertoTestes

      percGeralAcertoCasos = (percGeralAcertoCasos / numCasosConcluidos) if numCasosConcluidos > 0
      porAtividade = do @getProgressoPorAtividades

      preTesteInterdisciplinar = preTeste

      geral = {
        percCasosRespTotal, percCasosConcluTotal, percTestesConcluTotal, percTestesRespTotal
        percAtivConcluTotal, percAtivQuestRespTotal
        numQuestoesTeste, numAtivConcluido, numCasos, numTestes
        numQuestoesTesteRespondidasNucleoEnfermagem
        numQuestoesTesteRespondidasNucleoMedicina
        numQuestoesTesteRespondidasNucleoOdontologia
        numQuestoesTesteRespondidasNucleoInterdisciplinar
        numQuestoesTesteNucleoEnfermagem
        numQuestoesTesteNucleoMedicina
        numQuestoesTesteNucleoOdontologia
        numQuestoesTesteNucleoInterdisciplinar
        percAcertoPosTeste, percAcertoPreTeste
        percAcertoPosTesteEnfermagem, percAcertoPreTesteEnfermagem
        percAcertoPosTesteMedicina, percAcertoPreTesteMedicina
        percAcertoPosTesteOdontologia, percAcertoPreTesteOdontologia
        percAcertoPosTesteInterdisciplinar, percAcertoPreTesteInterdisciplinar
        posTeste, preTeste
        posTesteEnfermagem, preTesteEnfermagem
        posTesteMedicina, preTesteMedicina
        posTesteOdontologia, preTesteOdontologia
        posTesteInterdisciplinar, preTesteInterdisciplinar
        percGeralAcertoTestes
        percAcertoTestesNucleoEnfermagem
        percAcertoTestesNucleoMedicina
        percAcertoTestesNucleoOdontologia
        percAcertoTestesNucleoInterdisciplinar
        percGeralAcertoCasosNucleoEnfermagem
        percGeralAcertoCasosNucleoMedicina
        percGeralAcertoCasosNucleoOdontologia
        percGeralAcertoCasosNucleoInterdisciplinar
        percCasosConcluNucleoEnfermagem, percCasosConcluNucleoMedicina, percCasosConcluNucleoOdontologia, percCasosConcluNucleoInterdisciplinar
        numQuestoesCaso, numTestesIniciados, numCasosIniciados, numTestesConcluidos
        numQuestoesCasoRespondidas, numQuestoesCaso, numQuestoesTesteRespondidas
        numTestesConcluidosNucleo, numAtiv, numCasosConcluidos, numQuestoes, percCasosConcluNucleo
        numCasosConcluidosNucleo, percGeralAcertoCasosNucleo, numCasosNucleo
        percGeralAcertoCasos, porAtividade,
        unidade:unidade
      }
      #console.log unidades, 'unidades'#
      if unidades.length > 0
        unidades.forEach (u)->
          #console.log 'unidade', u
          geral.unidade[u] = {
            numCasosUnidade:unidade[u].numCasosUnidade
            numCasosConcluidos: if unidade[u].numCasosConcluidos then unidade[u].numCasosConcluidos else 0
            numCasosIniciados: if unidade[u].numCasosIniciados then unidade[u].numCasosIniciados else 0
            numTestesIniciados: if unidade[u].numTestesIniciados then unidade[u].numTestesIniciados else 0
            posTesteUnidade: if unidade[u].posTesteUnidade then unidade[u].posTesteUnidade else false
            preTesteUnidade: if unidade[u].preTesteUnidade then unidade[u].preTesteUnidade else false
            numTestesConcluidos: if unidade[u].numTestesConcluidos then unidade[u].numTestesConcluidos else 0
            numQuestoesTesteRespondidas: if unidade[u].numQuestoesTesteRespondidas then unidade[u].numQuestoesTesteRespondidas else 0
            numQuestoesTesteUnidade: if unidade[u].numQuestoesTesteUnidade then unidade[u].numQuestoesTesteUnidade else 0
            percCasosConclu: self.calcPercentagem unidade[u].numCasosConcluidos, unidade[u].numCasosUnidade
            percGeralAcertoCasos: self.calcPercentagem unidade[u].percGeralAcertoCasos , unidade[u].numCasosConcluidos
            percAcertoTestes:  if unidade[u].percAcertoTestes > 0 then (unidade[u].percAcertoTestes / unidade[u].numTestesConcluidos) else 0.0
            percAcertoPreTeste: if unidade[u].percAcertoPreTeste then unidade[u].percAcertoPreTeste else 0
            percAcertoPosTeste: if unidade[u].percAcertoPosTeste then unidade[u].percAcertoPosTeste else 0
          }

      @geral = geral
      callback() if callback
      geral

    calcPercentagem:(vparcial, vtotal)->
      return 0.0 if vparcial is 0
      perc = (parseFloat(100*vparcial)/vtotal)

    getAllAtividades:()->
      do App.atividades.toJSON

    getAllCasosByNucleo:(nuc)->
      if not nuc
        return App.casos.toJSON()
      self = @
      nuc = self.user.get('profissional')
      App.casos.toJSON().filter (atividade)-> self.ehDoNucleo atividade, nuc

    ehDoNucleo : (atividade, nuc)->
      self = @
      nuc = parseInt nuc
      # nuc = self.user.get('profissional')
      if atividade.pro[0] and (nuc is '2' or nuc is 2)
        return true
      if atividade.pro[1] and (nuc is '1' or nuc is 1)
        return true
      if atividade.pro[2] and (nuc is '3' or nuc is 3)
        return true
      if nuc is '0' or nuc is 0 or nuc is '-1' or nuc is -1
        return true
      false

    ehDoNucleoByNucleo : (atividade, nuc)->
      self = @
      if atividade.pro[0] and (nuc is '2' or nuc is 2)
        return true
      if atividade.pro[1] and (nuc is '1' or nuc is 1)
        return true
      if atividade.pro[2] and (nuc is '3' or nuc is 3)
        return true
      if nuc is '0' or nuc is 0 or nuc is '-1' or nuc is -1
        return true
      false

    getQuestAllCasos:()->
      casos = do @getAllCasosByNucleo
      questsCasos= []
      for val,key in casos
        questUmcaso= val.slides.filter (slide)->
          return /quest/img.test(slide.tipo)
        questsCasos=questsCasos.concat questUmcaso
      questsCasos

    getAllTestesByNucleo:(nuc)->
      self = @
      if not nuc
        return App.testes.toJSON()
      App.testes.toJSON().filter (atividade)-> self.ehDoNucleo atividade

    getQuestAllTestes:(nuc)->
      Tests = @getAllTestesByNucleo nuc
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
        if not atividade
          continue

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
          tipo: atividade.tipo
          numQuestoesRespondidas
          percConclusao
        }

      @geral.porAtividade = porAtiv

    geral: {}
    CONTABADGE: 0
    temNovosBadges: (silent=false) ->
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
              #console.log ativ, 'ativ'
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
        if do App.masterElegivelCert
          App.main.once 'show', ()->
            App.appRouter.navigate("comp/home/elegivel-certificacao", {trigger: yes})


      # console.log badgesConcedidos
      badgesConcedidos
