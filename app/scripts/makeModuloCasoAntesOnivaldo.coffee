moment = require 'moment'
extend = require 'extend'
_ = require 'underscore'
module.exports = (caso)->
  'name': 'Caso clínico'
  'navigateOnStart': 'comp/caso-progresso-single'
  'shortname': [ "#{caso.shortname}" ]
  'customTitleBrand': "<span class='hidden-xs'>Caso Clínico </span>#{caso.titulo}"
  # 'customTitleBrand': "#{caso.titulo}"
  'style':
    '.navbar-inverse': [ 'background: #f5821f!important' ]
    '.big-footer': [ 'background: #337AB7' ]
  'showComponentMenu': true
  'components': [
    {
      'folder': 'intro'
      'short': 'Introduz'
      'title': 'Abertura'
      'categories': [ 'infraestrutura' ]
      'hidemenu': true
    }
    {
      'folder': 'local-storage-standalone'
      'short': 'Local Storage'
      'title': 'Local Data Storage'
      'categories': [ 'infraestrutura' ]
      'hidemenu': true
    }
    {
      'folder': 'progresso-standalone'
      'short': 'Progresso'
      'title': 'Monitor Progresso'
      'categories': [ 'infraestrutura' ]
      'hidemenu': true
    }
    {
      'folder': 'terminal-footer'
      'short': 'rodape'
      'title': 'rodape'
      'categories': [ 'infraestrutura' ]
      'hidemenu': true
    }
    {
      'folder': 'idle-warn'
      'short': 'Inatividade'
      'title': 'Controle de Inatividade'
      'categories': [ 'infraestrutura' ]
      'hidemenu': true
    }
    {
      'folder': 'caso-progresso-single'
      'short': 'Caso Clínico'
      'title': 'Um Caso'
      'resource': [caso]
      'categories': [ 'ferramenta' ]
      'externalResources': true
      'ref': 'casos'
      'oid': '559ADC1A04730DE294C6B7FB'
      'hidemenu': true
    }
  ]