define ['backbone', 'backbone.marionette', 'jknob'], (Backbone, Marionette) ->

  class Cbr65MainView extends Marionette.ItemView

    model: new Backbone.Model

    className: 'item calculadoras curb65'

    template: '#calc-crb65-main-view'

    ui:
      'ureia': '#ureia'
      'ureiacont': '#divUreia'
      'semureia': '#semureia'
      'confusao': '#confusao'
      'respiratoria': '#respiratoria'
      'pressao': '#pressao'
      'idade': '#idade'
      'resultado': 'input.grafResult'
      'mortalidade': '.mortalidade'
      'descricao': '.descricao'
      'conduta': '.conduta'
      'nomeCalc': 'h3.titulo-calc .nomeCalc'
      'escoreBox': '.escoreBox'
      'condutaBox': '.condutaBox'

    events:
      'change @ui.semureia': 'changeSemUreia'
      'change @ui.ureia, @ui.confusao, @ui.respiratoria, @ui.pressao, @ui.idade': 'changeDados'

    changeSemUreia:(evt)->
      max = 5
      if !@ui.semureia.prop 'checked'
        @ui.ureia.removeAttr 'disabled'
        tit = 'CURB-65'
        opa = 1
      else
        @ui.ureia.attr 'disabled', true
        max = 4
        opa = .5

      @ui.ureiacont.css opacity: opa
      @ui.resultado.trigger 'configure', max: max

      do @changeDados

    changeDados:()->
      dados = do @getDados
      pontuacao = @calculaEscore(dados)
      # console.log dados.semu, @tabela
      tab = @tabela.curb
      tab = @tabela.crb if dados.semu
      # console.log tab
      resultado = _(tab).find (item) ->
        item.pontos.indexOf(pontuacao) != -1
      @ui.resultado.val(pontuacao).trigger 'change'
      @ui.descricao.text resultado.descricao
      @ui.mortalidade.text resultado.mortalidade + '%'
      @ui.conduta.text resultado.conduta
      do @ui.escoreBox.fadeIn
      do @ui.condutaBox.fadeIn
      console.log dados, pontuacao, tab, resultado

    getDados:() ->
      c: @ui.confusao.prop 'checked'
      u: @ui.ureia.prop 'checked'
      r: @ui.respiratoria.prop 'checked'
      b: @ui.pressao.prop 'checked'
      i: @ui.idade.prop 'checked'
      semu: @ui.semureia.prop 'checked'

    calculaEscore:(d)->
      escore = if d.semu then [d.c, d.r, d.b, d.i] else [d.c, d.u, d.r, d.b, d.i]
      escore = escore.reduce((mem, val) ->
        mem = mem + 1 if val is on
        mem
      ,0)
      escore

    tabela:
      crb:[
        pontos: [0]
        descricao: 'Mortalidade baixa'
        mortalidade: 1.2
        conduta: 'Provável tratamento ambulatorial'
      ,
        pontos: [1,2]
        descricao: 'Mortalidade intermediária'
        mortalidade: 8.15
        conduta: 'Avaliar tratamento hospitalar'
      ,
        pontos: [3,4]
        descricao: 'Mortalidade alta'
        mortalidade: 31
        conduta: 'Hospitalização urgente'
      ]
      curb:[
        pontos: [0,1]
        descricao: 'Mortalidade baixa'
        mortalidade: 1.5
        conduta: 'Provável tratamento ambulatorial'
      ,
        pontos: [2]
        descricao: 'Mortalidade intermediária'
        mortalidade: 9.2
        conduta: 'Avaliar tratamento hospitalar'
      ,
        pontos: [3,4,5]
        descricao: 'Mortalidade alta'
        mortalidade: 22
        conduta: 'Hospitalização urgente'
      ]

    setKnob:(max=5) ->
      @ui.resultado.knob
        width: "150"
        # displayprevious: "true"
        lineCap: 'round'
        inline: true
        # fgColor: "#ffec03"
        bgColor: "#f1f1f1"
        inputColor: "#444"
        max: max
        # skin: "tron"
        thickness: ".2"
        readOnly: true
        format: (value) ->
          console.log value
          "#{value}/#{max}"

    onRender: (view) ->
      do @setKnob
      do @ui.escoreBox.hide
      do @ui.condutaBox.hide



  Cbr65MainView