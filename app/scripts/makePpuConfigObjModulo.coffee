moment = require 'moment'
extend = require 'extend'
_ = require 'underscore'
module.exports = (caso)->
  acronym = 'UFPEL'
  ehModCasoIsolado = true
  oid = caso._id.toString()
  tsCria = parseInt(oid.slice(0,8), 16)
  dataCria = moment(tsCria, 'X').format 'YYYY-MM-DD'
  dataRev = moment().format 'YYYY-MM-DD'
  video = null
  if not caso.shortname
    throw "Casos sem shortname"
  short = "modulo-#{caso.shortname}"
  namespace = short.toUpperCase().replace /[^A-Z]*/img, ''
  console.log 'make obj', namespace
  # console.log short
  # persistence = not ehModCasoIsolado
  persistence = true
  pack =
    'Package': if persistence then 'CI1' else 'CI0'

  pack = extend on, pack,
    'Institution':
      'AroucaID': 46
      'Acronym': acronym
      'Name': 'Universidade Federal de Pelotas'

  pack = extend on, pack,
    'Resource':
      'Name': "Caso Clínico: #{caso.name}"
      'Language': 'pt-BR'
      'CreationDate': dataCria
      'Review': 1
      'ReviewDate': dataRev
      'CoverImage': 'capa.png',
      'ThumbnailImage': 'capa_thumb.png'

  pack = extend on, pack,
    'Reviews': [{
        'Review': 0
        'ReviewDate': dataRev
        'Info': 'Versão inicial do recurso'
      }]

  pack = extend on, pack,
    'SupportedDevices': [
      'SmartPhone'
      'Tablet'
      'Desktop'
    ]

  pack = extend on, pack,
    'Video': (->
      if video
        return {
          'Formats': _.uniq(video.sources.map (s)-> s.extension)
          'Resolutions': _.uniq(video.sources.map (s)-> s.resolution)
        }
      'Formats': [ ]
      'Resolutions': [ ]
    )()

  if persistence
    pack = extend on, pack,
      'Persistence':
        'InstitutionAcronym': acronym
        'Version': '0001'
        'Name': namespace
        'LTIValue': true
      'Dictionary': [
        {
          'Variable': 'STATUS'
          'Info': 'Variável padrão, indica o status do recurso.'
          'Attributes': [
            { 'status': "Valor nominal textual do status podendo ter os seguintes valores 'attended', 'attempted', 'completed', 'passed', 'failed'" }
            { 'percentage': 'Valor inteiro entre 0 e 100, formado por 20% para o acesso a cada unidade e 10% para a visualização completa de cada video' }
            { 'LTIvalue': "Valor ponto flutuante entre 0 e 1, dado pela soma total de pontos das unidades + 10 pontos para cada video visualizado completamente, dividido por 100" }
          ]
        }
      ]
    if video
      pack.Dictionary[0].Attributes.push({ 'videoresolution': "Valor textual, deve estar entre os valores disponíveis no recurso, com base no arquivo de configuração se_unasus_pack.json, exemplo '360p'" })
      pack.Dictionary.push
        "Variable": "VIDEO_1"
        "Info": "Vídeo de Apresentação do Módulo"
        "Attributes": [
          {
            "nome": "Nome do video"
            "duration": "Duração total do video em segundos"
            "currentTime": "Tempo do video em segundos no instante da ação"
            "action": "Ação realizada, pode ser 'paused', 'play', 'ended'"
          }
        ]

  pack