define ['backbone', 'backbone.marionette'], (Backbone, Marionette) ->

  class ImcMainView extends Marionette.ItemView

    model: new Backbone.Model

    className: 'item calculadoras imc'

    template: '#odonto-calc-main-view'

    ui:
      'peso': '#pesoId'
      'ehCri': '.ehIdoso'
      'descricao':'.descricao'
      'resultado':'.resultado'
      'resposta':'.condutaBox'
      'faixa':'.faixa'
      'min':'.idealMenor'
      'max':'.idealMaior'

    events:
      # 'change @ui.peso, @ui.altura': 'changeDados'
      'change @ui.ehIdoso': 'changeDados'
      'blur @ui.peso, @ui.altura': 'changeDados'

    changeDados:()->
      dados = do @getDados
      console.log dados
      faixa = if dados.ehIdoso then 'idoso' else 'adulto'
      tab = @tabela[faixa]
      estado = @calculaEscore dados, tab
      resultado = estado.indice
      if resultado
        @ui.descricao.text resultado.descricao
        @ui.resultado.text "#{estado.valor.replace '.', ','}"
        @ui.altuRes.text "#{do @ui.altura.val} m  #{do @ui.peso.val} Kg"
        @ui.faixa.text "#{do faixa.slice(0,1).toUpperCase}#{faixa.slice 1}"
        @ui.min.text estado.min.replace('.', ',') + ' Kg'
        @ui.max.text estado.max.replace('.', ',') + ' Kg'
        do @ui.resposta.show
      else
        do @ui.resposta.hide

    getDados:() ->
      r =
        peso: @limpaNum @ui.peso.val() or '0', 0, 250
        altura: @limpaNum @ui.altura.val() or '0', 0, 3
        ehIdoso: @ui.ehIdoso.prop 'checked'

      @ui.peso.val r.peso.replace('.', ',') unless r.peso is '0'
      @ui.altura.val r.altura.replace '.', ',' unless r.peso is '0'

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

    normalTabela: (t) ->
      for i in t
        if i.normal then return i.normal

    calculaEscore: (d, t)->
      peso = parseFloat d.peso
      alt = parseFloat d.altura
      return false unless peso and alt
      imc = ( peso / Math.pow alt, 2 ).toFixed 2
      for r in t
        if r.range(imc)
          indice = r
          break
      normal = @normalTabela t

      idealMin =( parseFloat normal[0] * Math.pow alt, 2 ).toFixed 2
      idealMax =( parseFloat normal[1] * Math.pow alt, 2 ).toFixed 2

      valor: imc, indice: indice, min:idealMin, max:idealMax

    tabela:
      adulto:[
        range: (imc)-> imc < 18.5
        descricao: 'Baixo peso'
      ,
        normal: [18.5, 25]
        range: (imc) -> 25 > imc >= 18.5
        descricao: 'Peso normal'
      ,
        range: (imc) -> 30 > imc >= 25
        descricao: 'Excesso de peso'
      ,
        range: (imc) -> 35 > imc >= 30
        descricao: 'Obesidade de Classe 1'
      ,
        range: (imc) -> 40 > imc >= 35
        descricao: 'Obesidade de Classe 2'
      ,
        range: (imc) -> 40 < imc
        descricao: 'Obesidade de Classe 3'
      ]
      idoso:[
        range: (imc) -> imc < 22
        descricao: 'Baixo peso'
      ,
        normal: [22,27]
        range: (imc) -> 27 > imc >= 22
        descricao: 'Adequado ou eutrófico'
      ,
        range: (imc) -> 27 < imc
        descricao: 'Sobrepeso'
      ]

    onRender: (view) ->
      do @ui.resposta.hide
      setTimeout (-> do $.material.init), 50

  ImcMainView







