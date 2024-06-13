define ['backbone', 'backbone.marionette'], (Backbone, Marionette) ->

  class OdontoMainView extends Marionette.ItemView

    model: new Backbone.Model

    className: 'item calculadoras odonto'

    template: '#odonto-calc-main-view'

    ui:
      'peso': '#pesoId'
      'ehCri': '.ehCri'
      'descricao':'.descricao'
      'resultado':'.resultado'
      'resposta':'.condutaBox'
      'faixa':'.faixa'
      'res_amo':'.res_amo'
      'res_eri':'.res_eri'
      'res_cef':'.res_cef'
      'res_par':'.res_par'
      'res_dip':'.res_dip'
      'res_ibu':'.res_ibu'


    events:
      # 'change @ui.peso, @ui.altura': 'changeDados'
      'change @ui.ehCri': 'changeDados'
      'blur @ui.peso, @ui.altura': 'changeDados'

    changeDados:()->
      dados = do @getDados
      faixa = if dados.ehCri then 'fx1' else 'fx2'            

      peso = parseFloat dados.peso
      pes3 = ( peso / 3 ).toFixed 0
      pes4 = ( peso / 4 ).toFixed 0      
       
      para = peso
      pibu = peso     
      if dados.ehCri then  pesg = ( peso * 0.6 ).toFixed 0 else  pesg = peso    
      if pesg>35 then pesg = 35

      if pes4>10 then pes4 = 10
      if pes3>10 then pes3 = 10
      if para>35 then para = 35
      if pibu>40 then pibu = 40
            

      #estado = @calculaEscore dados, faixa
      #resultado = estado.indice
      console.log pes3

      if peso
        @ui.res_amo.text 'Posologia ' + pes3 + 'ml de 8/8h (3xdia)'
        @ui.res_eri.text 'Posologia ' + pes4 + 'ml de 6/6h (4xdia)'
        @ui.res_cef.text 'Posologia ' + pes4 + 'ml de 6/6h (4xdia)'
        @ui.res_par.text 'Posologia ' + para + ' gotas de 6/6h (4xdia)'
        @ui.res_dip.text 'Posologia ' + pesg + ' gotas de 6/6h (4xdia)'
        @ui.res_ibu.text 'Posologia ' + pibu + ' gotas de 6/6h (4xdia)'
        do @ui.resposta.show
      else
        do @ui.resposta.hide

    getDados:() ->
      r = 
        peso: @limpaNum @ui.peso.val() or '0', 0, 250               
        ehCri: @ui.ehCri.prop 'checked'    

      @ui.peso.val r.peso.replace('.', ',') unless r.peso is '0'         
      r

    limpaNum: (n, min, max, a = 0)->

      sohOPrim = ()-> a++; if a is 1 then '.' else ''

      n = n.replace /\s/img, ''
      n = n.replace ',', '.'
      n = n.replace '.', sohOPrim
      n = parseFloat n
      if _.isNaN n
        return ''
      switch yes
        when n <= min then min + ''
        when n >= max
          if (n * 100) > max
            n = (n / 100)
            if (n) <= max then n + ''
            else max + ''
          else
            max + ''
        else n + ''


    calculaEscore: (d, t)->

   
    onRender: (view) ->
      do @ui.resposta.hide
      setTimeout (-> do $.material.init), 50

  OdontoMainView







