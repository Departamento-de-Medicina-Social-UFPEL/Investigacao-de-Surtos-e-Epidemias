cdnjs = '//cdnjs.cloudflare.com/ajax/libs'
dms = '//dms.ufpel.edu.br'
requirejs.config
  'waitSeconds': 100
  'paths':
    'uf_municipios': "#{dms}/inscricoes/scripts/uf_municipios"
    'jquery': "#{cdnjs}/jquery/2.1.3/jquery.min"
    'underscore': "#{cdnjs}/underscore.js/1.8.2/underscore-min"
    'backbone': "#{cdnjs}/backbone.js/1.1.2/backbone-min"
    'marionette': "#{cdnjs}/backbone.marionette/2.4.2/backbone.marionette"
    'main': "js/main"

  'shim':
    'underscore': 'exports': '_'
    'backbone': 'deps': ['underscore', 'jquery'], 'exports': 'Backbone'
    'marionette': 'deps': ['underscore','backbone']
    'main': 'deps': ['backbone', 'marionette']

require ['main'], (MainApp)-> window.App = new MainApp

