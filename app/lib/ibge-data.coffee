
async = require 'async'
scrap = require 'scrap'
_ = require 'lodash'
util = require 'util'
estados = require './uf-codes'


final = []

async.eachSeries(
  estados
  (estado, next)->
    faixasEstado = {}
    _.extend faixasEstado, estado
    delete faixasEstado.id
    faixasEstado.faixas = []
    # console.log arguments

    base = 'http://www.censo2010.ibge.gov.br/sinopse/webservice/frm_piramide.php?'
    dataStr = ''
    data = wmaxbarra: 150, cormulher: 'd8fe35', corhomem: '41c300', codigo: estado.id
    dataStr += "#{key}=#{val}&" for key, val of data
    url = "#{base}#{dataStr}"
    scrap url, (err, $, code, html, resp)->
      faixas = $ 'tr'
      faixas.each (idx, faixa) ->
        el = $(faixa)
        return null unless el.children().length is 5
        nome = el.find('.grupo').text()
        tH = el.find('td.vHomem').text()
        tM = el.find('td.vMulher').text()
        nH = Number tH.replace /\./gim, ''
        nM = Number tM.replace /\./gim, ""
        nT = nH + nM
        min = max = ''

        intervalo = nome.match(/\d{1,3}/mg).map (d) -> Number(d)

        faixasEstado.faixas.push
          'nome': nome
          'intervalo': intervalo
          'homens': nH
          'mulheres': nM
          'total': nT

      _.extend(faixasEstado, {
        'homens': faixasEstado.faixas.reduce(
          (memo, fx)-> memo += fx.homens
        ,0)


        'mulheres': faixasEstado.faixas.reduce(
          (memo, fx)-> memo += fx.mulheres
        ,0)

        'total': faixasEstado.faixas.reduce(
          (memo, fx)-> memo += fx.total
        ,0)

      })

      final.push faixasEstado

      do next

  ->
    console.log util.inspect final, depth: 4, color: true

    console.log 'finito'
)



