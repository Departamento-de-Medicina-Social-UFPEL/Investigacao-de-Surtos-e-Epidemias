requirejs.config
  # 'baseUrl': '/'
  'waitSeconds': 100
  'paths':
    'utils': 'js/lib/utils'
    'text': 'lib/requirejs-text/text'
    'async': 'lib/requirejs-plugins/src/async'
    'jquery': 'lib/jquery/dist/jquery'
    'underscore': 'lib/lodash/lodash'
    'backbone': 'lib/backbone/backbone'
    'backbone.marionette': 'lib/backbone.marionette/lib/backbone.marionette'
    'backbone.modal': 'lib/backbone-modal/backbone.modal'
    'marionette.modals': 'lib/backbone-modal/backbone.marionette.modals'
    'bootstrap': 'lib/bootstrap/dist/js/bootstrap'
    'socketio': 'lib/socket.io/socket.io'
    'ripples': 'lib/bootstrap-material-design/dist/js/ripples'
    'material': 'lib/bootstrap-material-design/dist/js/material'
    'lzs': 'lib/lz-string-bower/lz-string'
    # -- App --
    'casca': 'js/app/main'
    'router': 'js/app/router'
    'controller': 'js/app/controller'

  'map': '*': 'marionette': 'backbone.marionette'

  'shim':
    'socketio': exports: 'io'
    'lzs': exports: 'LZString'
    'bootstrap': 'deps': ['jquery']
    'material': 'deps': ['bootstrap']
    'ripples': 'deps': ['bootstrap', 'material']

    'casca': 'deps': ['backbone.marionette', 'material', 'ripples']