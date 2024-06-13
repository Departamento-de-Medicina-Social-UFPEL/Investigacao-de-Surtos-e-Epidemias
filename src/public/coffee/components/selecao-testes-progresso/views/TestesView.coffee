define [
  './OfertaInscricaoItem'
], (OfertaInscricaoItem) ->

  class TestesLayout extends Marionette.LayoutView

    initialize: ->

    className: 'selecao-testes-progresso container'

    template: '#selecao-testes-progresso-testes'

    ui:
      'inscricoes':'.inscricoes'

    onRender: ->
      self = @

    events:
      'click .gotoTestes': 'gotoTestes'
      'click .gotoInicialEnfermagem': 'gotoInicialEnfermagem'
      'click .gotoFinalEnfermagem': 'gotoFinalEnfermagem'
      'click .gotoInicialMedicina': 'gotoInicialMedicina'
      'click .gotoFinalMedicina': 'gotoFinalMedicina'
      'click .gotoInicialOdontologia': 'gotoInicialOdontologia'
      'click .gotoFinalOdontologia': 'gotoFinalOdontologia'
      'click .emitir-certificado': 'emitirCertificado'

    gotoHome: () ->
      Backbone.history.navigate '#comp/home', {trigger: on}

    gotoInicialInterdisciplinar: () ->
      unless App.user
        @gotoHome()

      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')) )[0];
      unless inicialDaPro
        Backbone.history.navigate "comp/selecao-testes-progresso", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoInicialEnfermagem: () ->
      unless App.user
        @gotoHome()
      proMap = '1': 1, '2': 0, '3': 2
      uPro = proMap['1']
      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      unless inicialDaPro
        Backbone.history.navigate "comp/selecao-testes-progresso", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoInicialMedicina: () ->
      unless App.user
        @gotoHome()
      proMap = '1': 1, '2': 0, '3': 2
      uPro = proMap['2']
      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      unless inicialDaPro
        Backbone.history.navigate "comp/selecao-testes-progresso", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoInicialOdontologia: () ->
      unless App.user
        @gotoHome()
      proMap = '1': 1, '2': 0, '3': 2
      uPro = proMap['3']
      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      unless inicialDaPro
        Backbone.history.navigate "comp/selecao-testes-progresso", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoFinalInterdisciplinar: () ->
      unless App.user
        @gotoHome()

      if App.masterFinalLockInterdisciplinar
        return Backbone.history.navigate "comp/home/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      _id = finalDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoFinalEnfermagem: () ->
      unless App.user
        @gotoHome()
      proMap = '1': 1, '2': 0, '3': 2, '0': 9
      uPro = proMap['1']

      if App.masterFinalLockEnfermagem
        return Backbone.history.navigate "comp/home/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      _id = finalDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}


    gotoFinalMedicina: () ->
      unless App.user
        @gotoHome()
      proMap = '1': 1, '2': 0, '3': 2, '0': 9
      uPro = proMap['2']

      if do App.masterFinalLockMedicina
        return Backbone.history.navigate "comp/home/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      _id = finalDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoFinalOdontologia: () ->
      unless App.user
        @gotoHome()
      proMap = '1': 1, '2': 0, '3': 2, '0': 9
      uPro = proMap['3']

      if do App.masterFinalLockOdontologia
        return Backbone.history.navigate "comp/home/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      _id = finalDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

  TestesLayout