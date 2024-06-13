define [
  './OfertaInscricaoItem'
], (OfertaInscricaoItem) ->

  class HomeLayout extends Marionette.LayoutView


    initialize: ->

    className: 'enf-med-main container'

    template: '#home-inicial'
    
    ui:
      'inscricoes':'.inscricoes'

    onRender: ->
      self = @
      self.obtemOfertasAbertas()
      self.verificaEnquetes()

    verificaEnquetes: ->
      if App.enquetes && App.user
        if App.user.enquetes
          if App.user.enquetes[App.moduloId]
            # console.log 'tem user enquetes cadastro parar o modulo',[App.moduloId], App.user.enquetes[App.moduloId]
            if App.user.enquetes[App.moduloId]['cadastro']
              # console.log 'tem user enquetes cadastro', App.user.enquetes[App.moduloId]['cadastro']
              return
        Backbone.history.navigate '#comp/enquetes/intro/'+App.user.cpf+'/tipo/cadastro', {trigger: yes}
      
    obtemOfertasAbertas: ()->
      self = @
      self.ui.inscricoes.empty()
      # console.log App.user, window.modulo.ofertasAbertas, 'window.modulo.ofertasAbertas'
      if(App.user)
        window.modulo.ofertasAbertas.forEach (o)->
          conteudo = o.conteudo
          conteudo = conteudo[0].toUpperCase()+ conteudo.slice(1)
          view = new OfertaInscricaoItem({model:new Backbone.Model({
            'nucleo': conteudo
            'id_arouca': o.id_arouca
            'tipo': o.tipo
            'nome': o.nome
          })})
          self.ui.inscricoes.append view.render().el
      else
        self.ui.inscricoes.append "
          <div class='col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center'>
              <button class='btn btn-success display-4 gotoForm'>Inscreva-se aqui</button>
          </div>
        "

    events:
      'click .gotoUnidade': 'gotoUnidade'
      'click .gotoForm': 'gotoForm'
      'click .gotoCasos': 'gotoCasos'
      'click .gotoCalculadoras': 'gotoCalculadoras'
      'click .gotoMaterial': 'gotoMaterial'
      'click .gotoTestes': 'gotoTestes'
      'click .gotoInicialEnfermagem': 'gotoInicialEnfermagem'
      'click .gotoFinalEnfermagem': 'gotoFinalEnfermagem'
      'click .gotoInicialMedicina': 'gotoInicialMedicina'
      'click .gotoFinalMedicina': 'gotoFinalMedicina'
      'click .gotoInicialOdontologia': 'gotoInicialOdontologia'
      'click .gotoFinalOdontologia': 'gotoFinalOdontologia'
      'click .gotoFinalInterdisciplinar': 'gotoFinalInterdisciplinar'
      'click .gotoInicialInterdisciplinar': 'gotoInicialInterdisciplinar'
      'click .gotoVideo': 'gotoVideo'

    gotoForm: () ->
      Backbone.history.navigate '#comp/cadastro', {trigger: on}

    gotoUnidade: (e) ->
      unless App.user
        @gotoForm()

    gotoCasos: () ->
      unless App.user
        @gotoForm()
      Backbone.history.navigate '#comp/selecao-progresso', {trigger: on}

    gotoCalculadoras: () ->
      Backbone.history.navigate '#comp/calculadoras', {trigger: on}

    gotoMaterial: () ->
      Backbone.history.navigate '#comp/materiais', {trigger: on}

    gotoTestes: () ->
      unless App.user
        @gotoForm()
      Backbone.history.navigate '#comp/selecao-testes-progresso', {trigger: on}

    gotoInicialInterdisciplinar: () ->
      unless App.user
        @gotoForm()
      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')))[0]
      unless inicialDaPro
        Backbone.history.navigate "comp/selecao-testes-progresso", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoInicialEnfermagem: () ->
      unless App.user
        @gotoForm()
      proMap = '1': 1, '2': 0, '3': 2
      uPro = proMap['1']
      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro])[0]
      unless inicialDaPro
        Backbone.history.navigate "comp/selecao-testes-progresso", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoInicialMedicina: () ->
      unless App.user
        @gotoForm()
      proMap = '1': 1, '2': 0, '3': 2
      uPro = proMap['2']
      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro])[0]
      unless inicialDaPro
        Backbone.history.navigate "comp/selecao-testes-progresso", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoInicialOdontologia: () ->
      unless App.user
        @gotoForm()
      proMap = '1': 1, '2': 0, '3': 2
      uPro = proMap['3']
      inicialDaPro = App.testes.filter((d)-> /inicial/img.test(d.get('titulo')) && d.get('pro')[uPro])[0]
      unless inicialDaPro
        Backbone.history.navigate "comp/selecao-testes-progresso", {trigger: on}
      _id = inicialDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoFinalInterdisciplinar: () ->
      unless App.user
        @gotoForm()
      console.log(App.masterFinalLockInterdisciplinar(), 'App.masterFinalLockInterdisciplinar')

      if do App.masterFinalLockInterdisciplinar
        return Backbone.history.navigate "comp/home/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')))[0]
      console.log(App.masterFinalLockInterdisciplinar(), 'App.masterFinalLockInterdisciplinar', finalDaPro)
      _id = finalDaPro.get '_id'
      console.log(App.masterFinalLockInterdisciplinar(), 'App.masterFinalLockInterdisciplinar', finalDaPro, _id)
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}


    gotoFinalEnfermagem: () ->
      unless App.user
        @gotoForm()
      proMap = '1': 1, '2': 0, '3': 2, '0': 9
      uPro = proMap['1']

      if do App.masterFinalLockEnfermagem
        return Backbone.history.navigate "comp/home/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')) && d.get('pro')[uPro])[0]
      _id = finalDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoFinalMedicina: () ->
      unless App.user
        @gotoForm()
      proMap = '1': 1, '2': 0, '3': 2, '0': 9
      uPro = proMap['2']

      if do App.masterFinalLockMedicina
        return Backbone.history.navigate "comp/home/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')) && d.get('pro')[uPro])[0]
      _id = finalDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoFinalOdontologia: () ->
      unless App.user
        @gotoForm()
      proMap = '1': 1, '2': 0, '3': 2, '0': 9
      uPro = proMap['3']

      if do App.masterFinalLockOdontologia
        return Backbone.history.navigate "comp/home/teste-bloqueado", {trigger: on}

      finalDaPro = App.testes.filter((d)-> /final/img.test(d.get('titulo')) && d.get('pro')[uPro])[0]
      _id = finalDaPro.get '_id'
      Backbone.history.navigate "comp/teste-progresso/#{_id}", {trigger: on}

    gotoVideo: (e) ->
      ds = $(e.target).attr "data-source"
      unless ds
        ds = $(e.target.parentNode).attr "data-source"

      if ds
        Backbone.history.navigate 'comp/video-player/' + ds, {trigger: on}
      else
        Backbone.history.navigate 'comp/video-player' , {trigger: on}

  HomeLayout