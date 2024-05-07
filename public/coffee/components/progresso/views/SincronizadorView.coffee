define [
], () ->

  class SincronizaProgressoView extends Marionette.ItemView


    initialize: ->

    className: 'col-xs-12 col-sm-6 col-md-6 col-lg-6 inscricoes-item'

    template: '#progresso-sincronizador'

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


    inscreva:()->
      console.log 'inscreva-se'
      App.appRouter.navigate '#comp/cadastro', 'trigger': yes

    paraClick: (evt)->
      do evt.preventDefault
      do evt.stopPropagation

    verificaInscricoes: ()->
      self = @
      hoje = new Date()
      fl_inscrito = false
      if App.user.ofertas
        App.user.ofertas.forEach (o)->
          if o.modulo is App.moduloId and o.conteudo is self.model.get('nucleo').toLowerCase() and o.dt_conclusao
            fl_inscrito = true
            self.model.set 'id_arouca', o.id_arouca
            self.model.set 'url_certificado', o.url_certificado
            self.model.set 'fl_concluinte', true
          else if o.id_arouca is self.model.get('id_arouca') and not self.model.get('fl_concluinte')
            fl_inscrito = true

      if fl_inscrito or self.model.get("fl_concluinte")
        self.$el.find("input[value="+self.model.get('id_arouca')+"]").prop 'checked', true
        self.ui.linkInscricao.hide()
        self.ui.flInscrito.addClass('check-success')
        if self.model.get("fl_concluinte")
          self.ui.flInscrito.html("<div style='margin-left: 7px;padding: 2px;'>Você já concluiu este conteúdo!</div>");
      else
        self.ui.flInscrito.addClass('check-danger')
        self.ui.linkInscricao.show()

    onRender: ->
      # @verificaInscricoes()

  SincronizaProgressoView