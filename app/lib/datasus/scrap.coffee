
async = require 'async'
scrap = require 'scrap'
_ = require 'lodash'
util = require 'util'
fs = require 'fs'

estados = require '../uf-codes'

final = []

async.eachSeries(
  estados
  (estado, next)->

    faixasEstado = {}
    _.extend faixasEstado, estado
    delete faixasEstado.id
    faixasEstado.faixas = []
    sigla = estado.sigla.toUpperCase()
    # console.log sigla
    url = "http://tabnet.datasus.gov.br/cgi/tabcgi.exe?popestim/cnv/pop#{sigla}.def"
    # console.log url
    scrap {
      url: url
      method: 'POST'
      form: "Linha=Faixa_Et%E1ria&Coluna=Sexo&Incremento=Popula%E7%E3o_residente&Arquivos=pop#{sigla.toLowerCase()}12.dbf&pesqmes1=Digite+o+texto+e+ache+f%E1cil&SMunic%EDpio=TODAS_AS_CATEGORIAS__&pesqmes2=Digite+o+texto+e+ache+f%E1cil&SComiss%E3o_Intergestora_Regional=TODAS_AS_CATEGORIAS__&pesqmes3=Digite+o+texto+e+ache+f%E1cil&SMicrorregi%E3o_IBGE=TODAS_AS_CATEGORIAS__&pesqmes4=Digite+o+texto+e+ache+f%E1cil&SRegional_de_Sa%FAde=TODAS_AS_CATEGORIAS__&SMacrorregional_de_Sa%FAde=TODAS_AS_CATEGORIAS__&SRegi%E3o_Metropolitana=TODAS_AS_CATEGORIAS__&SSexo=TODAS_AS_CATEGORIAS__&pesqmes8=Digite+o+texto+e+ache+f%E1cil&SFaixa_Et%E1ria=TODAS_AS_CATEGORIAS__&formato=prn&mostre=Mostra"
    }, (err, $, code, html, resp)->
      inicio = html.indexOf('<PRE>')
      fim = html.indexOf('</PRE>')
      pre = html.slice(inicio+5, fim-4).trim().replace('&aacute;','a')

      faixas = pre.split('\n').map (e)->
        e.trim().split(';').map (e)-> e.trim().replace(/"/mg,'')

      csv =
        'data': new Buffer(( faixas.map (linha)-> linha.join ';' ).join('\n'), 'utf-8')
        'filename': "./data/faixa-sexo-#{estado.sigla}.csv"

      # console.log csv

      fs.writeFile csv.filename, csv.data, (fsErr) ->

        throw fsErr if fsErr

        miolo = faixas[1..-2]
        [..., total] = faixas

        miolo.forEach (faixa) ->
          nome = faixa[0]
          tH = faixa[1]
          tM = faixa[2]
          nH = Number tH.replace /\./gim, ''
          nM = Number tM.replace /\./gim, ''
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
          'homens': faixasEstado.faixas.reduce( ((memo, fx)-> memo += fx.homens) ,0)
          'mulheres': faixasEstado.faixas.reduce( ((memo, fx)-> memo += fx.mulheres) ,0)
          'total': faixasEstado.faixas.reduce( ((memo, fx)-> memo += fx.total) ,0)
        })

        final.push faixasEstado

        do next

  () ->
    # console.log util.inspect final, depth: 4, color: true


    # faixa1 = _.findWhere(final[0].faixas, intervalo: [1])

    # console.log util.inspect faixa1, depth: 4, color: true

    json =
      filename: './uf-faixaEtaria-sexo.coffee'
      data: "module.exports=#{JSON.stringify(final)}"

    fs.writeFile json.filename, json.data, (fsErr) ->
      throw fsErr if fsErr

)




