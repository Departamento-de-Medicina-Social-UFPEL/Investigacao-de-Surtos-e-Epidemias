define [
  './ConteudoItemView'
  './UnidadesCollView'
  './ConteudosCollView'
  './SincronizadorView'
], (ConteudoView, UnidadesCollView, ConteudosCollView, SincronizadorView) ->

  class ProgressoLayout extends Marionette.LayoutView


    initialize: ->

    className: 'progresso container'

    template: '#progresso-main'

    regions:
      'medicina': '#medicina'
      'enfermagem': '#enfermagem'
      'odontologia': '#odontologia'
      'interdisciplinar': '#interdisciplinar'
      'unidades': '#unidades'

    ui:
      'sinc':'.btn-sinc'
      'sincBar':'#progressbar-sinc'
      'btnMenu':'.titulo-block-progresso'
      'sincText':'.text-sinc-progresso'

    events:
      'click @ui.sinc':'sincroniza'

    sincroniza:()->
      console.log 'sincroniza'
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
              if not dataUser.msg
                self.ui.sincText.addClass('alert alert-danger').html('Ocorreu um erro ao sincronizar seu progresso, verifique sua conexão e tente novamente.')
              else
                self.ui.sincText.addClass('alert alert-danger').html(dataUser.msg)
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

    onRender: ->
        self = @
        g = App.progresso.geral
        ofertas = []
        integrador = {}
        fl_integrador = window.modulo.fl_por_unidade
        nr_elegivel = 0
        if fl_integrador
          unidades = _.where(window.modulo.components, {folder: 'unidade-progresso'})
          unidades = unidades.filter (u)=>
            return u.unidade 
          .map (o)->
            modelo = {
              'nome':o.short
              'unidade':o.unidade
              'bloqueada':o.bloqueada
              'casos': o.resource.casos
              'nucleo': 'Interdisciplinar'
              'cor':o.cor
            }
            modelo.percCasos = g.unidade[o.unidade]['percCasosConclu'].toFixed(1)
            modelo.percAcertoPreTeste = g.unidade[o.unidade]['percAcertoPreTeste'].toFixed(1)
            modelo.percAcertoPosTeste = g.unidade[o.unidade]['percAcertoPosTeste'].toFixed(1)
            modelo.lockTesteFinal = App["masterFinalLockUnidade"](o.unidade)
            modelo.fl_cert_casos_clinicos = (parseFloat(g.unidade[o.unidade]['percCasosConclu']) >= 70 ) or (modelo.casos.length is 0)
            modelo.fl_cert_pos_teste = (parseFloat(g.unidade[o.unidade]['percAcertoPosTeste']) >= 70 )
            modelo.elegivel = App["masterElegivelCertUnidade"](o.unidade)
            nr_elegivel = if modelo.elegivel then nr_elegivel+1 else nr_elegivel 
            ofertas.push new Backbone.Model(modelo)
          self['unidades'].show new UnidadesCollView({
            collection: new Backbone.Collection(ofertas)
          })
        else
          window.modulo.ofertasAbertas.forEach (o)->
            conteudo = o.conteudo
            conteudo = conteudo[0].toUpperCase()+ conteudo.slice(1)
            console.log o, 'oferta'
            modelo = {
              'nome':o.nome
              'tipo':o.tipo 
              'unidade':o.unidade
              'nucleo': conteudo
              'id_arouca': o.id_arouca
            }
            modelo.tipo = 'nucleo'
            modelo.percCasos = g['percCasosConcluNucleo'+conteudo].toFixed(1)
            modelo.percAcertoPreTeste = g['percAcertoPreTeste'+conteudo].toFixed(1)
            modelo.percAcertoPosTeste = g['percAcertoPosTeste'+conteudo].toFixed(1)
            modelo.elegivel = App["masterElegivelCert"+conteudo]()
            console.log "masElegivelCert"+conteudo, modelo.elegivel
            modelo.lockTesteFinal = App["masterFinalLock"+conteudo]()
            modelo.fl_cert_casos_clinicos = (parseFloat(g["percCasosConcluNucleo"+conteudo]) >= 70 )
            modelo.fl_cert_pos_teste = (parseFloat(g["percAcertoPosTeste"+conteudo]) >= 70 )
            self[o.conteudo].show new ConteudoView({
              model: new Backbone.Model(modelo)
            })
        if fl_integrador
          oferta = new Backbone.Model(window.modulo.ofertasAbertas[0])
          oferta.set('nucleo', 'Interdisciplinar')
          oferta.set('tipo', 'unidade')
          oferta.set('elegivel', if nr_elegivel is unidades.length then true else false)
          oferta.set('lockTesteFinal', false)
          oferta.set('fl_cert_casos_clinicos', false)
          oferta.set('fl_cert_pos_teste', false)
          view = new ConteudoView({
            model: oferta
          })
          self['interdisciplinar'].show view
        #console.log ofertas, oferta, 'oferta'

  ProgressoLayout