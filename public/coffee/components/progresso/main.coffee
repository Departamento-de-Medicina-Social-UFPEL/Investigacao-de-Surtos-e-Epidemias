define [
  './collections/Progresso'
  './models/Caso'
  './controller'
  './routes'
  'backbone'
], (Progresso, Caso, controller, routes, Backbone) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"
      prefixedRoutes[path] = val
    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    ListaAtividades = Backbone.Collection.extend
      model: Caso


    parentApp.atividades = new ListaAtividades
    parentApp.casos = new ListaAtividades
    parentApp.testes = new ListaAtividades
    parentApp.progresso = new Progresso

    appComponents = []
    appComponents = appComponents.concat _.where(window.modulo.components, {folder:'listatestes'})
    iterador = (u)->
      if u.folder is 'unidade-progresso'
        if u.short isnt "Unidade extra"
          return true
      return false
    unidades = window.modulo.components.filter iterador
    selecao = _.where(window.modulo.components, {folder:'selecao-progresso'})
    selecaoTestes = _.where(window.modulo.components, {folder:'selecao-testes-progresso'})

    if unidades.length is 0
      appComponents = appComponents.concat selecao
      appComponents = appComponents.concat selecaoTestes
    else
      appComponents = appComponents.concat unidades
    for appC in appComponents
      if not appC.resource
        break
      #console.log appC.resource.casos.length, 'numero casos', unidades
      appC.resource.casos.map (c)->
        if appC.folder is 'listatestes'
          c.tipo = 'teste'
          c.posTeste = !(/inicial/img.test c.titulo)
          parentApp.testes.add c
        if unidades.length > 0
          c.unidade = appC.unidade if appC.unidade
          if appC.folder is 'unidade-progresso'
            c.tipo = if c.tipo then c.tipo else 'caso'
            parentApp.casos.add c
        else
          if appC.folder is 'selecao-progresso'
            c.tipo = 'caso'
            parentApp.casos.add c
        parentApp.atividades.add c
        c

    parentApp.on 'beforeStart', () ->
      menuEntry =
        'style':'link'
        'link':'#comp/progresso'
        'icone':'mdi-speedometer'
        'texto': "Meu Progresso"
      App.menuEntries.push menuEntry

    parentApp.on 'beforeHistoryStart', () ->
      {progresso, local, user, socket} = App
      if local
        if user
          if local
            respostas = local.get "respostas-#{user.cpf}"
            if respostas and respostas.length > 0
              progresso.reset respostas

            progresso.calculaProgressoGeral()

    parentApp.masterFinalLock = ->
      lockTesteFinal = [
        parentApp.finalLockEnfermagem()
        parentApp.finalLockMedicina()
        parentApp.finalLockOdontologia()
      ]
      lockTesteFinal

    parentApp.masterFinalLockInterdisciplinar = ()->
      {user, progresso} = App
      lockTesteFinal = yes
      if user and progresso
        g = progresso.geral
        if (g.percCasosConcluTotal >= 70) and (g.percGeralAcertoCasos >= 70)
          lockTesteFinal = off
      lockTesteFinal

    parentApp.masterFinalLockUnidade = (unidade)->
      {user, progresso} = App
      lockTesteFinal = yes
      if user and progresso
        g = progresso.geral
        if g.unidade[unidade].numCasosUnidade is 0
          lockTesteFinal = off
        else
          if (g.unidade[unidade].percCasosConclu >= 70) and (g.unidade[unidade].percGeralAcertoCasos >= 70 )
            lockTesteFinal = off
      lockTesteFinal

    parentApp.masterFinalLockEnfermagem = ()->
      {user, progresso} = App
      lockTesteFinalEnfermagem = yes
      if user and progresso
        g = progresso.geral
        if (g.percCasosConcluNucleoEnfermagem >= 70) and (g.percGeralAcertoCasosNucleoEnfermagem >= 70)
          lockTesteFinalEnfermagem = off
      lockTesteFinalEnfermagem

    parentApp.masterFinalLockMedicina = ()->
      {user, progresso} = App
      lockTesteFinalMedicina = yes
      if user and progresso
        g = progresso.geral
        if (g.percCasosConcluNucleoMedicina >= 70) and (g.percGeralAcertoCasosNucleoMedicina >= 70)
          lockTesteFinalMedicina = off
      lockTesteFinalMedicina

    parentApp.masterFinalLockOdontologia = ()->
      {user, progresso} = App
      lockTesteFinalOdontologia = yes
      if user and progresso
        g = progresso.geral
        if (g.percCasosConcluNucleoOdontologia >= 70) and (g.percGeralAcertoCasosNucleoOdontologia >= 70)
          lockTesteFinalOdontologia = off
      lockTesteFinalOdontologia


    parentApp.masterElegivelCert = ->
      flag = true
      if window.modulo.fl_por_unidade
        unidades = _.where(window.modulo.components, {folder: 'unidade-progresso'}).filter((c)-> c.unidade).map (c)-> c.unidade
        elegivel = unidades.map (o)-> App["masterElegivelCertUnidade"](o)
      else
        elegivel = window.modulo.ofertasAbertas.map (o)->
          conteudo = o.conteudo
          conteudo = conteudo[0].toUpperCase()+ conteudo.slice(1)
          App["masterElegivelCert"+conteudo]()
      elegivel.forEach (e)->
        flag = flag and e
      flag


    parentApp.masterElegivelCertEnfermagem = ()->
      {user, progresso} = App
      elegivelEnfermagem = off
      if user and progresso
        g = progresso.geral
        casos = g.percCasosConcluNucleoEnfermagem
        acerto = g.percGeralAcertoCasosNucleoEnfermagem
        tfinal = g.percAcertoPosTesteEnfermagem
        elegivelEnfermagem =
          casos >= 70 and
          acerto >= 70 and
          tfinal >= 70
      elegivelEnfermagem

    parentApp.masterElegivelCertMedicina = ()->
      {user, progresso} = App
      elegivelMedicina = off
      if user and progresso
        g = progresso.geral
        casos = g.percCasosConcluNucleoMedicina
        acerto = g.percGeralAcertoCasosNucleoMedicina
        tfinal = g.percAcertoPosTesteMedicina
        elegivelMedicina =
          casos >= 70 and
          acerto >= 70 and
          tfinal >= 70
      elegivelMedicina

    parentApp.masterElegivelCertOdontologia = ()->
      {user, progresso} = App
      elegivelOdontologia = off
      if user and progresso
        g = progresso.geral
        casos = g.percCasosConcluNucleoOdontologia
        acerto = g.percGeralAcertoCasosNucleoOdontologia
        tfinal = g.percAcertoPosTesteOdontologia
        elegivelOdontologia =
          casos >= 70 and
          acerto >= 70 and
          tfinal >= 70
      elegivelOdontologia

    parentApp.masterElegivelCertInterdisciplinar = ()->
      {user, progresso} = App
      elegivel = off
      if user and progresso
        g = progresso.geral
        casos = g.percCasosConcluTotal
        acerto = g.percGeralAcertoCasos
        tfinal = g.percAcertoPosTesteInterdisciplinar
        elegivel =
          casos >= 70 and
          acerto >= 70 and
          tfinal >= 70
      elegivel
    parentApp.masterElegivelCertUnidade = (u)->
      {user, progresso} = App
      elegivel = off
      if user and progresso
        g = progresso.geral
        casos = g.unidade[u].percCasosConclu
        acerto = g.unidade[u].percGeralAcertoCasos
        tfinal = g.unidade[u].percAcertoPosTeste
        elegivel =
          (casos >= 70 or g.unidade[u].numCasosUnidade is 0) and
          (acerto >= 70 or g.unidade[u].numCasosUnidade is 0) and
          tfinal >= 70
      elegivel


