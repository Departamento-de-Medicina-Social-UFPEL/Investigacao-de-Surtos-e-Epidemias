define ['backbone', 'backbone.marionette'], (Backbone, Marionette) ->

  class TestesView extends Marionette.ItemView

    model: new Backbone.Model

    className: 'testes enf-med-main container'

    template: '#listatestes-main'

    events:
      'click .gotoTestes': 'gotoTestes'
      'click .gotoFinalUnidade': 'gotoFinalUnidade'
      'click .gotoInicialUnidade': 'gotoInicialUnidade'
      'click .gotoInicialEnfermagem': 'gotoInicialEnfermagem'
      'click .gotoFinalEnfermagem': 'gotoFinalEnfermagem'
      'click .gotoInicialInterdisciplinar': 'gotoInicialInterdisciplinar'
      'click .gotoInicialMedicina': 'gotoInicialMedicina'
      'click .gotoFinalMedicina': 'gotoFinalMedicina'
      'click .gotoInicialOdontologia': 'gotoInicialOdontologia'
      'click .gotoFinalOdontologia': 'gotoFinalOdontologia'
      'click .gotoFinalInterdisciplinar': 'gotoFinalInterdisciplinar'
      'click .emitir-certificado': 'emitirCertificado'

    gotoHome: () ->
      unless App.user
        Backbone.history.navigate '#comp/home', {trigger: on}

    gotoCasos: () ->
      @gotoHome()
      Backbone.history.navigate '#comp/selecao-progresso', {trigger: on}

    gotoCalculadoras: () ->
      Backbone.history.navigate '#comp/calculadoras', {trigger: on}

    gotoMaterial: () ->
      Backbone.history.navigate '#comp/materiais', {trigger: on}

    gotoTestes: () ->
      @gotoHome()
      Backbone.history.navigate '#comp/listatestes', {trigger: on}

    gotoInicialInterdisciplinar: () ->
      @gotoHome()
      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')) )[0]
      unless inicialDaPro
        Backbone.history.navigate "comp/listatestes", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}
    
    gotoInicialUnidade: (e) ->
      u = $(e.target).data('unidade')
      @gotoHome()
      inicialDaPro = (App.testes.filter (d)-> /inicial/img.test(d.get('titulo')) && d.get('unidade') == u )[0]
      unless inicialDaPro
        Backbone.history.navigate "comp/listatestes", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoInicialEnfermagem: () ->
      @gotoHome()
      proMap = '1': 1, '2': 0, '3': 2
      uPro = proMap['1']
      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      unless inicialDaPro
        Backbone.history.navigate "comp/listatestes", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoInicialMedicina: () ->
      @gotoHome()
      proMap = '1': 1, '2': 0, '3': 2
      uPro = proMap['2']
      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      unless inicialDaPro
        Backbone.history.navigate "comp/listatestes", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoInicialOdontologia: () ->
      @gotoHome()
      proMap = '1': 1, '2': 0, '3': 2
      uPro = proMap['3']
      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      unless inicialDaPro
        Backbone.history.navigate "comp/listatestes", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoFinalInterdisciplinar: () ->
      @gotoHome()

      if do App.masterFinalLockInterdisciplinar
        return Backbone.history.navigate "comp/home/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')) )[0];
      _id = finalDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoFinalEnfermagem: () ->
      @gotoHome()
      proMap = '1': 1, '2': 0, '3': 2, '0': 9
      uPro = proMap['1']

      console.log uPro is 9, App.masterFinalLockEnfermagem(), 'teste'
      if do App.masterFinalLockEnfermagem
        return Backbone.history.navigate "comp/home/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      _id = finalDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoFinalUnidade: (e) ->
      u = $(e.target).data('unidade')
      @gotoHome()
      inicialDaPro = (App.testes.filter (d)-> /final/img.test(d.get('titulo')) && d.get('unidade') == u )[0]
      console.log 'inicialPro', inicialDaPro, u
      unless inicialDaPro
        Backbone.history.navigate "comp/listatestes", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoFinalMedicina: () ->
      @gotoHome()
      proMap = '1': 1, '2': 0, '3': 2, '0': 9
      uPro = proMap['2']

      if do App.masterFinalLockMedicina
        return Backbone.history.navigate "comp/home/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      _id = finalDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoFinalOdontologia: () ->
      @gotoHome()
      proMap = '1': 1, '2': 0, '3': 2, '0': 9
      uPro = proMap['3']

      if do App.masterFinalLockOdontologia
        return Backbone.history.navigate "comp/home/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')) && d.get('pro')[uPro])[0];
      _id = finalDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    onRender: () ->

  TestesView