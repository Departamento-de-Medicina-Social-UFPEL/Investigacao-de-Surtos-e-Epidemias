define ['backbone', 'backbone.marionette'], (Backbone, Marionette) ->

  class LdlMainView extends Marionette.ItemView

    className: 'item calculadoras colesterol'

    template: '#ldl-main-view'

    ui:
      'hd': '#hdlId'
      'ct':'#ctId'
      'tg':'#tgId'
      'resultado':'.resultado'
      'resposta':'.valor'

    events:
      'change @ui.hd': 'changeDados'
      'change @ui.tg': 'changeDados'
      'change @ui.ct': 'changeDados'

    changeDados:()->
      dados = do @getDados
      valor = @calculaEscore dados
      if valor
        @ui.resposta.text valor
        do @ui.resultado.show
      else
        do @ui.resultado.hide

    getDados:() ->
      r =
        ct: @limpaNum @ui.ct.val() or '0', 0, 1000
        tg: @limpaNum @ui.tg.val() or '0', 0, 1000
        hd: @limpaNum @ui.hd.val() or '0', 0, 1000

      @ui.ct.val r.ct.replace '.', ','
      @ui.tg.val r.tg.replace '.', ','
      @ui.hd.val r.hd.replace '.', ','

      r

    limpaNum: (n, min, max, a = 0)->
      sohOPrim = ()-> a++; if a is 1 then '.' else ''

      n = n.replace /\s/img, ''
      n = n.replace ',', '.'
      n = n.replace '.', sohOPrim()
      n = parseFloat n
      switch yes
        when n <= min then min + ''
        when n >= max then max + ''
        else n + ''


    calculaEscore: (d)->
      ct = parseFloat d.ct
      tg = parseFloat d.tg
      hd = parseFloat d.hd
      return false unless ct and tg and hd
      colesterol = (ct - hd - ( tg / 5 )).toFixed 2

    onRender: (view) ->
      do @ui.resultado.hide
      #do @ui.manejo.hide

  LdlMainView
