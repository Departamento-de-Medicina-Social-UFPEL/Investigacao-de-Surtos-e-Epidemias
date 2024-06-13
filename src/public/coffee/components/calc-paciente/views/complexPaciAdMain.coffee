define ['backbone', 'backbone.marionette'], (Backbone, Marionette) ->

  class complexidadePacienteAdMainView extends Marionette.ItemView

    model: new Backbone.Model

    className: 'item calculadoras complexidadePacienteAd'

    template: '#calc-paciente-main'

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
      'q6':'input:radio[name="optionRadios6"]'
      'q7':'input:radio[name="optionRadios7"]'
      'q8':'input:radio[name="optionRadios8"]'
      'q9':'input:radio[name="optionRadios9"]'

    events:
      'click @ui.next': 'next'
      'click @ui.prev': 'prev'
      'click @ui.inicio': 'inicio'
      'change @ui.q1, @ui.q2, @ui.q3, @ui.q4, @ui.q5, @ui.q6, @ui.q7, @ui.q8, @ui.q9': 'changeDados'

    next:()->
      console.log 'next'
      atual = @$el.find('.item.active').data 'indice'

      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'
      if(atual<10)
        atual++
      console.log atual, 'next',@ui.next
      if atual == 10
        @ui.next.attr('disabled','disabled')
      else
        @ui.next.removeAttr('disabled')
      @ui.prev.removeAttr('disabled')
      @$el.find('.item-'+atual).addClass('active').show()
      @$el.find('.p'+atual).addClass('active')
      #$('.item-'+atual)

    prev:()->

      atual = @$el.find('.item.active').data 'indice'
      console.log 'prev', atual

      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'
      if(atual>1)
        @$el.find('.p'+atual).removeClass('active')
        atual--

      console.log atual, 'prev'
      if (atual == '1')
        @ui.prev.attr('disabled','disabled')
      else
        @ui.prev.removeAttr('disabled')
      @ui.next.removeAttr('disabled')
      @$el.find('.item-'+atual).addClass('active').show()

    inicio:()->
      console.log 'inicio'
      @ui.li.removeClass 'active'
      @$el.find('.p1').addClass('active')
      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'
      @ui.prev.attr('disabled','disabled')
      @ui.next.removeAttr('disabled')
      $('.item-1').addClass('active')
      do @$el.find('.item.active').show

    changeDados:()->
      respostas = do @getDados
      console.log 'dados',do @getDados
      nivel = @calculaEscore respostas
      console.log 'nivel',nivel
      tab = @tabela
      console.log tab,'tab'
      conduta = _.find tab, (item) ->
        item.nivel == nivel
      console.log conduta,'conduta', conduta.descricao
      @ui.resp.html conduta.descricao
      do @ui.processo.empty
      for item of conduta.processos
        @ui.processo.append "<li class='list-group-item'>"+conduta.processos[item]+"</li>"

    getDados:() ->
      [
        do @ui.q1.filter(':checked').val
        do @ui.q2.filter(':checked').val
        do @ui.q3.filter(':checked').val
        do @ui.q4.filter(':checked').val
        do @ui.q5.filter(':checked').val
        do @ui.q6.filter(':checked').val
        do @ui.q7.filter(':checked').val
        do @ui.q8.filter(':checked').val
        do @ui.q9.filter(':checked').val
      ]

    calculaEscore: (d)->
      #
      escore=0
      console.log d, 'd'
      for item of d
        console.log item,'item'
        if(item!=undefined)
          escore=escore+ (parseInt d[item])
      escore

    tabela:[
      nivel:0
      descricao:"Nível 0"
      processos:[
        "Paciente com sua capacidade funcional preservada e baixo risco de agravos à saúde, sem indicação para assistência domiciliar."
        " Acompanhamento habitual da ESF."
      ]
    ,
      nivel:1
      descricao:"Nível 1"
      processos:[
        "Visita mensal de ACS."
        "Visita da enfermagem trimestral."
        "Atendimento médico semestral (ou pelo tempo máximo pertinente à prescrição médica) e em casos de intercorrências."
      ]
    ,
      nivel:2
      descricao:"Nível 2"
      processos:[
        "Visita mensal de ACS."
        "Visita da enfermagem bimestral e atendimento em casos de intercorrências."
        "Atendimento médico quadrimestral e atendimento em casos de intercorrências."
        "Atendimento do técnico de enfermagem ou enfermeiro quando indicado e prescrito pela equipe (exemplo: cobertura para úlceras de membros).
Acionar a Emad–1 em casos extremos, quando a necessidade de atenção superar a capacidade de oferta da ESF."
      ]
    ,
      nivel:3
      descricao:"Nível 3"
      processos:[
        "Visita mensal de ACS."
        "Visita da enfermagem mensal e atendimento em casos de intercorrências."
        "Atendimento médico bimestral e atendimento em casos de intercorrências."
        "Atendimento do técnico de enfermagem ou enfermeiro quando indicado e prescrito pela equipe."
        "Atendimento do Serviço Social de suporte se necessário."
        "Acionar a Emad–1 em caso da necessidade de atenção, superar a capacidade de oferta da ESF."
      ]
    ]

    onRender: (view) ->
      do @ui.item.hide
      do @$el.find('.item.active').show
      @ui.prev.attr('disabled','disabled')
      @$el.find('.p1').addClass('active')
      do @changeDados


  complexidadePacienteAdMainView
