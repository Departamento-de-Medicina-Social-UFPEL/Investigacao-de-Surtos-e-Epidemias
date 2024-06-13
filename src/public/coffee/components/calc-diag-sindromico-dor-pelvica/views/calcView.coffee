define ['backbone', 'backbone.marionette'], (Backbone, Marionette) ->

  class calcDiagSindromicoDorPelvicaMainView extends Marionette.ItemView

    model: new Backbone.Model

    className: 'item calculadoras diag-sindromico-dor-pelvica'#calcDiagSindromicoDorPelvica'

    template: '#calc-diag-sindromico-dor-pelvica-main'

    ui:
      'resp':'.resultado'
      'item':'.item'
      'next':'#next'
      'prev':'#prev'
      'li':'li'
      'inicio':'.inicio'
      'processo':'.processoTrabalho'
      'q1':'input:radio[name="optionRadios1"]'
      'q2':'input:radio[name="optionRadios2"]'
      'q3':'input:radio[name="optionRadios3"]'
      'q4':'input:radio[name="optionRadios4"]'
      'q5':'input:radio[name="optionRadios5"]'

    events:
      'click @ui.next': 'next'
      'click @ui.prev': 'prev'
      'click @ui.inicio': 'inicio'
      'change @ui.q1, @ui.q2, @ui.q3, @ui.q4, @ui.q5': 'changeDados'

    initialize:()->
      this.atual = 0
      this.indiceResultado = 6

    next:()->
      if @ui.next.hasClass('disabled')
        return
      this.atual = @$el.find('.item.active').data 'indice'

      if this.atual < this.indiceResultado
        this.atual++

      if this.atual == this.indiceResultado
        @ui.next.addClass('disabled')
      else
        @ui.next.removeClass('disabled')
      @ui.prev.removeClass('disabled')
      @trocaPara(this.atual)
      
      @changeDados()

    trocaPara:(indice)->
      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'
      if indice is this.indiceResultado
        @ui.prev.addClass('disabled')
        @ui.next.addClass('disabled')
      console.log 'trocaPara', indice
      @$el.find('.item-'+indice).addClass('active').show()
      @$el.find('.p'+indice).addClass('active')

    prev:()->
      if @ui.next.hasClass('disabled')
        return
      this.atual = @$el.find('.item.active').data 'indice'

      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'
      if this.atual > 1
        @$el.find('.p'+this.atual).removeClass('active')
        this.atual--

      if this.atual == '1'
        @ui.prev.addClass('disabled')
      else
        @ui.prev.removeClass('disabled')
      @ui.next.removeClass('disabled')
      @$el.find('.item-'+this.atual).addClass('active').show()

    inicio:()->
      console.log 'inicio'
      @ui.li.removeClass 'active'
      @$el.find('.p1').addClass('active')
      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'
      @ui.prev.addClass('disabled')
      @ui.next.removeClass('disabled')
      $('.item-1').addClass('active')
      do @$el.find('.item.active').show

    changeDados:()->
      respostas = do @getDados
      nivel = @calculaEscore respostas
      tab = @tabela
      conduta = _.find tab, (item) ->
        item.nivel == nivel
      @ui.resp.html conduta.descricao

    getDados:() ->
      [
        do @ui.q1.filter(':checked').val
        do @ui.q2.filter(':checked').val
        do @ui.q3.filter(':checked').val
        do @ui.q4.filter(':checked').val
        do @ui.q5.filter(':checked').val
      ]

    calculaEscore: (d)->
      #
      escore = 0
      console.log d, 'd', this.atual
      if d[0] is '1' and this.atual is 2
        escore = 0
        @trocaPara(this.indiceResultado)
      if d[0] is '2' and d[1] is '1' and this.atual is 3
        escore = 0
        @trocaPara(this.indiceResultado)
      if d[0] is '2' and d[1] is '2' and d[2] is '1' and d[3] is '1' and this.atual is 5
        escore = 0
        @trocaPara(this.indiceResultado)
      if d[0] is '2' and d[1] is '2' and d[2] is '1' and d[3] is '2' and d[4] is '2' and this.atual is 6
        escore = 0
        @trocaPara(this.indiceResultado)

      if d[0] is '2' and d[1] is '2' and d[2] is '2' and this.atual is 4
        escore = 1
        @trocaPara(this.indiceResultado)

      if d[0] is '2' and d[1] is '2' and d[2] is '1' and d[3] is '2' and d[4] is '1' and this.atual is 6
        escore = 2
        @trocaPara(this.indiceResultado)

      console.log escore, 'escore'

      escore

    tabela:[
      nivel:0
      descricao:"Referenciar"
      processos:[]
    ,
      nivel:1
      descricao:"Investigar outras causas"
      processos:[]
    ,
      nivel:2
      descricao:"Manter conduta, Enfatizar adesão ao tratamento"
      processos:[]
    ]

    onRender: (view) ->
      do @ui.item.hide
      do @$el.find('.item.active').show
      @ui.prev.addClass('disabled')
      @$el.find('.p1').addClass('active')
      do @changeDados


  calcDiagSindromicoDorPelvicaMainView
