define [
  './controller'
  './routes'
], (controller, routes, TelaView) ->

  return (component, parentApp, Backbone, Marionette, $, _)->

    prefixedRoutes = {}
    for key, val of routes
      path = "comp/#{@moduleName}#{key}"
      prefixedRoutes[path] = val

    parentApp.appRouter.processAppRoutes controller, prefixedRoutes

    # parentApp.on 'beforeStart', () ->
    #   menuEntry =
    #     'style':'link'
    #     'link':'#comp/badge/lista'
    #     'icone':'shield'
    #     'texto': "Distintivos"
    #   App.menuEntries.push menuEntry

    parentApp.badges = new Backbone.Collection [
      {
        _id: '1'
        name: 'Primeiro caso'
        icon: 'PrimeiroCaso.png'
        idAtiv: '1caso'
        rules: [ {
          prop: 'numCasosConcluidos'
          crit: '>'
          val: '0'
        }
        {
          prop: 'tipo'
          crit: '=='
          val: 'caso'
        } ]
      }
      {
        _id: '2'
        name: 'Mestre do módulo'
        icon: 'MestredoModulo.png'
        rules: [
          {
            prop: 'percAtivConcluTotal'
            crit: '=='
            val: '100'
          }
          {
            prop: 'percGeralAcertoCasos'
            crit: '=='
            val: '100'
          }
        ]
      }
      {
        _id: '3'
        name: '100% de acerto'
        icon: '100deAcertos.png'
        idAtiv: ''
        rules: [
          {
            prop: 'escore'
            crit: '=='
            val: '100'
          }
          {
            prop: 'percConclusao'
            crit: '=='
            val: '100'
          }
          {
            prop: 'tipo'
            crit: '!=='
            val: 'saibamais'
          }
        ]
      }
      {
        _id: '4'
        name: '70% de acerto'
        icon: '70deAcertos.png'
        idAtiv: ''
        rules: [
          {
            prop: 'escore'
            crit: '>='
            val: '70'
          }
          {
            prop: 'percConclusao'
            crit: '=='
            val: '100'
          }
          {
            prop: 'tipo'
            crit: '!=='
            val: 'saibamais'
          }
        ]
      }
      {
        _id: '5'
        name: '100% resolvidos'
        icon: '100resolvido.png'
        rules: [ {
          prop: 'percCasosConcluTotal'
          crit: '=='
          val: '100'
        } ]
      }
      {
        _id: '6'
        name: '70% resolvidos'
        icon: '70resolvido.png'
        rules: [ {
          prop: 'percCasosConcluTotal'
          crit: '>='
          val: '70'
        } ]
      }
      {
        _id: '7'
        name: '100% Pré-teste'
        icon: '100PreTeste.png'
        rules: [ {
          prop: 'percAcertoPreTeste'
          crit: '=='
          val: '100'
        } ]
      }
      {
        _id: '8'
        name: '100% Teste final'
        icon: '100TesteFinal.png'
        rules: [ {
          prop: 'percAcertoPosTeste'
          crit: '=='
          val: '100'
        } ]
      }
      {
        _id: '9'
        name: 'Pré-teste completo'
        icon: 'PreTesteCompleto.png'
        rules: [ {
          prop: 'preTeste'
          crit: '=='
          val: '1'
        } ]
      }
      {
        _id: '10'
        name: 'Pós-teste completo'
        icon: 'PosTesteCompleto.png'
        rules: [ {
          prop: 'posTeste'
          crit: '=='
          val: '1'
        } ]
      }
      {
        _id: '11'
        name: 'Você Sabia 100% visualizado'
        icon: '100deVisualizacao.png'
        idAtiv: ''
        rules: [
          {
            prop: 'escore'
            crit: '=='
            val: '100'
          }
          {
            prop: 'percConclusao'
            crit: '=='
            val: '100'
          }
          {
            prop: 'tipo'
            crit: '=='
            val: 'saibamais'
          }
        ]
      }]