
requirejs.config
  'baseUrl': '/casca'
  'waitSeconds': 50
  'urlArgs': 'v=147'
  'paths':
    'facebook': 'https://connect.facebook.net/en_US/sdk'
    'utils': 'js/lib/utils'
    'uf_municipios': 'js/lib/uf_municipios'
    'text': 'lib/requirejs-text/text.min'
    'async': 'lib/requirejs-plugins/src/async.min'
    'jquery': 'lib/jquery/dist/jquery.min'
    'jquery-ui': 'lib/jquery-ui/jquery-ui.min'
    'underscore': 'lib/lodash/lodash.min'
    'backbone': 'lib/backbone/backbone'
    'backbone.marionette': 'lib/backbone.marionette/lib/backbone.marionette.min'
    'backbone.modal': 'lib/backbone-modal/backbone.modal'
    'marionette.modals': 'lib/backbone-modal/backbone.marionette.modals'
    'bootstrap': 'lib/bootstrap/dist/js/bootstrap.min'
    'socketio': 'lib/socket.io/socket.io'
    'ripples': 'lib/bootstrap-material-design/dist/js/ripples.min'
    'material': 'lib/bootstrap-material-design/dist/js/material.min'
    'jknob': 'lib/jknob/js/jquery.knob'
    'lzs': 'lib/lz-string-bower/lz-string'
    # -- App --
    'casca': 'js/app/main'

  'map': '*': 'marionette': 'backbone.marionette'

  'shim':
    'facebook': exports: 'FB'
    'socketio': exports: 'io'
    'lzs': exports: 'LZString'
    'bootstrap': 'deps': ['jquery']
    'jquery-ui': 'deps': ['jquery']
    'material': 'deps': ['bootstrap']
    'ripples': 'deps': ['bootstrap', 'material', 'jquery-ui']
    'casca': 'deps': ['backbone.marionette', 'material', 'ripples']

require [
  'casca'
  'js/app/router'
  'js/app/controller'
], (CascaApp, CascaAppRouter, CascaController)->


  do $.material.init

  router = new CascaAppRouter
    'controller': CascaController

  window.App = new CascaApp
    'appRouter': router

  dtAtual = new Date()
  window.modulo.ofertasAbertas = window.modulo.ofertas.filter (o)->
    if not o.data_fim_matricula
      return false
    return (dtAtual >= (new Date(o.data_inicio)) and (new Date(o.data_fim_matricula)) >= dtAtual)

  modularComponentsCasca = window.modulo.components.map (component)->
    "js/components/#{component.folder}/main"

  require modularComponentsCasca, ()->
    compArr = window.modulo.components
    for idx, component of arguments
      name = compArr[idx].folder
      window.App.module name, component
      # do window.App[name].start
    do window.App.start
