define [
  'backbone.marionette'
  './ConteudoItemView'
  './UnidadesCollView'
], (Marionette, ConteudoItemView, UnidadesCollView) ->
  class MenuView extends Marionette.CompositeView
    tagName: 'li'
    className: 'dropdown menu-top-right'
    template: _.template($('#user-progresso-menu-template').html(), {
      interpolate: /\<\@\=(.+?)\@\>/gim
      evaluate: /\<\@([\s\S]+?)\@\>/gim
      escape: /\<\@\-(.+?)\@\>/gim
    })

    initialize: ->
      self = @
      @model = new Backbone.Model({
        ofertas:@collection.map( (m)=>
          conteudo = m.get('conteudo')
          #conteudo = conteudo[0].toUpperCase()+ conteudo.slice(1)
          conteudo
        )
      })

    ui:
      'zero':'.progressoZero'
      'progresso':'.progresso-conteudo'
      'sinc':'.progresso-sincroniza'
      'sincBar':'#progressbar-sinc'
      'btnMenu':'.titulo-block-progresso'
      'sincText':'.text-sinc-progresso'
    events:
      'click @ui.sinc':'sincroniza'

    childView:(arg)->
      self = @
      conteudo = arg.model.get('conteudo')
      unidade = arg.model.get('unidade')
      conteudo = conteudo[0].toUpperCase()+ conteudo.slice(1)
      # console.log(conteudo, 'conteudo')
      g = App.progresso.geral
      sigla = ''
      nr_elegivel = 0
      ofertas = []
      if window.modulo.fl_por_unidade
        unidades = _.where(window.modulo.components, {folder: 'unidade-progresso'})
        #console.log unidades, 'unidade'
        unidades = unidades.filter (u)=>
          return u.unidade 
        .map (o)->
          modelo = {
            'categories': o.categories
            'nome':o.short
            'unidade':o.unidade
            'titulo' : 'Unidade '+o.unidade
            'bloqueada':o.bloqueada
            'nucleo': 'Interdisciplinar_'+o.unidade
            'casos': o.resource.casos
            'corIntro': o.cor
            'corFonte': 'white' 
            'sigla':'<span class=\'pro-tag \' style=\'background: darkgoldenrod!important;\'>U'+o.unidade+'</span>'
          }
          modelo.percCasos = g.unidade[o.unidade]['percCasosConclu'].toFixed(1)
          modelo.percAcertoPreTeste = g.unidade[o.unidade]['percAcertoPreTeste'].toFixed(1)
          modelo.percAcertoPosTeste = g.unidade[o.unidade]['percAcertoPosTeste'].toFixed(1)
          modelo.lockTesteFinal = App["masterFinalLockUnidade"](o.unidade)
          modelo.fl_cert_casos_clinicos = (parseFloat(g.unidade[o.unidade]['percCasosConclu']) >= 70 )
          modelo.fl_cert_pos_teste = (parseFloat(g.unidade[o.unidade]['percAcertoPosTeste']) >= 70 )
          modelo.elegivel = App["masterElegivelCertUnidade"](o.unidade)
          nr_elegivel = if modelo.elegivel then nr_elegivel+1 else nr_elegivel 
          ofertas.push new Backbone.Model(modelo)
        view = new UnidadesCollView({
          collection: new Backbone.Collection(ofertas)
        })
      else
        percAcertoPreTeste = g['percAcertoPreTeste'+conteudo].toFixed(1)
        percCasos = g['percCasosConcluNucleo'+conteudo].toFixed(1)
        percAcertoPosTeste = g['percAcertoPosTeste'+conteudo].toFixed(1)
        titulo = if arg.model.get('tipo') isnt 'integrador' then conteudo else 'Integral'
        elegivel =  App["masterElegivelCert"+conteudo]()
        masterLock = App["masterFinalLock"+conteudo]()
        switch conteudo
          when 'Enfermagem'
            sigla = '<span class=\'pro-tag enf\'>E</span>'
          when 'Medicina'
            sigla = '<span class=\'pro-tag med\'>M</span>'
          when 'Odontologia'
            sigla = '<span class=\'pro-tag odo\'>O</span>'
          when 'Interdisciplinar'
            sigla = '<span class=\'pro-tag \' style=\'background: darkgoldenrod!important;\'>I</span>'
          else
            break
        modelo = new Backbone.Model({
          'elegivel': elegivel
          'categories': []
          'lockTesteFinal': masterLock
          'fl_cert_casos_clinicos': (percCasos >= 70 )
          'fl_cert_pos_teste': (percAcertoPosTeste >= 70 )
          'nucleo': conteudo
          'titulo': titulo
          'sigla':sigla
          'id_arouca': arg.model.get('id_arouca')
          'percAcertoPreTeste': percAcertoPreTeste 
          'percCasos': percCasos 
          'percAcertoPosTeste': percAcertoPosTeste 
        })
        #console.log modelo, 'modelo lateral'
        view = new ConteudoItemView({model:modelo})
      view
      # window.modulo.ofertasAbertas.forEach (o)->
      #     conteudo = o.conteudo
      #     self[o.conteudo].show view

    childViewContainer: '.progresso-conteudo'
    # childView: ConteudoItemView
    sincroniza:()->
      self = @
      # flag_inscrito = @estaInscrito()
      flag_inscrito = true

      self.ui.sincText.removeClass('alert').removeClass('alert-info').removeClass('alert-danger').html('')
      self.ui.sincBar.parent().show()
      setTimeout ()->
        self.ui.sincBar.css('width':'50%')
        if not navigator.onLine or not flag_inscrito or App.progresso.length is 0
          mensagem = 'Ocorreu um erro ao sincronizar seu progresso, verifique sua conexão e tente novamente.'
          # if not flag_inscrito
          #   mensagem = 'Para sincronizar seu processo você precisa estar inscrito em um conteúdo!'
          if App.progresso.length is 0
            mensagem = 'Você ainda não possui progressos, faça alguma atividade e tente novamente!'
          self.ui.sincText.addClass('alert alert-danger').html(mensagem)
          self.ui.sincBar.parent().hide().children().css('width':'10%')
        else
          App.execute 'storeUser', App.user, (dataUser)->
            console.log 'retorno store sincronize', dataUser
            if !dataUser.ok and !dataUser.certificado
              self.ui.sincBar.parent().hide().children().css('width':'10%')
              self.ui.sincText.addClass('alert alert-danger').html('Ocorreu um erro ao sincronizar seu progresso, verifique sua conexão e tente novamente.')
            else
              dt = new Date()
              mensagemErro = 'Progresso sincronizado em: '+ dt.toLocaleString()
              if dataUser.certificado
                mensagemErro = '<ul class="list-group">'
                for c in dataUser.certificado
                  console.log 'uma certificada', c
                  mensagemErro += "<li class='list-group-item'><a class='list-group-item' href='"+c.url_certificado+"'> Clique aqui para obter certificado: "+c.conteudo+"</a></li>"
                mensagemErro += '</ul>'

              setTimeout ()->
                self.ui.sincBar.css('width':'100%')
              , 1000
              setTimeout ()->
                self.ui.sincBar.parent().hide().children().css('width':'10%')
                
                self.ui.sincText.addClass('alert alert-info').html(mensagemErro)
              , 1000
      , 1000

    estaInscrito:()->
      self = @
      hoje = new Date()
      saida = false
      if App.user.ofertas
        App.user.ofertas.forEach (o)->
          if o.modulo is App.moduloId and ( (new Date(o.data_inicio)) <= hoje and (new Date(o.data_fim_matricula)) >= hoje  )
            saida =  true
      saida

    verificaInscricoesConcluintes: ()->
      self = @
      hoje = new Date()
      fl_inscrito = false
      numOfertasAbertas = window.modulo.ofertasAbertas.length
      numOfertasConcluinte = 0
      if App.user.ofertas
        window.modulo.ofertasAbertas.forEach (oa)->
          App.user.ofertas.forEach (o)->
            if o.id_arouca is oa.id_arouca
              fl_inscrito = true
          if not fl_inscrito
            App.user.ofertas.forEach (o)->
              if o.modulo is App.moduloId and o.conteudo is oa.conteudo and o.dt_conclusao
                numOfertasConcluinte++
          if numOfertasAbertas is numOfertasConcluinte
            self.ui.sinc.hide()

    onRender: ->
      @ui.zero.show()
      @ui.progresso.hide()
      @ui.sinc.hide()
      if App.progresso
        if App.progresso.length > 0
          @ui.zero.hide()
          @ui.progresso.show()
          @ui.sinc.show()
      $('.lista-conteudos').css({display:'block'})
      @verificaInscricoesConcluintes()

