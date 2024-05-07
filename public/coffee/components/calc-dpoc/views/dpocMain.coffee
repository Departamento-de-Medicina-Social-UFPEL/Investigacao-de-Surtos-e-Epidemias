define ['backbone', 'backbone.marionette'], (Backbone, Marionette) ->

  class DpocMainView extends Marionette.ItemView

    model: new Backbone.Model

    className: 'item calculadoras dpoc'

    template: "#calc-dpoc-main"

    ui:
      'razao': '#razaoVef1Cvf'
      'temIRC':'#insuficieciaRespCronica'
      'radios':'input:radio[name="optionRadios"]'
      'gravidade':'.gravidade'
      'listaManejo':'.list-group'
      'resposta':'.condutaBox'
      'manejo':'.manejo'

    events:
      'change @ui.razao, @ui.temIRC, @ui.radios': 'changeDados'

    changeDados:()->
      dados = do @getDados
      estado = @calculaEscore dados
      tab = @tabela
      conduta = _(tab).find (item) ->
        item.estado.indexOf(estado) != -1
      if conduta
        @ui.gravidade.text conduta.gravidade
        template = (item)->
          "<li class='list-group-item'>#{item}</li>"
        @ui.listaManejo.empty()
        .append conduta.manejo.map(template).join ''
        do @ui.manejo.show unless conduta.manejo.length < 0
        do @ui.resposta.show
      else
        do @ui.resposta.hide


    getDados:() ->
      razao: @ui.razao.prop 'checked'
      respiratoria: @ui.temIRC.prop 'checked'
      radio: do @ui.radios.filter(':checked').val

    calculaEscore: (d)->
      gravidade = switch d.radio
         when "1" then 'I'
         when "2" then 'II'
         when "3"
          if d.respiratoria then 'IV' else 'III'
         when "4" then 'V'
         else '0'

    tabela:[
      gravidade:'Não configura DPOC'
      estado:'0'
      manejo:['Não requer para esta doença']
    ,
      gravidade:'Leve'
      estado:'I'
      manejo:[
        "Beta2-agonista de curta duração"
        "e/ou ipratrópio, quando necessário"
      ]
    ,
      gravidade:'Moderada'
      estado:'II'
      manejo:[
        "Reabilitação pulmonar"
        "<b>Sintomas eventuais:</b> Beta2- agonista de curta duração e/ou ipratrópio, quando necessário"
        "<b>Sintomas persistentes:</b> Beta2-agonista de longa duração e/ou tiotrópio"
      ]
    ,
      gravidade:'Grave'
      estado:'III'
      manejo:[
        "Reabilitação Pulmonar"
        "Beta2-agonista de longa duração e tiotrópio"
        "Se persistirem sintomas acrescentar xantina de longa duração"
        "Corticoide inalatório se exacerbações frequentes (>= 2 exacerbações ao ano)"
      ]
    ,
      gravidade:'Muito grave'
      estado:'IV'
      manejo:[
        "Reabilitação Pulmonar"
        "Beta2-agonista de longa duração e tiotrópio"
        "Se persistirem sintomas acrescentar xantina de longa duração"
        "Corticoide inalatório se exacerbações frequentes (>= 2 exacerbações ao ano)"
        "Oxigenoterapia"
        "Estudar indicações cirúrgicas para o tratamento do enfisema (cirurgia redutora de volume pulmonar, bulectomia ou transplante pulmonar)"
      ]
    ]

    onRender: (view) ->
      do @ui.resposta.hide
      do @ui.manejo.hide

  DpocMainView
