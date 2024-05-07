Progressos = require '../models/progressos'
async = require 'async'
_ = require 'lodash'

nDisUsers = 0
processados = 0
respostasDist = 0
velhas = 0
velhas_ativas = 0
inicio = 0

init = ()->
  console.log 'Respostas ativas ou inativas velhas'
  inicio = Date.now()
  Progressos.find()
  .distinct 'user', (err, cpfs) ->
    # pool = cpfs[0...50]
    pool = cpfs
    nDisUsers = pool.length
    console.log """
    Verificando #{nDisUsers} usuários..."""
    async.each pool, achaVelhas, fim

achaVelhas = (cpf, next) ->
  Progressos
  .find {user: cpf}
  .sort '-createdAt'
  .exec (err, progressos) ->
    respostasDist = respostasDist + progressos.length
    filtradas = []
    atividades = _.groupBy progressos, 'atividade'
    return next null unless progressos.length > 0
    for id_ativ, atividade of atividades
      questoes = _.groupBy atividade, 'seqid'
      for sid_quest, respostas of questoes
        # if respostas.length > 10 then console.log """
        # *** Mais de 10 vezes!!!!!!!
        # #{cpf} - #{id_ativ} (#{sid_quest}) - #{respostas.length}
        # """
        ordenaData = _.orderBy respostas, ['createdAt'], ['desc']
        [valida, invalidas...] = ordenaData
        filtradas.push valida
        velhas_ativas = velhas_ativas + invalidas.filter((i)-> i.ativo).length
        velhas = velhas + invalidas.length
    processados = processados + 1
    process.stdout.write """  #{ '☱☲☴'.split('')[processados%3]}\r"""
    throttlePrint()
    next null

fim = ->
  strTempo = hrTimeDiff inicio
  console.log "                                       \r"
  console.log """
  #{respostasDist} respostas verificadas em #{strTempo}
  #{velhas} respostas velhas (#{((velhas/respostasDist)*100).toFixed(2).replace('.',',')} % do total)
  #{velhas_ativas} respostas velhas ativas (#{((velhas_ativas/velhas)*100).toFixed(2).replace('.',',')} % do total)

  """
  process.exit 0

do init
# FUNCS
printProgress = ()->
  process.stdout.write """  #{ '☱☲☴'.split('')[processados%3]}  #{((processados / nDisUsers) * 100).toFixed(2).replace('.',',')} %   ( #{processados} / #{nDisUsers} )\r"""

throttlePrint = _.throttle printProgress, 300

hrTimeDiff = (inicio)->
  final = Date.now()
  fl = Math.floor
  rd = Math.round
  demora = Math.abs((final - inicio) / 1000)
  sec = demora % 60; demora /= 60
  min = demora % 60; demora /= 60
  hou = demora % 24; demora /= 24
  day = demora
  "#{
    if day > 1 then fl(day)+' dias ' else ''
  }#{
    if hou > 1 then fl(hou)+' horas ' else ''
  }#{
    if min > 1 then fl(min)+' minutos ' else ''
  }#{
    if sec > 1 then fl(sec)+' segundos ' else ''
  }#{
    if (sec - fl(sec)) > 0 then rd((sec - fl(sec))*1000)+' milésimos' else ''
  }"