define ['backbone', 'backbone.marionette'], (Backbone, Marionette) ->

  class sobreCuidaMain extends Marionette.ItemView

    model: new Backbone.Model

    className: 'item calculadoras sobreCuida'

    template: "#calc-sobrecarga-main"

    ui:
      'resp':'.resposta'
      'item':'.item'
      'next':'#next'
      'li':'li'
      'comeca': '.comeca'
      'prev':'#prev'
      'inicio':'.inicio'
      'ativo':'.item.active'
      'q1':'input:radio[name="optionRadios1"]'
      'q2':'input:radio[name="optionRadios2"]'
      'q3':'input:radio[name="optionRadios3"]'
      'q4':'input:radio[name="optionRadios4"]'
      'q5':'input:radio[name="optionRadios5"]'
      'q6':'input:radio[name="optionRadios6"]'
      'q7':'input:radio[name="optionRadios7"]'
      'resul':'.resultado'

    events:
      'click @ui.next': 'next'
      'click @ui.comeca': 'next'
      'click @ui.prev': 'prev'
      'click @ui.inicio': 'inicio'
      'change @ui.q1, @ui.q2, @ui.q3, @ui.q4, @ui.q5, @ui.q6, @ui.q7': 'changeDados'
      #'change input:radio[name="optionRadios1"]':'changeDados'

    next:()->
      console.log 'next'
      atual = @$el.find('.item.active').data 'indice'
      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'
      if(atual<8)
        atual++
      console.log atual, 'next',@ui.next
      if atual == 8
        @ui.next.attr('disabled','disabled')
      else
        @ui.next.removeAttr('disabled')
      @ui.prev.removeAttr('disabled')
      @$el.find('.item-'+atual).addClass('active').show()
      @$el.find('.p'+atual).addClass('active')
      #$('.item-'+atual)

    prev:()->

      atual = @$el.find('.item.active').data 'indice'
      @$el.find('.p'+atual).removeClass('active')
      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'
      if(atual>0)
        atual--
      console.log atual, 'prev'
      if (atual == 0)
        @ui.prev.attr('disabled','disabled')
      else
        @ui.prev.removeAttr('disabled')
      @ui.next.removeAttr('disabled')
      @$el.find('.item-'+atual).addClass('active').show()


    inicio:()->
      console.log 'inicio'
      @ui.li.removeClass 'active'
      @$el.find('.item.active').hide()
      @$el.find('.item.active').removeClass 'active'
      @ui.prev.attr('disabled','disabled')
      @ui.next.removeAttr('disabled')
      $('.item-0').addClass('active')
      do @$el.find('.item.active').show



    changeDados:()->
      respostas = do @getDados
      console.log 'dados',do @getDados
      valor = @calculaEscore respostas
      console.log valor, 'val'
      if 14<valor && valor<=22
        #moderada
        @ui.resul.html "Moderada"
      else if valor>22
        #grave
        @ui.resul.html "Grave"
      else
        #leve
        @ui.resul.html "Leve"




    getDados:() ->
      [
        do @ui.q1.filter(':checked').val
        do @ui.q2.filter(':checked').val
        do @ui.q3.filter(':checked').val
        do @ui.q4.filter(':checked').val
        do @ui.q5.filter(':checked').val
        do @ui.q6.filter(':checked').val
        do @ui.q7.filter(':checked').val
      ]

    calculaEscore: (d)->
      escore=0
      console.log d, 'd'
      for item of d
        console.log item,'item'
        if(item!=undefined)
          escore=escore+ (parseInt d[item])
      escore



    onRender: (view) ->
      do @ui.item.hide
      do @$el.find('.item.active').show
      @ui.prev.attr('disabled','disabled')
      do @changeDados

  sobreCuidaMain
