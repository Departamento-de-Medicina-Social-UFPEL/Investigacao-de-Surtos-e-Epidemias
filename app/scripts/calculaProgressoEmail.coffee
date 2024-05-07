Progressos = require '../models/progressos'
Usuarios = require '../models/usuarios'
verificaAprovacao = require '/home/dev/arouca/app/scripts/verificaAprovacao'
verificaAprovacaoMaad = require '/home/dev/arouca/app/scripts/verificaAprovacaoMaad'
async = require 'async'
_ = require 'lodash'

options = process.argv

modulo = 'paliativo'
modulo = options[2]
emails = options[3]


if /,/img.test emails
  emails = emails.split(',')
else
  emails = [emails]
total = 0
processados = 0
t_inicio = 0
resultado = []

init = ()->
  console.log 'Progresso do(s) email(s)'
  console.log "#{emails.join(',')}"
  t_inicio = Date.now()
  Usuarios.find
    email:
      $in: emails
  .exec (err, users)->
    throw err if err
    console.log users
    resultado = users
    pool = users
    total = pool.length
    console.log """
    Verificando #{total} progressos..."""
    async.each pool, confereProgresso, fim

confereProgresso = (user, next) ->
  console.log modulo, user.cpf
  if modulo == 'idoso'
    verificaAprovacaoMaad user.cpf, (aprovado, usr)->
      processados = processados + 1
      process.stdout.write """  #{ '☱☲☴'.split('')[processados%3]}\r"""
      throttlePrint()
      next null
  else
    verificaAprovacao modulo, user.cpf, (aprovado, usr)->
      processados = processados + 1
      process.stdout.write """  #{ '☱☲☴'.split('')[processados%3]}\r"""
      throttlePrint()
      next null

fim = ->
  strTempo = hrTimeDiff t_inicio
  console.log "                                       \r"
  console.log """


  """
  process.exit 0

do init
# FUNCS
printProgress = ()->
  process.stdout.write """  #{ '☱☲☴'.split('')[processados%3]}  #{((processados / total) * 100).toFixed(2).replace('.',',')} %   ( #{processados} / #{total} )\r"""

throttlePrint = _.throttle printProgress, 300

hrTimeDiff = (t_inicio)->
  final = Date.now()
  fl = Math.floor
  rd = Math.round
  demora = Math.abs((final - t_inicio) / 1000)
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