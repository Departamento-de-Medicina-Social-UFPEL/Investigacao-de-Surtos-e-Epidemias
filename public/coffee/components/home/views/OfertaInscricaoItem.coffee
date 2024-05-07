define [
], () ->

  class OfertaInscricaoView extends Marionette.ItemView


    initialize: ->

    className: 'col-xs-12 col-sm-6 col-md-6 col-lg-6 inscricoes-item'

    template: '#home-oferta-inscricao'

    ui:
      'checkInscrito': '#check-box-casos-clinicos'
      'linkInscricao': '.link-inscricao'
      'flInscrito': '#fl-inscrito'
      'alertInscricao': '#alert-inscricao'
      'alertCertificado': '#alert-certificado'
      'alertCertificar': '#alert-certificar'

    events:
      'change @ui.checkInscrito': 'trocaCor'
      'click @ui.checkInscrito': 'paraClick'
      'click @ui.flInscrito': 'inscreva'
      'click @ui.alertCertificado':'irProgresso'

    inscreva:()->
      console.log 'inscreva-se'
      if not @model.get("fl_concluinte")
        App.appRouter.navigate '#comp/cadastro', 'trigger': yes
    
    irProgresso:()->
      if @model.get("fl_concluinte")
        App.appRouter.navigate '#comp/progresso', 'trigger': yes

    trocaCor: (evt)->
      ckVal = $(evt.target).prop("checked")
      modiNovo = if ckVal then "success" else "danger"
      modiOld = if not ckVal then "success" else "danger"
      $(evt.target).parent().parent().removeClass('check-'+modiOld).addClass('check-'+modiNovo)

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
          self.ui.flInscrito.html("<div style='margin-left: 7px;padding: 3px;'>Já certificado!</div>")
          self.ui.alertCertificado.removeClass('hide')
        else
          self.ui.alertCertificar.removeClass('hide')
      else
        self.ui.flInscrito.addClass('check-danger')
        self.ui.linkInscricao.show()
        self.ui.alertInscricao.removeClass('hide')
    
    onRender: ->
      @$el.addClass(@model.get('nucleo').toLowerCase())
      @ui.checkInscrito.prop("checked", @model.get('fl_inscrito'))
      @verificaInscricoes()

  OfertaInscricaoView